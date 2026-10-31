const express = require("express");
const router = express.Router();

const {
  getAllStockMovements,
  createStockMovement,
} = require("../controllers/stockMovementController");

router.get("/", getAllStockMovements);
router.post("/", createStockMovement);

module.exports = router;