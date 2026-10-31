const pool = require("../db");

// GET: Mengambil ringkasan data dashboard
exports.getDashboard = async (req, res) => {
  try {
    const [[skuResult]] = await pool.query(
      "SELECT COUNT(*) AS total_sku FROM products"
    );

    const [[stockResult]] = await pool.query(
      "SELECT COALESCE(SUM(stock), 0) AS total_stock FROM products"
    );

    const [[outOfStockResult]] = await pool.query(
      "SELECT COUNT(*) AS out_of_stock FROM products WHERE stock = 0"
    );

    const [[lowStockResult]] = await pool.query(
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
  } catch (err) {
    console.error("Get dashboard error:", err);

    res.status(500).json({
      success: false,
      message: "Gagal mengambil data dashboard.",
    });
  }
};