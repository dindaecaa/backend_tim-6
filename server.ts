
import "dotenv/config";

import express from "express";
import cors from "cors";
import type { RowDataPacket } from "mysql2";
import pool from "./db";

import authRoutes from "./routes/authRoutes";
import productRoutes from "./routes/productRoutes";
import categoryRoutes from "./routes/categoryRoutes";
import stockMovementRoutes from "./routes/stockMovementRoutes";
import dashboardRoutes from "./routes/dashboardRoutes";

const app = express();
const PORT = Number(process.env.PORT || 3001);

// Middleware
app.use(cors());
app.use(express.json());

// Home
app.get("/", (_req, res) => {
  res.json({
    success: true,
    message: "Stock.co API berjalan!",
  });
});

// Health check
app.get("/api/health", (_req, res) => {
  res.json({
    success: true,
    message: "API sehat dan berjalan.",
  });
});

// Database test
app.get("/api/db-test", async (_req, res) => {
  try {
    const [rows] = await pool.query<RowDataPacket[]>(
      "SELECT VERSION() AS version, DATABASE() AS database_name"
    );

    res.json({
      success: true,
      message: "Koneksi database berhasil.",
      data: rows[0] ?? null,
    });
  } catch (err: unknown) {
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