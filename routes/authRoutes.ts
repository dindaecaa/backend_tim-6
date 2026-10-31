
import { Router } from "express";
import {
  register,
  login,
} from "../controllers/authController";

const router = Router();

// REGISTER
// POST /api/auth/register
router.post("/register", register);

// LOGIN
// POST /api/auth/login
router.post("/login", login);

export default router;
