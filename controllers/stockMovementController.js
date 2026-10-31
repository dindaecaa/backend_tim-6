const pool = require("../db");

// GET: Mengambil semua riwayat pergerakan stok
exports.getAllStockMovements = async (req, res) => {
  try {
    const [rows] = await pool.query(`
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
  } catch (err) {
    console.error("Get stock movements error:", err);

    res.status(500).json({
      success: false,
      message: "Gagal mengambil riwayat pergerakan stok.",
    });
  }
};

// POST: Menambahkan pergerakan stok masuk atau keluar
exports.createStockMovement = async (req, res) => {
  const { product_id, type, quantity, note } = req.body;

  // Validasi input
  if (
    !product_id ||
    !Number.isInteger(Number(quantity)) ||
    Number(quantity) <= 0 ||
    !["in", "out"].includes(type)
  ) {
    return res.status(400).json({
      success: false,
      message:
        "ID produk, tipe pergerakan (in/out), dan jumlah positif wajib diisi.",
    });
  }

  let connection;

  try {
    connection = await pool.getConnection();
    await connection.beginTransaction();

    // Ambil produk dan kunci baris selama transaksi
    const [products] = await connection.query(
      "SELECT id, stock FROM products WHERE id = ? FOR UPDATE",
      [product_id]
    );

    if (products.length === 0) {
      await connection.rollback();

      return res.status(404).json({
        success: false,
        message: "Produk tidak ditemukan.",
      });
    }

    const product = products[0];
    const amount = Number(quantity);

    // Validasi stok sebelum pengeluaran
    if (type === "out" && product.stock < amount) {
      await connection.rollback();

      return res.status(400).json({
        success: false,
        message: "Stok tidak mencukupi.",
      });
    }

    // Perbarui stok produk
    const newStock =
      type === "in"
        ? product.stock + amount
        : product.stock - amount;

    await connection.query(
      "UPDATE products SET stock = ? WHERE id = ?",
      [newStock, product_id]
    );

    // Simpan riwayat pergerakan stok
    const [result] = await connection.query(
      `INSERT INTO stock_movements
        (product_id, user_id, type, quantity, note)
       VALUES (?, NULL, ?, ?, ?)`,
      [product_id, type, amount, note || null]
    );

    await connection.commit();

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
  } catch (err) {
    if (connection) {
      await connection.rollback();
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