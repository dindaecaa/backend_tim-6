require("dotenv").config();

const express = require("express");
const cors = require("cors");
const pool = require("./db");

const app = express();
const PORT = process.env.PORT || 3001;

// Middleware
app.use(cors());
app.use(express.json());

// Import routes
const authRoutes = require("./routes/authRoutes");
const productRoutes = require("./routes/productRoutes");
const categoryRoutes = require("./routes/categoryRoutes");
const stockMovementRoutes = require("./routes/stockMovementRoutes");
const dashboardRoutes = require("./routes/dashboardRoutes");

// Home
app.get("/", (req, res) => {
  res.json({
    success: true,
    message: "Stock.co API berjalan!",
  });
});

// Health check
app.get("/api/health", (req, res) => {
  res.json({
    success: true,
    message: "API sehat dan berjalan.",
  });
});

// Database test
app.get("/api/db-test", async (req, res) => {
  try {
    const [rows] = await pool.query(
      "SELECT VERSION() AS version, DATABASE() AS database_name"
    );

    res.json({
      success: true,
      message: "Koneksi database berhasil.",
      data: rows[0],
    });
  } catch (err) {
    console.error("Database test error:", err);

    res.status(500).json({
      success: false,
      message: "Koneksi database gagal.",
    });
  }
});

// Register routes
app.use("/api/auth", authRoutes);
app.use("/api/products", productRoutes);
app.use("/api/categories", categoryRoutes);
app.use("/api/stock-movements", stockMovementRoutes);
app.use("/api/dashboard", dashboardRoutes);

// Start server
app.listen(PORT, "0.0.0.0", () => {
  console.log(`Stock.co API berjalan di http://localhost:${PORT}`);
});