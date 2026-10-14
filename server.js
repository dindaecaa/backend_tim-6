
require("dotenv").config();

const express = require("express");
const cors = require("cors");
const pool = require("./db");

const app = express();
const PORT = process.env.PORT || 3001;

app.use(cors());
app.use(express.json());

// ============================================
// 1. CEK BACKEND
// ============================================

app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "Backend StockCo berjalan!",
  });
});

// ============================================
// 2. CEK API
// ============================================

app.get("/api/health", (req, res) => {
  res.json({
    success: true,
    message: "API berjalan normal.",
  });
});

// ============================================
// 3. CEK KONEKSI DATABASE
// ============================================

app.get("/api/db-test", async (req, res) => {
  try {
    const [rows] = await pool.query(
      "SELECT VERSION() AS version, DATABASE() AS databaseName"
    );

    res.json({
      connected: true,
      databaseVersion: rows[0].version,
      databaseName: rows[0].databaseName,
    });
  } catch (error) {
    console.error("Database error:", error.message);

    res.status(500).json({
      connected: false,
      message: "Koneksi database gagal.",
      error: error.message,
    });
  }
});

// ============================================
// 4. AMBIL SEMUA KATEGORI
// ============================================

app.get("/api/categories", async (req, res) => {
  try {
    const [rows] = await pool.query(
      "SELECT id, name, description FROM categories ORDER BY name"
    );

    res.json({
      success: true,
      data: rows,
    });
  } catch (error) {
    console.error("Gagal mengambil kategori:", error.message);

    res.status(500).json({
      success: false,
      message: "Gagal mengambil data kategori.",
    });
  }
});

// ============================================
// 5. AMBIL SEMUA PRODUK / SKU
// ============================================

app.get("/api/products", async (req, res) => {
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
  } catch (error) {
    console.error("Gagal mengambil produk:", error.message);

    res.status(500).json({
      success: false,
      message: "Gagal mengambil data produk.",
    });
  }
});

// ============================================
// 6. AMBIL PRODUK BERDASARKAN ID
// ============================================

app.get("/api/products/:id", async (req, res) => {
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

    if (rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: "Produk tidak ditemukan.",
      });
    }

    res.json({
      success: true,
      data: rows[0],
    });
  } catch (error) {
    console.error("Gagal mengambil produk:", error.message);

    res.status(500).json({
      success: false,
      message: "Gagal mengambil data produk.",
    });
  }
});

// ============================================
// 7. TAMBAH PRODUK / SKU
// ============================================

app.post("/api/products", async (req, res) => {
  const connection = await pool.getConnection();
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
    } = req.body;

    // Validasi nama
    if (!name || !name.trim()) {
      return res.status(400).json({
        success: false,
        message: "Nama barang wajib diisi.",
      });
    }

    // Validasi kategori
    if (
      (!category || !category.trim()) &&
      !category_id
    ) {
      return res.status(400).json({
        success: false,
        message: "Kategori wajib dipilih.",
      });
    }

    // Validasi stok
    if (
      stock === undefined ||
      stock === null ||
      stock === "" ||
      !Number.isInteger(Number(stock)) ||
      Number(stock) < 0
    ) {
      return res.status(400).json({
        success: false,
        message: "Stok harus berupa bilangan bulat minimal 0.",
      });
    }

    // Validasi harga
    if (
      !Number.isFinite(Number(price)) ||
      Number(price) < 0
    ) {
      return res.status(400).json({
        success: false,
        message: "Harga tidak valid.",
      });
    }

    await connection.beginTransaction();
    transactionStarted = true;

    let categoryId = category_id || null;

    // Cari atau buat kategori berdasarkan nama
    if (category && category.trim()) {
      const [existingCategories] = await connection.execute(
        "SELECT id FROM categories WHERE name = ? LIMIT 1",
        [category.trim()]
      );

      if (existingCategories.length > 0) {
        categoryId = existingCategories[0].id;
      } else {
        const [newCategory] = await connection.execute(
          "INSERT INTO categories (name, description) VALUES (?, ?)",
          [category.trim(), ""]
        );

        categoryId = newCategory.insertId;
      }
    }

    // Jika kode SKU tidak diisi, buat kode otomatis
    const finalSku =
      sku && sku.trim()
        ? sku.trim()
        : `SKU-${Date.now()}`;

    // Simpan produk
    const [result] = await connection.execute(
      `INSERT INTO products
        (
          category_id,
          name,
          sku,
          description,
          stock,
          unit,
          price,
          location
        )
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        categoryId,
        name.trim(),
        finalSku,
        description,
        Number(stock),
        unit,
        Number(price),
        location ? location.trim() : null,
      ]
    );

    await connection.commit();
    transactionStarted = false;

    res.status(201).json({
      success: true,
      message: "SKU berhasil ditambahkan.",
      data: {
        id: result.insertId,
        category_id: categoryId,
        name: name.trim(),
        sku: finalSku,
        description,
        stock: Number(stock),
        unit,
        price: Number(price),
        location: location ? location.trim() : null,
      },
    });
  } catch (error) {
    if (transactionStarted) {
      await connection.rollback();
    }

    console.error("Gagal menambahkan SKU:", error.message);

    res.status(500).json({
      success: false,
      message: "Gagal menyimpan SKU ke database.",
      error: error.message,
    });
  } finally {
    connection.release();
  }
});

// ============================================
// 8. UPDATE PRODUK / SKU
// ============================================

app.put("/api/products/:id", async (req, res) => {
  const connection = await pool.getConnection();
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
    } = req.body;

    if (!name || !name.trim()) {
      return res.status(400).json({
        success: false,
        message: "Nama barang wajib diisi.",
      });
    }

    if (
      stock === undefined ||
      stock === null ||
      stock === "" ||
      !Number.isInteger(Number(stock)) ||
      Number(stock) < 0
    ) {
      return res.status(400).json({
        success: false,
        message: "Stok harus berupa bilangan bulat minimal 0.",
      });
    }

    if (
      !Number.isFinite(Number(price)) ||
      Number(price) < 0
    ) {
      return res.status(400).json({
        success: false,
        message: "Harga tidak valid.",
      });
    }

    await connection.beginTransaction();
    transactionStarted = true;

    let categoryId = category_id || null;

    if (category && category.trim()) {
      const [existingCategories] = await connection.execute(
        "SELECT id FROM categories WHERE name = ? LIMIT 1",
        [category.trim()]
      );

      if (existingCategories.length > 0) {
        categoryId = existingCategories[0].id;
      } else {
        const [newCategory] = await connection.execute(
          "INSERT INTO categories (name, description) VALUES (?, ?)",
          [category.trim(), ""]
        );

        categoryId = newCategory.insertId;
      }
    }

    const [result] = await connection.execute(
      `UPDATE products
       SET
         category_id = ?,
         name = ?,
         sku = ?,
         description = ?,
         stock = ?,
         unit = ?,
         price = ?,
         location = ?,
         updated_at = CURRENT_TIMESTAMP
       WHERE id = ?`,
      [
        categoryId,
        name.trim(),
        sku,
        description,
        Number(stock),
        unit,
        Number(price),
        location ? location.trim() : null,
        req.params.id,
      ]
    );

    if (result.affectedRows === 0) {
      const [existing] = await connection.execute(
        "SELECT id FROM products WHERE id = ?",
        [req.params.id]
      );

      if (existing.length === 0) {
        await connection.rollback();
        transactionStarted = false;

        return res.status(404).json({
          success: false,
          message: "Produk tidak ditemukan.",
        });
      }
    }

    await connection.commit();
    transactionStarted = false;

    res.json({
      success: true,
      message: "SKU berhasil diperbarui.",
    });
  } catch (error) {
    if (transactionStarted) {
      await connection.rollback();
    }

    console.error("Gagal memperbarui SKU:", error.message);

    res.status(500).json({
      success: false,
      message: "Gagal memperbarui SKU.",
      error: error.message,
    });
  } finally {
    connection.release();
  }
});

// ============================================
// 9. HAPUS PRODUK / SKU
// ============================================

app.delete("/api/products/:id", async (req, res) => {
  try {
    const [result] = await pool.execute(
      "DELETE FROM products WHERE id = ?",
      [req.params.id]
    );

    if (result.affectedRows === 0) {
      return res.status(404).json({
        success: false,
        message: "Produk tidak ditemukan.",
      });
    }

    res.json({
      success: true,
      message: "SKU berhasil dihapus.",
    });
  } catch (error) {
    console.error("Gagal menghapus SKU:", error.message);

    res.status(500).json({
      success: false,
      message:
        "SKU tidak dapat dihapus. Periksa apakah barang sudah memiliki riwayat stok.",
    });
  }
});


/* ============================================
   10. TRANSAKSI STOK MASUK DAN STOK KELUAR
============================================ */

app.post("/api/stock-movements", async (req, res) => {
  const { product_id, type, quantity, note = "" } = req.body;

  if (
    !Number.isInteger(Number(product_id)) ||
    Number(product_id) <= 0
  ) {
    return res.status(400).json({
      success: false,
      message: "Produk harus dipilih.",
    });
  }

  if (!["in", "out"].includes(type)) {
    return res.status(400).json({
      success: false,
      message: "Jenis transaksi harus in atau out.",
    });
  }

  if (
    quantity === undefined ||
    quantity === null ||
    quantity === "" ||
    !Number.isInteger(Number(quantity)) ||
    Number(quantity) <= 0
  ) {
    return res.status(400).json({
      success: false,
      message: "Jumlah harus berupa bilangan bulat lebih dari 0.",
    });
  }

  const productId = Number(product_id);
  const qty = Number(quantity);
  const connection = await pool.getConnection();
  let transactionStarted = false;

  try {
    await connection.beginTransaction();
    transactionStarted = true;

    // Kunci baris produk selama transaksi berlangsung
    const [products] = await connection.execute(
      "SELECT id, name, stock FROM products WHERE id = ? FOR UPDATE",
      [productId]
    );

    if (products.length === 0) {
      await connection.rollback();
      transactionStarted = false;

      return res.status(404).json({
        success: false,
        message: "Produk tidak ditemukan.",
      });
    }

    const product = products[0];

    // Cegah stok keluar melebihi stok tersedia
    if (type === "out" && product.stock < qty) {
      await connection.rollback();
      transactionStarted = false;

      return res.status(400).json({
        success: false,
        message: `Stok tidak cukup. Stok tersedia: ${product.stock}.`,
      });
    }

    const stockChange = type === "in" ? qty : -qty;

    await connection.execute(
      `UPDATE products
       SET stock = stock + ?, updated_at = CURRENT_TIMESTAMP
       WHERE id = ?`,
      [stockChange, productId]
    );

    // Simpan riwayat. user_id sementara NULL
    // sampai autentikasi login dihubungkan.
    const [movement] = await connection.execute(
      `INSERT INTO stock_movements
       (product_id, user_id, type, quantity, note)
       VALUES (?, NULL, ?, ?, ?)`,
      [productId, type, qty, String(note || "").trim() || null]
    );

    await connection.commit();
    transactionStarted = false;

    res.status(201).json({
      success: true,
      message:
        type === "in"
          ? "Stok masuk berhasil dicatat."
          : "Stok keluar berhasil dicatat.",
      data: {
        id: movement.insertId,
        product_id: productId,
        product_name: product.name,
        type,
        quantity: qty,
        stock_before: product.stock,
        stock_after: product.stock + stockChange,
      },
    });
  } catch (error) {
    if (transactionStarted) {
      await connection.rollback();
    }

    console.error("Gagal mencatat transaksi stok:", error.message);

    res.status(500).json({
      success: false,
      message: "Gagal mencatat transaksi stok.",
    });
  } finally {
    connection.release();
  }
});


/* ============================================
   11. RIWAYAT STOK
============================================ */

app.get("/api/stock-movements", async (req, res) => {
  try {
    const { type, product_id, limit = "100" } = req.query;
    const parsedLimit = Number(limit);

    if (
      !Number.isInteger(parsedLimit) ||
      parsedLimit < 1 ||
      parsedLimit > 500
    ) {
      return res.status(400).json({
        success: false,
        message: "Limit harus antara 1 sampai 500.",
      });
    }

    if (type && !["in", "out"].includes(type)) {
      return res.status(400).json({
        success: false,
        message: "Filter jenis transaksi tidak valid.",
      });
    }

    const conditions = [];
    const params = [];

    if (type) {
      conditions.push("sm.type = ?");
      params.push(type);
    }

    if (product_id !== undefined) {
      if (
        !Number.isInteger(Number(product_id)) ||
        Number(product_id) <= 0
      ) {
        return res.status(400).json({
          success: false,
          message: "ID produk tidak valid.",
        });
      }

      conditions.push("sm.product_id = ?");
      params.push(Number(product_id));
    }

    const whereClause = conditions.length
      ? `WHERE ${conditions.join(" AND ")}`
      : "";

    params.push(parsedLimit);

    const [rows] = await pool.execute(
      `SELECT
         sm.id,
         sm.product_id,
         sm.user_id,
         sm.type,
         sm.quantity,
         sm.note,
         sm.created_at,
         p.name AS product_name,
         p.sku,
         p.unit,
         u.name AS user_name
       FROM stock_movements sm
       JOIN products p ON p.id = sm.product_id
       LEFT JOIN users u ON u.id = sm.user_id
       ${whereClause}
       ORDER BY sm.created_at DESC, sm.id DESC
       LIMIT ?`,
      params
    );

    res.json({
      success: true,
      data: rows,
    });
  } catch (error) {
    console.error("Gagal mengambil riwayat:", error.message);

    res.status(500).json({
      success: false,
      message: "Gagal mengambil riwayat stok.",
    });
  }
});


/* ============================================
   12. DASHBOARD DAN DATA GRAFIK
============================================ */

app.get("/api/dashboard", async (req, res) => {
  try {
    const [[summary]] = await pool.query(`
      SELECT
        COUNT(*) AS total_sku,
        COALESCE(SUM(stock), 0) AS total_stock,
        COALESCE(SUM(CASE WHEN stock = 0 THEN 1 ELSE 0 END), 0)
          AS out_of_stock,
        COALESCE(SUM(CASE WHEN stock > 0 AND stock <= 5
          THEN 1 ELSE 0 END), 0) AS low_stock
      FROM products
    `);

    const [[movementSummary]] = await pool.query(`
      SELECT
        COALESCE(SUM(CASE WHEN type = 'in'
          THEN quantity ELSE 0 END), 0) AS total_in,
        COALESCE(SUM(CASE WHEN type = 'out'
          THEN quantity ELSE 0 END), 0) AS total_out
      FROM stock_movements
      WHERE created_at >= CURDATE()
        AND created_at < CURDATE() + INTERVAL 1 DAY
    `);

    // Grafik per hari untuk 7 hari terakhir, termasuk hari ini
    const [chartRows] = await pool.query(`
      SELECT
        DATE(created_at) AS date,
        COALESCE(SUM(CASE WHEN type = 'in'
          THEN quantity ELSE 0 END), 0) AS stock_in,
        COALESCE(SUM(CASE WHEN type = 'out'
          THEN quantity ELSE 0 END), 0) AS stock_out
      FROM stock_movements
      WHERE created_at >= CURDATE() - INTERVAL 6 DAY
        AND created_at < CURDATE() + INTERVAL 1 DAY
      GROUP BY DATE(created_at)
      ORDER BY date ASC
    `);

    const chartMap = new Map(
      chartRows.map((row) => [
        new Date(row.date).toISOString().slice(0, 10),
        {
          stock_in: Number(row.stock_in),
          stock_out: Number(row.stock_out),
        },
      ])
    );

    const chart = [];

    for (let i = 6; i >= 0; i--) {
      const date = new Date();
      date.setDate(date.getDate() - i);

      const dateKey = [
        date.getFullYear(),
        String(date.getMonth() + 1).padStart(2, "0"),
        String(date.getDate()).padStart(2, "0"),
      ].join("-");

      chart.push({
        date: dateKey,
        stock_in: chartMap.get(dateKey)?.stock_in || 0,
        stock_out: chartMap.get(dateKey)?.stock_out || 0,
      });
    }

    const [topProducts] = await pool.query(`
      SELECT id, name, sku, stock, unit
      FROM products
      ORDER BY stock ASC, name ASC
      LIMIT 5
    `);

    res.json({
      success: true,
      data: {
        summary: {
          total_sku: Number(summary.total_sku),
          total_stock: Number(summary.total_stock),
          out_of_stock: Number(summary.out_of_stock),
          low_stock: Number(summary.low_stock),
          stock_in_today: Number(movementSummary.total_in),
          stock_out_today: Number(movementSummary.total_out),
        },
        chart,
        lowest_stock_products: topProducts,
      },
    });
  } catch (error) {
    console.error("Gagal mengambil dashboard:", error.message);

    res.status(500).json({
      success: false,
      message: "Gagal mengambil statistik dashboard.",
    });
  }
});


// ============================================
// 13. JALANKAN SERVER
// ============================================




// ============================================
// 14. JALANKAN SERVER
// ============================================

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Backend berjalan di http://localhost:${PORT}`);
});
