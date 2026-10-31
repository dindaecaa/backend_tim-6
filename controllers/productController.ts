
import type { Request, Response } from "express";
import type {
  ResultSetHeader,
  RowDataPacket,
} from "mysql2";
import pool from "../db";

interface ProductRow extends RowDataPacket {
  id: number;
  category_id: number | null;
  name: string;
  sku: string;
  description: string | null;
  stock: number;
  unit: string;
  price: number;
  location: string | null;
  created_at: Date;
  updated_at: Date;
  category_name?: string | null;
}

interface CategoryRow extends RowDataPacket {
  id: number;
  name: string;
}

interface ProductBody {
  name?: unknown;
  sku?: unknown;
  description?: unknown;
  stock?: unknown;
  unit?: unknown;
  price?: unknown;
  category?: unknown;
  category_id?: unknown;
  location?: unknown;
}

type IdParams = {
  id: string;
};

// GET ALL PRODUCTS
export const getAllProducts = async (
  _req: Request,
  res: Response
): Promise<void> => {
  try {
    const [rows] = await pool.query<ProductRow[]>(`
      SELECT
        p.id,
        p.category_id,
        p.name,
        p.sku,
        p.description,
        p.stock,
        p.unit,
        p.price,
        p.location,
        p.created_at,
        p.updated_at,
        c.name AS category_name
      FROM products p
      LEFT JOIN categories c ON p.category_id = c.id
      ORDER BY p.id DESC
    `);

    res.json({
      success: true,
      data: rows,
    });
  } catch (err: unknown) {
    console.error("Get products error:", err);
    res.status(500).json({
      success: false,
      message: "Gagal mengambil data produk.",
    });
  }
};

// GET PRODUCT BY ID
export const getProductById = async (
  req: Request<IdParams>,
  res: Response
): Promise<void> => {
  try {
    const [rows] = await pool.execute<ProductRow[]>(
      `SELECT
        p.*,
        c.name AS category_name
       FROM products p
       LEFT JOIN categories c ON p.category_id = c.id
       WHERE p.id = ?`,
      [req.params.id]
    );

    if (rows.length === 0) {
      res.status(404).json({
        success: false,
        message: "Produk tidak ditemukan.",
      });
      return;
    }

    res.json({
      success: true,
      data: rows[0],
    });
  } catch (err: unknown) {
    console.error("Get product error:", err);
    res.status(500).json({
      success: false,
      message: "Gagal mengambil detail produk.",
    });
  }
};

// CREATE PRODUCT
export const createProduct = async (
  req: Request<object, object, ProductBody>,
  res: Response
): Promise<void> => {
  let connection:
    | Awaited<ReturnType<typeof pool.getConnection>>
    | undefined;

  let transactionStarted = false;

  try {
    const {
      name,
      sku,
      description = "",
      stock,
      unit = "pcs",
      price = 0,
      category,
      category_id,
      location,
    } = req.body || {};

    if (
      typeof name !== "string" ||
      !name.trim() ||
      stock === undefined ||
      !Number.isInteger(Number(stock)) ||
      Number(stock) < 0
    ) {
      res.status(400).json({
        success: false,
        message: "Nama produk dan stok yang valid wajib diisi.",
      });
      return;
    }

    if (
      typeof price !== "number" &&
      typeof price !== "string"
    ) {
      res.status(400).json({
        success: false,
        message: "Harga produk tidak valid.",
      });
      return;
    }

    if (!Number.isFinite(Number(price)) || Number(price) < 0) {
      res.status(400).json({
        success: false,
        message: "Harga produk tidak valid.",
      });
      return;
    }

    connection = await pool.getConnection();
    await connection.beginTransaction();
    transactionStarted = true;

    let categoryId: number | null =
      category_id === undefined ||
      category_id === null ||
      category_id === ""
        ? null
        : Number(category_id);

    if (
      categoryId !== null &&
      (!Number.isInteger(categoryId) || categoryId <= 0)
    ) {
      await connection.rollback();
      transactionStarted = false;

      res.status(400).json({
        success: false,
        message: "Kategori produk tidak valid.",
      });
      return;
    }

    if (typeof category === "string" && category.trim()) {
      const [existing] = await connection.execute<CategoryRow[]>(
        "SELECT id, name FROM categories WHERE name = ? LIMIT 1",
        [category.trim()]
      );

      if (existing.length > 0) {
        categoryId = existing[0].id;
      } else {
        const [newCategory] =
          await connection.execute<ResultSetHeader>(
            "INSERT INTO categories (name, description) VALUES (?, ?)",
            [category.trim(), ""]
          );

        categoryId = newCategory.insertId;
      }
    }

    const finalSku =
      typeof sku === "string" && sku.trim()
        ? sku.trim()
        : `SKU-${Date.now()}`;

    const finalDescription =
      typeof description === "string" ? description : "";

    const finalUnit =
      typeof unit === "string" && unit.trim()
        ? unit.trim()
        : "pcs";

    const finalLocation =
      typeof location === "string" && location.trim()
        ? location.trim()
        : null;

    const [result] = await connection.execute<ResultSetHeader>(
      `INSERT INTO products
       (category_id, name, sku, description, stock, unit, price, location)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        categoryId,
        name.trim(),
        finalSku,
        finalDescription,
        Number(stock),
        finalUnit,
        Number(price),
        finalLocation,
      ]
    );

    await connection.commit();
    transactionStarted = false;

    res.status(201).json({
      success: true,
      message: "Produk berhasil ditambahkan.",
      id: result.insertId,
    });
  } catch (err: unknown) {
    if (connection && transactionStarted) {
      try {
        await connection.rollback();
      } catch (rollbackError: unknown) {
        console.error("Rollback error:", rollbackError);
      }
    }

    console.error("Create product error:", err);
    res.status(500).json({
      success: false,
      message: "Gagal menambahkan produk.",
    });
  } finally {
    if (connection) {
      connection.release();
    }
  }
};

// UPDATE PRODUCT
export const updateProduct = async (
  req: Request<IdParams, object, ProductBody>,
  res: Response
): Promise<void> => {
  try {
    const { name, category_id, price, stock } = req.body || {};

    if (
      typeof name !== "string" ||
      !name.trim() ||
      !Number.isInteger(Number(stock)) ||
      Number(stock) < 0 ||
      !Number.isFinite(Number(price)) ||
      Number(price) < 0
    ) {
      res.status(400).json({
        success: false,
        message: "Data nama, harga, atau stok tidak valid.",
      });
      return;
    }

    const normalizedCategoryId =
      category_id === "" || category_id === undefined
        ? null
        : category_id === null
          ? null
          : Number(category_id);

    if (
      normalizedCategoryId !== null &&
      (!Number.isInteger(normalizedCategoryId) ||
        normalizedCategoryId <= 0)
    ) {
      res.status(400).json({
        success: false,
        message: "Kategori produk tidak valid.",
      });
      return;
    }

    const [result] = await pool.execute<ResultSetHeader>(
      `UPDATE products
       SET name = ?,
           category_id = ?,
           price = ?,
           stock = ?,
           updated_at = CURRENT_TIMESTAMP
       WHERE id = ?`,
      [
        name.trim(),
        normalizedCategoryId,
        Number(price),
        Number(stock),
        req.params.id,
      ]
    );

    if (result.affectedRows === 0) {
      res.status(404).json({
        success: false,
        message: "Produk tidak ditemukan.",
      });
      return;
    }

    res.json({
      success: true,
      message: "Produk berhasil diperbarui.",
    });
  } catch (err: unknown) {
    console.error("Update product error:", err);
    res.status(500).json({
      success: false,
      message: "Gagal memperbarui produk.",
    });
  }
};

// DELETE PRODUCT
export const deleteProduct = async (
  req: Request<IdParams>,
  res: Response
): Promise<void> => {
  try {
    const [result] = await pool.execute<ResultSetHeader>(
      "DELETE FROM products WHERE id = ?",
      [req.params.id]
    );

    if (result.affectedRows === 0) {
      res.status(404).json({
        success: false,
        message: "Produk tidak ditemukan.",
      });
      return;
    }

    res.json({
      success: true,
      message: "Produk berhasil dihapus.",
    });
  } catch (err: unknown) {
    console.error("Delete product error:", err);
    res.status(500).json({
      success: false,
      message: "Gagal menghapus produk.",
    });
  }
};
