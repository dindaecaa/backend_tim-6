
import type { Request, Response } from "express";
import type { ResultSetHeader, RowDataPacket } from "mysql2";
import pool from "../db";

interface StockMovementRow extends RowDataPacket {
  id: number;
  product_id: number;
  product_name: string;
  type: "in" | "out";
  quantity: number;
  note: string | null;
  created_at: Date;
}

interface ProductRow extends RowDataPacket {
  id: number;
  stock: number;
}

interface StockMovementBody {
  product_id?: unknown;
  type?: unknown;
  quantity?: unknown;
  note?: unknown;
}

export const getAllStockMovements = async (
  _req: Request,
  res: Response
): Promise<void> => {
  try {
    const [rows] = await pool.query<StockMovementRow[]>(`
      SELECT
        sm.id,
        sm.product_id,
        p.name AS product_name,
        sm.type,
        sm.quantity,
        sm.note,
        sm.created_at
      FROM stock_movements sm
      JOIN products p ON sm.product_id = p.id
      ORDER BY sm.created_at DESC
    `);

    res.json({
      success: true,
      data: rows,
    });
  } catch (err: unknown) {
    console.error("Get stock movements error:", err);

    res.status(500).json({
      success: false,
      message: "Gagal mengambil riwayat pergerakan stok.",
    });
  }
};

export const createStockMovement = async (
  req: Request<object, object, StockMovementBody>,
  res: Response
): Promise<void> => {
  const { product_id, type, quantity, note } = req.body || {};

  // Validasi input
  if (
    (typeof product_id !== "string" &&
      typeof product_id !== "number") ||
    !Number.isInteger(Number(product_id)) ||
    Number(product_id) <= 0 ||
    (type !== "in" && type !== "out") ||
    (typeof quantity !== "string" &&
      typeof quantity !== "number") ||
    !Number.isInteger(Number(quantity)) ||
    Number(quantity) <= 0 ||
    (note !== undefined && note !== null && typeof note !== "string")
  ) {
    res.status(400).json({
      success: false,
      message:
        "ID produk, tipe pergerakan (in/out), dan jumlah positif wajib diisi.",
    });
    return;
  }

  let connection: Awaited<ReturnType<typeof pool.getConnection>> | undefined;
  let transactionStarted = false;

  try {
    connection = await pool.getConnection();
    await connection.beginTransaction();
    transactionStarted = true;

    // Ambil produk dan kunci baris selama transaksi
    const [products] = await connection.execute<ProductRow[]>(
      "SELECT id, stock FROM products WHERE id = ? FOR UPDATE",
      [Number(product_id)]
    );

    if (products.length === 0) {
      await connection.rollback();
      transactionStarted = false;

      res.status(404).json({
        success: false,
        message: "Produk tidak ditemukan.",
      });
      return;
    }

    const product = products[0];
    const amount = Number(quantity);

    // Validasi stok sebelum pengeluaran
    if (type === "out" && product.stock < amount) {
      await connection.rollback();
      transactionStarted = false;

      res.status(400).json({
        success: false,
        message: "Stok tidak mencukupi.",
      });
      return;
    }

    // Perbarui stok produk
    const newStock =
      type === "in"
        ? product.stock + amount
        : product.stock - amount;

    await connection.execute(
      "UPDATE products SET stock = ? WHERE id = ?",
      [newStock, Number(product_id)]
    );

    // Simpan riwayat pergerakan stok
    const [result] = await connection.execute<ResultSetHeader>(
      `INSERT INTO stock_movements
        (product_id, user_id, type, quantity, note)
       VALUES (?, NULL, ?, ?, ?)`,
      [
        Number(product_id),
        type,
        amount,
        typeof note === "string" && note.trim() ? note.trim() : null,
      ]
    );

    await connection.commit();
    transactionStarted = false;

    res.status(201).json({
      success: true,
      message: "Pergerakan stok berhasil ditambahkan.",
      data: {
        id: result.insertId,
        product_id: Number(product_id),
        type,
        quantity: amount,
        stock_before: product.stock,
        stock_after: newStock,
      },
    });
  } catch (err: unknown) {
    if (connection && transactionStarted) {
      try {
        await connection.rollback();
      } catch (rollbackError: unknown) {
        console.error("Rollback error:", rollbackError);
      }
    }

    console.error("Create stock movement error:", err);

    res.status(500).json({
      success: false,
      message: "Gagal menambahkan pergerakan stok.",
    });
  } finally {
    if (connection) {
      connection.release();
    }
  }
};
