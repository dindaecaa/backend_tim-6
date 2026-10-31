
import { Router } from "express";
import {
  getAllStockMovements,
  createStockMovement,
} from "../controllers/stockMovementController.js";

const router = Router();

router.get("/", getAllStockMovements);
router.post("/", createStockMovement);

export default router;
