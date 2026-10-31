
import { Router } from "express";
import { getAllCategories } from "../controllers/categoryController.js";

const router = Router();

// GET /api/categories
router.get("/", getAllCategories);

export default router;
