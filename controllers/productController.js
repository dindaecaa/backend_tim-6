const pool = require("../db");

// =============================
// GET ALL PRODUCTS
// GET /api/products
// =============================
exports.getAllProducts = async (req, res) => {
  try {
    const [rows] = await pool.query(`
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
  } catch (err) {
    console.error("Get products error:", err);
    res.status(500).json({
      success: false,
      message: "Gagal mengambil data produk.",
    });
  }
};

// =============================
// GET PRODUCT BY ID
// GET /api/products/:id
// =============================
exports.getProductById = async (req, res) => {
  try {
    const [rows] = await pool.execute(
      `SELECT
        p.*,
        c.name AS category_name
       FROM products p
       LEFT JOIN categories c ON p.category_id = c.id
       WHERE p.id = ?`,
      [req.params.id]
    );

    if (!rows.length) {
      return res.status(404).json({
        success: false,
        message: "Produk tidak ditemukan.",
      });
    }

    res.json({
      success: true,
      data: rows[0],
    });
  } catch (err) {
    console.error("Get product error:", err);
    res.status(500).json({
      success: false,
      message: "Gagal mengambil detail produk.",
    });
  }
};

// =============================
// CREATE PRODUCT
// =============================
exports.createProduct = async (req, res) => {
  let connection;

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
    } = req.body;

    if (
      typeof name !== "string" ||
      !name.trim() ||
      stock === undefined ||
      !Number.isInteger(Number(stock)) ||
      Number(stock) < 0
    ) {
      return res.status(400).json({
        success: false,
        message: "Nama produk dan stok yang valid wajib diisi.",
      });
    }

    connection = await pool.getConnection();
    await connection.beginTransaction();

    let categoryId = category_id || null;

    if (category) {
      const [existing] = await connection.execute(
        "SELECT id FROM categories WHERE name = ? LIMIT 1",
        [category]
      );

      if (existing.length) {
        categoryId = existing[0].id;
      } else {
        const [newCategory] = await connection.execute(
          "INSERT INTO categories (name, description) VALUES (?, ?)",
          [category, ""]
        );

        categoryId = newCategory.insertId;
      }
    }

    const finalSku = sku || `SKU-${Date.now()}`;

    const [result] = await connection.execute(
      `INSERT INTO products
       (category_id, name, sku, description, stock, unit, price, location)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        categoryId,
        name.trim(),
        finalSku,
        description,
        Number(stock),
        unit,
        Number(price),
        location || null,
      ]
    );

    await connection.commit();

    res.status(201).json({
      success: true,
      message: "Produk berhasil ditambahkan.",
      id: result.insertId,
    });
  } catch (err) {
    if (connection) await connection.rollback();

    console.error("Create product error:", err);
    res.status(500).json({
      success: false,
      message: "Gagal menambahkan produk.",
    });
  } finally {
    if (connection) connection.release();
  }
};

// =============================
// UPDATE PRODUCT
// =============================
exports.updateProduct = async (req, res) => {
  try {
    const { name, category_id, price, stock } = req.body;

    const [result] = await pool.execute(
      `UPDATE products
       SET name = ?,
           category_id = ?,
           price = ?,
           stock = ?,
           updated_at = CURRENT_TIMESTAMP
       WHERE id = ?`,
      [name, category_id, price, stock, req.params.id]
    );

    if (!result.affectedRows) {
      return res.status(404).json({
        success: false,
        message: "Produk tidak ditemukan.",
      });
    }

    res.json({
      success: true,
      message: "Produk berhasil diperbarui.",
    });
  } catch (err) {
    console.error("Update product error:", err);
    res.status(500).json({
      success: false,
      message: "Gagal memperbarui produk.",
    });
  }
};

// =============================
// DELETE PRODUCT
// =============================
exports.deleteProduct = async (req, res) => {
  try {
    const [result] = await pool.execute(
      "DELETE FROM products WHERE id = ?",
      [req.params.id]
    );

    if (!result.affectedRows) {
      return res.status(404).json({
        success: false,
        message: "Produk tidak ditemukan.",
      });
    }

    res.json({
      success: true,
      message: "Produk berhasil dihapus.",
    });
  } catch (err) {
    console.error("Delete product error:", err);
    res.status(500).json({
      success: false,
      message: "Gagal menghapus produk.",
    });
  }
};