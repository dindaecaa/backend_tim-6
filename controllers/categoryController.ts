
import type { Request, Response } from "express";
import type { RowDataPacket } from "mysql2";
import pool from "../db";

interface CategoryRow extends RowDataPacket {
  id: number;
  name: string;
  description: string | null;
}

// GET ALL CATEGORIES
// GET /api/categories
export const getAllCategories = async (
  _req: Request,
  res: Response
): Promise<void> => {
  try {
    const [rows] = await pool.query<CategoryRow[]>(
      `SELECT id, name, description
       FROM categories
       ORDER BY name`
    );

    res.json({
      success: true,
      data: rows,
    });
  } catch (err: unknown) {
    console.error("Get categories error:", err);

    res.status(500).json({
      success: false,
      message: "Gagal mengambil data kategori.",
    });
  }
};
