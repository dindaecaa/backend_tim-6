"use client";

import {
  useActionState,
  useOptimistic,
  useState,
} from "react";
import Link from "next/link";
import {
  Laptop,
  Package,
  Armchair,
  Warehouse,
  Boxes,
  CheckCircle2,
  PackagePlus,
} from "lucide-react";

import Sidebar from "../../components/Sidebar";
import ProfilManager from "../../components/ProfilManager";
import {
  tambahSKUFormAction,
  type SKUActionState,
} from "./actions/skuActions";

const kategoriBarang = [
  { nama: "Elektronik", Icon: Laptop },
  { nama: "Aksesoris", Icon: Package },
  { nama: "Furniture", Icon: Armchair },
  { nama: "Peralatan Gudang", Icon: Warehouse },
  { nama: "Lainnya", Icon: Boxes },
];

type SKUPreview = {
  id: number;
  sku: string;
  name: string;
  category: string;
  stock: number;
  location: string;
  optimistic?: boolean;
};

const initialState: SKUActionState = {
  success: false,
  message: "",
};

export default function TambahSKUPage() {
  const [state, formAction, isPending] = useActionState(
    tambahSKUFormAction,
    initialState
  );

  const [kategori, setKategori] = useState("");

  const savedSKU: SKUPreview | null = state.savedSKU
    ? {
        id: state.savedSKU.id,
        sku: state.savedSKU.sku,
        name: state.savedSKU.name,
        category: state.savedSKU.category,
        stock: state.savedSKU.stock,
        location: state.savedSKU.location,
        optimistic: false,
      }
    : null;

  const [optimisticSKU, setOptimisticSKU] =
    useOptimistic<SKUPreview | null>(savedSKU);

  const errors = state.errors ?? {};

  function handleSubmit(formData: FormData) {
    const nama = String(formData.get("nama") ?? "").trim();
    const kategoriForm = String(
      formData.get("kategori") ?? ""
    );
    const rawStok = String(formData.get("stok") ?? "");
    const lokasi = String(
      formData.get("lokasi") ?? ""
    ).trim();

    const preview: SKUPreview = {
      id: -Date.now(),
      sku: "SKU-...",
      name: nama,
      category: kategoriForm,
      stock: Number(rawStok),
      location: lokasi,
      optimistic: true,
    };

    setOptimisticSKU(preview);
    formAction(formData);
  }

  const displayedSKU = isPending
    ? optimisticSKU
    : savedSKU;

  return (
    <div className="sku-page">
      <Sidebar />

      <main className="sku-main">
        <header className="sku-topbar">
          <div>
            <p>Dashboard / SKU Database / Tambah SKU</p>
            <h1>Tambah SKU</h1>
          </div>

          <ProfilManager />
        </header>

        <section className="sku-content">
          <div className="sku-page-heading">
            <div>
              <h2>Tambah SKU</h2>
              <p>Tambahkan data barang baru ke sistem.</p>
            </div>
          </div>

          <div className="sku-form-layout">
            <form
              className="sku-form-card"
              action={handleSubmit}
            >
              <div className="sku-form-group">
                <label htmlFor="sku-nama">
                  Nama Barang
                </label>

                <input
                  id="sku-nama"
                  name="nama"
                  placeholder="Masukkan nama barang"
                  maxLength={100}
                  required
                />

                {errors.name?.map((error, i) => (
                  <p
                    key={i}
                    role="alert"
                    className="text-red-600 text-sm"
                  >
                    {error}
                  </p>
                ))}
              </div>

              <div className="sku-form-group">
                <label htmlFor="sku-kategori">
                  Kategori
                </label>

                <select
                  id="sku-kategori"
                  name="kategori"
                  value={kategori}
                  onChange={(e) =>
                    setKategori(e.target.value)
                  }
                  required
                >
                  <option value="">Pilih kategori</option>

                  {kategoriBarang.map((item) => (
                    <option
                      key={item.nama}
                      value={item.nama}
                    >
                      {item.nama}
                    </option>
                  ))}
                </select>

                {errors.category?.map((error, i) => (
                  <p
                    key={i}
                    role="alert"
                    className="text-red-600 text-sm"
                  >
                    {error}
                  </p>
                ))}
              </div>

              <div className="sku-form-group">
                <label htmlFor="sku-stok">
                  Jumlah Stok
                </label>

                <input
                  id="sku-stok"
                  name="stok"
                  type="number"
                  min="0"
                  step="1"
                  placeholder="Masukkan jumlah stok"
                  required
                />

                {errors.stock?.map((error, i) => (
                  <p
                    key={i}
                    role="alert"
                    className="text-red-600 text-sm"
                  >
                    {error}
                  </p>
                ))}
              </div>

              <div className="sku-form-group">
                <label htmlFor="sku-lokasi">
                  Rak / Lokasi
                </label>

                <input
                  id="sku-lokasi"
                  name="lokasi"
                  placeholder="Contoh: A1"
                  maxLength={100}
                  required
                />

                {errors.location?.map((error, i) => (
                  <p
                    key={i}
                    role="alert"
                    className="text-red-600 text-sm"
                  >
                    {error}
                  </p>
                ))}
              </div>

              <div className="sku-form-group">
                <label htmlFor="sku-deskripsi">
                  Deskripsi (Opsional)
                </label>

                <textarea
                  id="sku-deskripsi"
                  name="deskripsi"
                  rows={3}
                  maxLength={500}
                  placeholder="Tambahkan deskripsi barang..."
                />

                {errors.description?.map((error, i) => (
                  <p
                    key={i}
                    role="alert"
                    className="text-red-600 text-sm"
                  >
                    {error}
                  </p>
                ))}
              </div>

              {state.message && (
                <p
                  role="status"
                  className={
                    state.success
                      ? "text-green-600"
                      : "text-red-600"
                  }
                >
                  {state.message}
                </p>
              )}

              {displayedSKU && (
                <div
                  className="sku-optimistic-preview"
                  aria-live="polite"
                >
                  <div className="flex items-center gap-2">
                    {state.success ? (
                      <CheckCircle2
                        size={20}
                        className="text-green-600"
                      />
                    ) : (
                      <PackagePlus
                        size={20}
                        className="text-blue-600"
                      />
                    )}

                    <strong>
                      {isPending
                        ? "SKU sedang ditambahkan..."
                        : "SKU berhasil disimpan"}
                    </strong>
                  </div>

                  <p>
                    <strong>Nama:</strong>{" "}
                    {displayedSKU.name}
                  </p>

                  <p>
                    <strong>Kategori:</strong>{" "}
                    {displayedSKU.category}
                  </p>

                  <p>
                    <strong>Stok:</strong>{" "}
                    {displayedSKU.stock}
                  </p>

                  <p>
                    <strong>Lokasi:</strong>{" "}
                    {displayedSKU.location}
                  </p>

                  <p>
                    <strong>Kode SKU:</strong>{" "}
                    {displayedSKU.sku}
                  </p>
                </div>
              )}

              <div className="sku-form-actions">
                <Link
                  href="/sku-database"
                  className="sku-cancel-button"
                >
                  Batal
                </Link>

                <button
                  type="submit"
                  className="sku-save-button"
                  disabled={isPending}
                >
                  {isPending
                    ? "Menyimpan..."
                    : "Simpan"}
                </button>
              </div>
            </form>

            <aside className="sku-category-card">
              <h3>Kategori Barang</h3>

              {kategoriBarang.map(({ nama, Icon }) => (
                <button
                  type="button"
                  key={nama}
                  onClick={() => setKategori(nama)}
                  className={`sku-category-item ${
                    kategori === nama ? "selected" : ""
                  }`}
                >
                  <span className="sku-category-icon">
                    <Icon size={17} />
                  </span>

                  <span>{nama}</span>
                </button>
              ))}
            </aside>
          </div>
        </section>
      </main>
    </div>
  );
}