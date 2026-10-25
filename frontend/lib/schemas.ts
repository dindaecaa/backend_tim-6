
import { z } from "zod";

export const skuSchema = z.object({
  name: z
    .string()
    .trim()
    .min(1, "Nama barang wajib diisi.")
    .max(100, "Nama barang maksimal 100 karakter."),

  category: z
    .string()
    .trim()
    .min(1, "Kategori wajib dipilih."),

  stock: z
    .number({
      error: "Stok harus berupa angka.",
    })
    .int("Stok harus berupa bilangan bulat.")
    .min(0, "Stok tidak boleh negatif."),

  location: z
    .string()
    .trim()
    .min(1, "Lokasi barang wajib diisi.")
    .max(100, "Lokasi maksimal 100 karakter."),

  description: z
    .string()
    .max(500, "Deskripsi maksimal 500 karakter.")
    .default(""),
});

export type SKUFormData = z.infer<typeof skuSchema>;
