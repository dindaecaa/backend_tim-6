"use server";

import { skuSchema } from "@/lib/schemas";
import { createSafeActionClient } from "next-safe-action";

const actionClient = createSafeActionClient();

export const tambahSKUAction = actionClient
  .inputSchema(skuSchema)
  .action(async ({ parsedInput }) => {
    const response = await fetch(
      `${process.env.API_URL ?? "http://localhost:3001/api"}/products`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          name: parsedInput.name,
          category: parsedInput.category,
          stock: parsedInput.stock,
          location: parsedInput.location,
          description: parsedInput.description,
          unit: "pcs",
          price: 0,
        }),
        cache: "no-store",
      }
    );

    const result = await response.json();

    if (!response.ok || !result.success) {
      throw new Error(result.message ?? "Gagal menyimpan SKU.");
    }

    return result.data;
  });

export type SKUActionState = {
  success: boolean;
  message: string;
  errors?: Record<string, string[] | undefined>;
  savedSKU?: {
    id: number;
    sku: string;
    name: string;
    category: string;
    stock: number;
    location: string;
  };
};

export async function tambahSKUFormAction(
  _prevState: SKUActionState,
  formData: FormData
): Promise<SKUActionState> {
  const rawStock = formData.get("stok");

  const parsed = skuSchema.safeParse({
    name: formData.get("nama"),
    category: formData.get("kategori"),
    stock:
      typeof rawStock === "string" && rawStock.trim() !== ""
        ? Number(rawStock)
        : undefined,
    location: formData.get("lokasi"),
    description: String(formData.get("deskripsi") ?? ""),
  });

  if (!parsed.success) {
    return {
      success: false,
      message: "Periksa kembali isian form.",
      errors: parsed.error.flatten().fieldErrors,
    };
  }

  try {
    const result = await tambahSKUAction(parsed.data);

    if (result?.serverError || !result?.data) {
      return {
        success: false,
        message: result?.serverError ?? "Gagal menyimpan SKU.",
      };
    }

    const product = result.data as {
      id: number | string;
      sku?: string;
      name: string;
      category_name?: string;
      category?: string;
      stock: number | string;
      location?: string;
    };

    return {
      success: true,
      message: "SKU berhasil ditambahkan.",
      savedSKU: {
        id: Number(product.id),
        sku: product.sku ?? `SKU-${product.id}`,
        name: product.name,
        category:
          product.category_name ?? product.category ?? "Lainnya",
        stock: Number(product.stock),
        location: product.location ?? "-",
      },
    };
  } catch (error) {
    console.error("Gagal menyimpan SKU:", error);

    return {
      success: false,
      message:
        error instanceof Error
          ? error.message
          : "Terjadi kesalahan saat menyimpan SKU.",
    };
  }
}