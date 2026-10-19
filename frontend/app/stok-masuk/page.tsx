"use client";

import { useState } from "react";
import {
  Package,
  PackageCheck,
  ClipboardCheck,
  Truck,
  CalendarDays,
  Hash,
  Boxes,
  RotateCcw,
  Save,
  CircleCheck,
  ClipboardList,
} from "lucide-react";

import Sidebar from "../components/Sidebar";
import ProfilManager from "../components/ProfilManager";

export default function StokMasukPage() {
  const [namaBarang, setNamaBarang] = useState("");
  const [pemasok, setPemasok] = useState("");
  const [tanggal, setTanggal] = useState("");
  const [jumlah, setJumlah] = useState("");
  const [sku, setSku] = useState("");
  const [catatan, setCatatan] = useState("");

  const handleSimpan = () => {
    if (
      !namaBarang.trim() ||
      !pemasok.trim() ||
      !tanggal ||
      !jumlah.trim() ||
      !sku.trim()
    ) {
      alert("Mohon lengkapi semua informasi wajib terlebih dahulu.");
      return;
    }

    if (!Number.isInteger(Number(jumlah)) || Number(jumlah) <= 0) {
      alert("Jumlah barang harus berupa bilangan bulat lebih dari 0.");
      return;
    }

    alert("Data stok masuk berhasil dicatat.");

    setNamaBarang("");
    setPemasok("");
    setTanggal("");
    setJumlah("");
    setSku("");
    setCatatan("");
  };

  const handleBatal = () => {
    setNamaBarang("");
    setPemasok("");
    setTanggal("");
    setJumlah("");
    setSku("");
    setCatatan("");
  };

  const inputClass =
    "w-full min-w-0 rounded-lg border border-[#d8e3d7] bg-white py-3 pl-11 pr-3 text-sm text-[#35483a] outline-none transition placeholder:text-[#9aa69c] focus:border-[#58765b] focus:ring-2 focus:ring-[#58765b]/10";

  const iconClass =
    "pointer-events-none absolute left-3.5 top-1/2 -translate-y-1/2 text-[#89968b]";

  return (
    <div className="flex min-h-screen bg-[#f4f7f4]">
      <Sidebar />

      <main className="min-w-0 flex-1 px-4 py-5 sm:px-6 lg:px-8">
        {/* Header halaman */}
        <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
          <div>
            <div className="mb-2 flex items-center gap-2 text-xs text-[#718074]">
              <span>Dashboard</span>
              <span>/</span>
              <span className="text-[#58765b]">Stok Masuk</span>
            </div>

            <h1 className="text-2xl font-semibold tracking-tight text-[#263b2b] sm:text-3xl">
              Stok Masuk
            </h1>

            <p className="mt-2 text-sm leading-6 text-[#718074]">
              Catat penerimaan barang dan perbarui informasi inventori.
            </p>
          </div>

          <div className="flex items-center sm:justify-end">
            <ProfilManager />
          </div>
        </div>

        {/* Ringkasan */}
        <div className="sm-summary-grid">
          <div className="sm-summary-card">
            <div className="sm-summary-icon">
              <PackageCheck />
            </div>

            <div className="sm-summary-text">
              <p className="sm-summary-label">
                Pencatatan Penerimaan
              </p>
              <p className="sm-summary-value">Form Stok Masuk</p>
            </div>
          </div>

          <div className="sm-summary-card">
            <div className="sm-summary-icon">
              <ClipboardCheck />
            </div>

            <div className="sm-summary-text">
              <p className="sm-summary-label">Data Wajib</p>
              <p className="sm-summary-value">
                5 informasi harus diisi
              </p>
            </div>
          </div>
        </div>

        {/* Form dan informasi tambahan */}
        <div className="grid grid-cols-1 items-start gap-5 xl:grid-cols-[minmax(0,1.8fr)_minmax(280px,0.9fr)]">
          {/* Form utama */}
          <section className="min-w-0 overflow-hidden rounded-xl border border-[#dfe8de] bg-white shadow-sm">
            <div className="flex items-center gap-3 border-b border-[#e6ece5] px-5 py-5 sm:px-7">
              <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-lg bg-[#edf4ec] text-[#58765b]">
                <Package size={21} strokeWidth={1.6} />
              </div>

              <div>
                <h2 className="text-base font-semibold text-[#263b2b]">
                  Form Penerimaan Barang
                </h2>
                <p className="mt-1 text-xs leading-5 text-[#718074]">
                  Lengkapi informasi barang yang diterima.
                </p>
              </div>
            </div>

            <div className="space-y-5 p-5 sm:p-7">
              {/* Nama barang */}
              <div>
                <label
                  htmlFor="namaBarang"
                  className="mb-2 block text-sm font-medium text-[#35483a]"
                >
                  Pilih Barang <span className="text-red-500">*</span>
                </label>

                <div className="relative">
                  <Package
                    size={18}
                    strokeWidth={1.6}
                    className={iconClass}
                  />

                  <input
                    id="namaBarang"
                    type="text"
                    value={namaBarang}
                    onChange={(e) => setNamaBarang(e.target.value)}
                    placeholder="Masukkan nama barang"
                    className={inputClass}
                  />
                </div>
              </div>

              {/* Pemasok dan tanggal */}
              <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
                <div className="min-w-0">
                  <label
                    htmlFor="pemasok"
                    className="mb-2 block text-sm font-medium text-[#35483a]"
                  >
                    Pilih Pemasok{" "}
                    <span className="text-red-500">*</span>
                  </label>

                  <div className="relative">
                    <Truck
                      size={18}
                      strokeWidth={1.6}
                      className={iconClass}
                    />

                    <input
                      id="pemasok"
                      type="text"
                      value={pemasok}
                      onChange={(e) => setPemasok(e.target.value)}
                      placeholder="Nama pemasok"
                      className={inputClass}
                    />
                  </div>
                </div>

                <div className="min-w-0">
                  <label
                    htmlFor="tanggal"
                    className="mb-2 block text-sm font-medium text-[#35483a]"
                  >
                    Tanggal Barang Masuk{" "}
                    <span className="text-red-500">*</span>
                  </label>

                  <div className="relative">
                    <CalendarDays
                      size={18}
                      strokeWidth={1.6}
                      className={iconClass}
                    />

                    <input
                      id="tanggal"
                      type="date"
                      value={tanggal}
                      onChange={(e) => setTanggal(e.target.value)}
                      className={inputClass}
                    />
                  </div>
                </div>
              </div>

              {/* Jumlah dan SKU */}
              <div className="grid grid-cols-1 gap-5 sm:grid-cols-2">
                <div className="min-w-0">
                  <label
                    htmlFor="jumlah"
                    className="mb-2 block text-sm font-medium text-[#35483a]"
                  >
                    Jumlah Masuk{" "}
                    <span className="text-red-500">*</span>
                  </label>

                  <div className="relative">
                    <Boxes
                      size={18}
                      strokeWidth={1.6}
                      className={iconClass}
                    />

                    <input
                      id="jumlah"
                      type="number"
                      min="1"
                      step="1"
                      value={jumlah}
                      onChange={(e) => setJumlah(e.target.value)}
                      placeholder="Contoh: 10"
                      className={inputClass}
                    />
                  </div>
                </div>

                <div className="min-w-0">
                  <label
                    htmlFor="sku"
                    className="mb-2 block text-sm font-medium text-[#35483a]"
                  >
                    SKU <span className="text-red-500">*</span>
                  </label>

                  <div className="relative">
                    <Hash
                      size={18}
                      strokeWidth={1.6}
                      className={iconClass}
                    />

                    <input
                      id="sku"
                      type="text"
                      value={sku}
                      onChange={(e) => setSku(e.target.value)}
                      placeholder="Contoh: ELC - 001"
                      className={inputClass}
                    />
                  </div>
                </div>
              </div>

              {/* Catatan */}
              <div>
                <label
                  htmlFor="catatan"
                  className="mb-2 block text-sm font-medium text-[#35483a]"
                >
                  Catatan{" "}
                  <span className="font-normal text-[#89968b]">
                    (Opsional)
                  </span>
                </label>

                <textarea
                  id="catatan"
                  rows={3}
                  value={catatan}
                  onChange={(e) => setCatatan(e.target.value)}
                  placeholder="Tambahkan catatan jika diperlukan..."
                  className="w-full resize-y rounded-lg border border-[#d8e3d7] bg-white px-4 py-3 text-sm leading-6 text-[#35483a] outline-none transition placeholder:text-[#9aa69c] focus:border-[#58765b] focus:ring-2 focus:ring-[#58765b]/10"
                />
              </div>

              {/* Tombol */}
              <div className="flex flex-col-reverse gap-3 border-t border-[#e6ece5] pt-5 sm:flex-row sm:justify-end">
                <button
                  type="button"
                  onClick={handleBatal}
                  className="inline-flex items-center justify-center gap-2 rounded-lg border border-[#d8e3d7] bg-white px-5 py-3 text-sm font-medium text-[#526356] transition hover:bg-[#f4f7f2]"
                >
                  <RotateCcw size={16} strokeWidth={1.6} />
                  Batal
                </button>

                <button
                  type="button"
                  onClick={handleSimpan}
                  className="inline-flex items-center justify-center gap-2 rounded-lg bg-[#58765b] px-5 py-3 text-sm font-medium text-white transition hover:bg-[#48664b] focus:outline-none focus:ring-2 focus:ring-[#58765b]/30 focus:ring-offset-2"
                >
                  <Save size={17} strokeWidth={1.7} />
                  Simpan Penerimaan
                </button>
              </div>
            </div>
          </section>

          {/* Informasi tambahan */}
          <aside className="sm-info-card">
            <div className="sm-info-header">
              <h2 className="sm-info-title">
                Informasi Tambahan
              </h2>
              <p className="sm-info-description">
                Panduan singkat pencatatan barang masuk.
              </p>
            </div>

            <div className="sm-info-content">
              {/* Ikon sederhana tanpa kotak dekoratif */}
              <div className="sm-info-visual">
                <Boxes size={32} strokeWidth={1.5} />
              </div>

              <section className="sm-info-section">
                <h3>Pastikan Data Sudah Benar</h3>
                <p>
                  Periksa informasi barang sebelum menyimpan pencatatan
                  stok masuk agar data inventori tetap teratur.
                </p>
              </section>

              <section className="sm-info-section">
                <h3>Checklist Penerimaan</h3>

                <ul className="sm-checklist">
                  <li>
                    <CircleCheck />
                    <span>Nama barang sudah sesuai</span>
                  </li>
                  <li>
                    <CircleCheck />
                    <span>Pemasok sudah dicatat</span>
                  </li>
                  <li>
                    <CircleCheck />
                    <span>Jumlah barang sudah benar</span>
                  </li>
                  <li>
                    <CircleCheck />
                    <span>SKU sesuai dengan barang</span>
                  </li>
                </ul>
              </section>

              <div className="sm-info-tip">
                <ClipboardList size={19} strokeWidth={1.6} />

                <div>
                  <h3 className="text-sm font-semibold text-[#35483a]">
                    Tips Pencatatan
                  </h3>
                  <p>
                    Gunakan SKU yang konsisten untuk memudahkan pencarian
                    dan identifikasi barang.
                  </p>
                </div>
              </div>
            </div>
          </aside>
        </div>
      </main>
    </div>
  );
}