
import type { Request, Response } from "express";
import type { RowDataPacket } from "mysql2";
import pool from "../db";

interface DashboardCountRow extends RowDataPacket {
  total_sku: number;
  total_stock: number;
  out_of_stock: number;
  low_stock: number;
}

// GET: Mengambil ringkasan data dashboard
export const getDashboard = async (
  _req: Request,
  res: Response
): Promise<void> => {
  try {
    const [[skuResult]] = await pool.query<DashboardCountRow[]>(
      "SELECT COUNT(*) AS total_sku FROM products"
    );

    const [[stockResult]] = await pool.query<DashboardCountRow[]>(
      "SELECT COALESCE(SUM(stock), 0) AS total_stock FROM products"
    );

    const [[outOfStockResult]] = await pool.query<DashboardCountRow[]>(
      "SELECT COUNT(*) AS out_of_stock FROM products WHERE stock = 0"
    );

    const [[lowStockResult]] = await pool.query<DashboardCountRow[]>(
      "SELECT COUNT(*) AS low_stock FROM products WHERE stock > 0 AND stock <= 10"
    );

    res.json({
      success: true,
      data: {
        total_sku: skuResult.total_sku,
        total_stock: stockResult.total_stock,
        out_of_stock: outOfStockResult.out_of_stock,
        low_stock: lowStockResult.low_stock,
      },
    });
  } catch (err: unknown) {
    console.error("Get dashboard error:", err);

    res.status(500).json({
      success: false,
      message: "Gagal mengambil data dashboard.",
    });
  }
};
