const pool = require("../db");

// =============================
// GET ALL CATEGORIES
// GET /api/categories
// =============================
exports.getAllCategories = async (req, res) => {
  try {
    const [rows] = await pool.query(
      `SELECT id, name, description
       FROM categories
       ORDER BY name`
    );

    res.json({
      success: true,
      data: rows,
    });
  } catch (err) {
    console.error("Get categories error:", err);

    res.status(500).json({
      success: false,
      message: "Gagal mengambil data kategori.",
    });
  }
};