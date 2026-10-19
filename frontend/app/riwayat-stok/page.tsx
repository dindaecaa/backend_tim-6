"use client";

import { useState } from "react";
import {
  Search,
  Eye,
  ArrowLeftRight,
  TrendingUp,
  TrendingDown,
} from "lucide-react";

import Sidebar from "../components/Sidebar";
import ProfilManager from "../components/ProfilManager";

type RiwayatStok = {
  tanggal: string;
  jenis: "Masuk" | "Keluar";
  barang: string;
  sku: string;
  jumlah: number;
  pemasokTujuan: string;
  catatan: string;
};

/* ================================
   DATA CONTOH
================================ */

const semuaData: RiwayatStok[] = [
  {
    tanggal: "SKU - 001",
    jenis: "Masuk",
    barang: "Laptop Asus",
    sku: "SKU-001",
    jumlah: 20,
    pemasokTujuan: "PT Technido",
    catatan: "",
  },
  {
    tanggal: "SKU - 001",
    jenis: "Keluar",
    barang: "",
    sku: "",
    jumlah: -5,
    pemasokTujuan: "",
    catatan: "",
  },
  {
    tanggal: "SKU - 002",
    jenis: "Masuk",
    barang: "Mouse Logitech",
    sku: "SKU-002",
    jumlah: 30,
    pemasokTujuan: "PT Sumber Jaya",
    catatan: "",
  },
  {
    tanggal: "SKU - 003",
    jenis: "Masuk",
    barang: "Keyboard Mechanical",
    sku: "SKU-003",
    jumlah: 15,
    pemasokTujuan: "CV Teknologi",
    catatan: "",
  },
  {
    tanggal: "SKU - 002",
    jenis: "Keluar",
    barang: "Mouse Logitech",
    sku: "SKU-002",
    jumlah: -10,
    pemasokTujuan: "Penjualan",
    catatan: "",
  },
  {
    tanggal: "SKU - 004",
    jenis: "Masuk",
    barang: "Monitor LG",
    sku: "SKU-004",
    jumlah: 12,
    pemasokTujuan: "PT Digital",
    catatan: "",
  },
  {
    tanggal: "SKU - 005",
    jenis: "Masuk",
    barang: "Printer Epson",
    sku: "SKU-005",
    jumlah: 8,
    pemasokTujuan: "PT Office",
    catatan: "",
  },
  {
    tanggal: "SKU - 004",
    jenis: "Keluar",
    barang: "Monitor LG",
    sku: "SKU-004",
    jumlah: -3,
    pemasokTujuan: "Penjualan",
    catatan: "",
  },
  {
    tanggal: "SKU - 006",
    jenis: "Masuk",
    barang: "Flashdisk 64GB",
    sku: "SKU-006",
    jumlah: 40,
    pemasokTujuan: "PT Data Jaya",
    catatan: "",
  },
  {
    tanggal: "SKU - 007",
    jenis: "Masuk",
    barang: "Harddisk 1TB",
    sku: "SKU-007",
    jumlah: 10,
    pemasokTujuan: "CV Komputer",
    catatan: "",
  },
  {
    tanggal: "SKU - 006",
    jenis: "Keluar",
    barang: "Flashdisk 64GB",
    sku: "SKU-006",
    jumlah: -8,
    pemasokTujuan: "Penjualan",
    catatan: "",
  },
  {
    tanggal: "SKU - 008",
    jenis: "Masuk",
    barang: "Kabel HDMI",
    sku: "SKU-008",
    jumlah: 25,
    pemasokTujuan: "PT Elektronik",
    catatan: "",
  },
  {
    tanggal: "SKU - 009",
    jenis: "Masuk",
    barang: "Webcam",
    sku: "SKU-009",
    jumlah: 18,
    pemasokTujuan: "PT Digital",
    catatan: "",
  },
  {
    tanggal: "SKU - 008",
    jenis: "Keluar",
    barang: "Kabel HDMI",
    sku: "SKU-008",
    jumlah: -6,
    pemasokTujuan: "Penjualan",
    catatan: "",
  },
  {
    tanggal: "SKU - 010",
    jenis: "Masuk",
    barang: "Headset",
    sku: "SKU-010",
    jumlah: 20,
    pemasokTujuan: "PT Audio",
    catatan: "",
  },
  {
    tanggal: "SKU - 010",
    jenis: "Keluar",
    barang: "Headset",
    sku: "SKU-010",
    jumlah: -4,
    pemasokTujuan: "Penjualan",
    catatan: "",
  },
  {
    tanggal: "SKU - 011",
    jenis: "Masuk",
    barang: "RAM 16GB",
    sku: "SKU-011",
    jumlah: 14,
    pemasokTujuan: "PT Komputer",
    catatan: "",
  },
  {
    tanggal: "SKU - 012",
    jenis: "Masuk",
    barang: "SSD 512GB",
    sku: "SKU-012",
    jumlah: 16,
    pemasokTujuan: "PT Storage",
    catatan: "",
  },
  {
    tanggal: "SKU - 011",
    jenis: "Keluar",
    barang: "RAM 16GB",
    sku: "SKU-011",
    jumlah: -5,
    pemasokTujuan: "Penjualan",
    catatan: "",
  },
  {
    tanggal: "SKU - 013",
    jenis: "Masuk",
    barang: "Kamera CCTV",
    sku: "SKU-013",
    jumlah: 10,
    pemasokTujuan: "PT Security",
    catatan: "",
  },
];

/* ================================
   HALAMAN RIWAYAT STOK
================================ */

export default function RiwayatStokPage() {
  const [tab, setTab] = useState("Semua");
  const [halaman, setHalaman] = useState(1);
  const [cariBarang, setCariBarang] = useState("");
  const [cariPemasok, setCariPemasok] = useState("");
  const [jenisStok, setJenisStok] = useState("");

  const jumlahPerHalaman = 5;

  /* ================================
     DATA CARD RINGKASAN
  ================================ */

  const totalTransaksi = semuaData.length;

  const totalBarangMasuk = semuaData
    .filter((item) => item.jenis === "Masuk")
    .reduce((total, item) => total + item.jumlah, 0);

  const totalBarangKeluar = Math.abs(
    semuaData
      .filter((item) => item.jenis === "Keluar")
      .reduce((total, item) => total + item.jumlah, 0)
  );

  /* ================================
     FILTER DATA
  ================================ */

  const dataFilter = semuaData.filter((item) => {
    const sesuaiTab =
      tab === "Semua" || item.jenis === tab;

    const sesuaiJenis =
      jenisStok === "" || item.jenis === jenisStok;

    const sesuaiBarang = item.barang
      .toLowerCase()
      .includes(cariBarang.toLowerCase());

    const sesuaiPemasok = item.pemasokTujuan
      .toLowerCase()
      .includes(cariPemasok.toLowerCase());

    return (
      sesuaiTab &&
      sesuaiJenis &&
      sesuaiBarang &&
      sesuaiPemasok
    );
  });

  /* ================================
     PAGINATION
  ================================ */

  const totalHalaman = Math.max(
    1,
    Math.ceil(dataFilter.length / jumlahPerHalaman)
  );

  const dataHalaman = dataFilter.slice(
    (halaman - 1) * jumlahPerHalaman,
    halaman * jumlahPerHalaman
  );

  const pindahHalaman = (nomor: number) => {
    if (nomor >= 1 && nomor <= totalHalaman) {
      setHalaman(nomor);
    }
  };

  /* ================================
     KOMPONEN TAMPILAN
  ================================ */

  return (
    <div className="flex min-h-screen bg-[#f4f7f4]">
      <Sidebar />

      <main className="min-w-0 flex-1 px-4 py-5 sm:px-6 lg:px-7">
        {/* HEADER */}
        <div className="mb-6 flex flex-col gap-4 sm:flex-row sm:items-start sm:justify-between">
          <div>
            <h1 className="text-2xl font-bold leading-tight text-[#26392b]">
              Riwayat Stok
            </h1>

            <p className="mt-1 text-sm text-[#758176]">
              Lihat seluruh riwayat barang masuk dan barang keluar dari gudang.
            </p>
          </div>

          <div className="self-start">
            <ProfilManager />
          </div>
        </div>

        {/* ================================
            CARD RINGKASAN RESPONSIF
        ================================= */}

        <section className="mb-6 grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-3">
          {/* TOTAL TRANSAKSI */}
          <div className="flex min-w-0 items-center gap-4 rounded-xl border border-[#dfe8de] bg-white p-4 shadow-sm transition-shadow hover:shadow-md sm:p-5">
            <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-[#edf4ec] text-[#587653]">
              <ArrowLeftRight size={22} strokeWidth={1.8} />
            </div>

            <div className="min-w-0">
              <p className="text-sm text-[#68776b]">
                Total Transaksi
              </p>

              <h2 className="mt-1 text-2xl font-semibold text-[#26392b]">
                {totalTransaksi}
              </h2>

              <p className="mt-1 text-xs text-[#879287]">
                Seluruh aktivitas stok
              </p>
            </div>
          </div>

          {/* TOTAL BARANG MASUK */}
          <div className="flex min-w-0 items-center gap-4 rounded-xl border border-[#dfe8de] bg-white p-4 shadow-sm transition-shadow hover:shadow-md sm:p-5">
            <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-[#edf4ec] text-[#587653]">
              <TrendingUp size={22} strokeWidth={1.8} />
            </div>

            <div className="min-w-0">
              <p className="text-sm text-[#68776b]">
                Total Barang Masuk
              </p>

              <h2 className="mt-1 text-2xl font-semibold text-[#587653]">
                {totalBarangMasuk}
              </h2>

              <p className="mt-1 text-xs text-[#879287]">
                Total unit yang diterima
              </p>
            </div>
          </div>

          {/* TOTAL BARANG KELUAR */}
          <div className="flex min-w-0 items-center gap-4 rounded-xl border border-[#dfe8de] bg-white p-4 shadow-sm transition-shadow hover:shadow-md sm:col-span-2 sm:p-5 xl:col-span-1">
            <div className="flex h-12 w-12 shrink-0 items-center justify-center rounded-lg bg-[#f8eeee] text-[#bd6969]">
              <TrendingDown size={22} strokeWidth={1.8} />
            </div>

            <div className="min-w-0">
              <p className="text-sm text-[#68776b]">
                Total Barang Keluar
              </p>

              <h2 className="mt-1 text-2xl font-semibold text-[#bd6969]">
                {totalBarangKeluar}
              </h2>

              <p className="mt-1 text-xs text-[#879287]">
                Total unit yang dikeluarkan
              </p>
            </div>
          </div>
        </section>

        {/* ================================
            TAB JENIS STOK
        ================================= */}

        <div className="mb-4 flex flex-wrap items-center gap-2">
          {["Semua", "Masuk", "Keluar"].map((jenis) => (
            <button
              key={jenis}
              type="button"
              onClick={() => {
                setTab(jenis);
                setHalaman(1);
              }}
              className={`rounded-lg border px-4 py-2 text-xs font-medium transition-colors ${
                tab === jenis
                  ? "border-[#587653] bg-[#587653] text-white"
                  : "border-[#d8e3d7] bg-white text-[#526356] hover:bg-[#edf4ec]"
              }`}
            >
              {jenis === "Semua"
                ? "Semua"
                : `Stok ${jenis}`}
            </button>
          ))}
        </div>

        {/* ================================
            FILTER
        ================================= */}

        <section className="mb-4 rounded-xl border border-[#dfe8de] bg-white p-4 shadow-sm">
          <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-[130px_140px_minmax(180px,1fr)_minmax(180px,1fr)]">
            {/* PERIODE */}
            <div>
              <label className="mb-2 block text-xs font-medium text-[#68776b]">
                Periode
              </label>

              <select
                defaultValue=""
                className="h-10 w-full rounded-lg border border-[#d8e3d7] bg-white px-3 text-sm text-[#35483a] outline-none focus:border-[#587653] focus:ring-2 focus:ring-[#587653]/10"
              >
                <option value="">Semua Periode</option>
                <option value="hari">Hari Ini</option>
                <option value="minggu">Minggu Ini</option>
                <option value="bulan">Bulan Ini</option>
              </select>
            </div>

            {/* JENIS STOK */}
            <div>
              <label className="mb-2 block text-xs font-medium text-[#68776b]">
                Jenis Stok
              </label>

              <select
                value={jenisStok}
                onChange={(e) => {
                  setJenisStok(e.target.value);
                  setHalaman(1);
                }}
                className="h-10 w-full rounded-lg border border-[#d8e3d7] bg-white px-3 text-sm text-[#35483a] outline-none focus:border-[#587653] focus:ring-2 focus:ring-[#587653]/10"
              >
                <option value="">Semua Jenis</option>
                <option value="Masuk">Masuk</option>
                <option value="Keluar">Keluar</option>
              </select>
            </div>

            {/* CARI BARANG */}
            <div>
              <label className="mb-2 block text-xs font-medium text-[#68776b]">
                Cari Barang
              </label>

              <div className="relative">
                <Search
                  size={16}
                  strokeWidth={1.8}
                  className="absolute left-3 top-1/2 -translate-y-1/2 text-[#879287]"
                />

                <input
                  type="text"
                  value={cariBarang}
                  onChange={(e) => {
                    setCariBarang(e.target.value);
                    setHalaman(1);
                  }}
                  placeholder="Nama barang..."
                  className="h-10 w-full rounded-lg border border-[#d8e3d7] bg-white pl-9 pr-3 text-sm text-[#35483a] outline-none placeholder:text-[#a0aaa0] focus:border-[#587653] focus:ring-2 focus:ring-[#587653]/10"
                />
              </div>
            </div>

            {/* CARI PEMASOK */}
            <div>
              <label className="mb-2 block text-xs font-medium text-[#68776b]">
                Cari Pemasok / Tujuan
              </label>

              <div className="relative">
                <Search
                  size={16}
                  strokeWidth={1.8}
                  className="absolute left-3 top-1/2 -translate-y-1/2 text-[#879287]"
                />

                <input
                  type="text"
                  value={cariPemasok}
                  onChange={(e) => {
                    setCariPemasok(e.target.value);
                    setHalaman(1);
                  }}
                  placeholder="Nama pemasok atau tujuan..."
                  className="h-10 w-full rounded-lg border border-[#d8e3d7] bg-white pl-9 pr-3 text-sm text-[#35483a] outline-none placeholder:text-[#a0aaa0] focus:border-[#587653] focus:ring-2 focus:ring-[#587653]/10"
                />
              </div>
            </div>
          </div>
        </section>

        {/* ================================
            TABEL RIWAYAT
        ================================= */}

        <section className="overflow-hidden rounded-xl border border-[#dfe8de] bg-white shadow-sm">
          <div className="flex flex-col gap-1 border-b border-[#e6ece5] px-4 py-4 sm:flex-row sm:items-center sm:justify-between sm:px-5">
            <h2 className="text-sm font-semibold text-[#35483a]">
              Daftar Riwayat Stok
            </h2>

            <p className="text-xs text-[#879287]">
              Menampilkan {dataHalaman.length} dari {dataFilter.length} transaksi
            </p>
          </div>

          <div className="w-full overflow-x-auto">
            <table className="w-full min-w-[850px] border-collapse text-sm">
              <thead>
                <tr className="bg-[#f5f8f4] text-left text-xs text-[#68776b]">
                  <th className="border-b border-[#e3ebe1] px-4 py-4 font-medium">
                    Tanggal
                  </th>

                  <th className="border-b border-[#e3ebe1] px-4 py-4 font-medium">
                    Jenis
                  </th>

                  <th className="border-b border-[#e3ebe1] px-4 py-4 font-medium">
                    Barang
                  </th>

                  <th className="border-b border-[#e3ebe1] px-4 py-4 font-medium">
                    SKU
                  </th>

                  <th className="border-b border-[#e3ebe1] px-4 py-4 text-center font-medium">
                    Jumlah
                  </th>

                  <th className="border-b border-[#e3ebe1] px-4 py-4 font-medium">
                    Pemasok / Tujuan
                  </th>

                  <th className="border-b border-[#e3ebe1] px-4 py-4 font-medium">
                    Catatan
                  </th>

                  <th className="border-b border-[#e3ebe1] px-4 py-4 text-center font-medium">
                    Aksi
                  </th>
                </tr>
              </thead>

              <tbody>
                {dataHalaman.map((item, index) => (
                  <tr
                    key={`${item.sku}-${item.jenis}-${index}`}
                    className="transition-colors hover:bg-[#f8faf7]"
                  >
                    <td className="border-b border-[#edf1eb] px-4 py-4 text-xs text-[#526356]">
                      {item.tanggal}
                    </td>

                    <td className="border-b border-[#edf1eb] px-4 py-4">
                      <span
                        className={`inline-flex rounded-full px-3 py-1 text-xs font-medium ${
                          item.jenis === "Masuk"
                            ? "bg-[#e7f3e8] text-[#587653]"
                            : "bg-[#f9eaea] text-[#bd6969]"
                        }`}
                      >
                        {item.jenis}
                      </span>
                    </td>

                    <td className="border-b border-[#edf1eb] px-4 py-4 text-xs font-medium text-[#35483a]">
                      {item.barang || "—"}
                    </td>

                    <td className="border-b border-[#edf1eb] px-4 py-4 text-xs text-[#526356]">
                      {item.sku || "—"}
                    </td>

                    <td
                      className={`border-b border-[#edf1eb] px-4 py-4 text-center text-xs font-semibold ${
                        item.jumlah >= 0
                          ? "text-[#587653]"
                          : "text-[#bd6969]"
                      }`}
                    >
                      {item.jumlah >= 0
                        ? `+${item.jumlah}`
                        : item.jumlah}
                    </td>

                    <td className="border-b border-[#edf1eb] px-4 py-4 text-xs text-[#526356]">
                      {item.pemasokTujuan || "—"}
                    </td>

                    <td className="border-b border-[#edf1eb] px-4 py-4 text-xs text-[#68776b]">
                      {item.catatan || "—"}
                    </td>

                    <td className="border-b border-[#edf1eb] px-4 py-4 text-center">
                      <button
                        type="button"
                        title="Lihat detail"
                        onClick={() =>
                          alert(
                            `Detail transaksi\nBarang: ${
                              item.barang || "Belum diisi"
                            }\nSKU: ${item.sku || "Belum diisi"}\nJenis: ${
                              item.jenis
                            }\nJumlah: ${item.jumlah}`
                          )
                        }
                        className="inline-flex h-8 w-8 items-center justify-center rounded-lg text-[#68776b] transition-colors hover:bg-[#edf4ec] hover:text-[#587653]"
                      >
                        <Eye size={17} strokeWidth={1.8} />
                      </button>
                    </td>
                  </tr>
                ))}

                {dataHalaman.length === 0 && (
                  <tr>
                    <td
                      colSpan={8}
                      className="px-4 py-12 text-center text-sm text-[#879287]"
                    >
                      <div className="flex flex-col items-center gap-2">
                        <Search size={24} strokeWidth={1.5} />
                        <p>Data riwayat stok tidak ditemukan.</p>
                        <p className="text-xs">
                          Coba ubah kata kunci pencarian atau filter.
                        </p>
                      </div>
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>
        </section>

        {/* ================================
            PAGINATION
        ================================= */}

        <div className="mt-4 flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
          <p className="text-xs text-[#879287]">
            Halaman {halaman} dari {totalHalaman}
          </p>

          <div className="flex flex-wrap items-center justify-end gap-1.5">
            <button
              type="button"
              disabled={halaman === 1}
              onClick={() => pindahHalaman(halaman - 1)}
              className="flex h-9 min-w-9 items-center justify-center rounded-lg border border-[#d8e3d7] bg-white px-3 text-sm text-[#526356] transition-colors hover:bg-[#edf4ec] disabled:cursor-not-allowed disabled:opacity-40"
            >
              ‹
            </button>

            {Array.from(
              { length: Math.min(totalHalaman, 5) },
              (_, index) => {
                const nomor =
                  totalHalaman <= 5
                    ? index + 1
                    : Math.min(
                        Math.max(halaman - 2, 1),
                        totalHalaman - 4
                      ) + index;

                return (
                  <button
                    key={nomor}
                    type="button"
                    onClick={() => pindahHalaman(nomor)}
                    className={`flex h-9 min-w-9 items-center justify-center rounded-lg border px-3 text-sm transition-colors ${
                      halaman === nomor
                        ? "border-[#587653] bg-[#587653] text-white"
                        : "border-[#d8e3d7] bg-white text-[#526356] hover:bg-[#edf4ec]"
                    }`}
                  >
                    {nomor}
                  </button>
                );
              }
            )}

            <button
              type="button"
              disabled={halaman === totalHalaman}
              onClick={() => pindahHalaman(halaman + 1)}
              className="flex h-9 min-w-9 items-center justify-center rounded-lg border border-[#d8e3d7] bg-white px-3 text-sm text-[#526356] transition-colors hover:bg-[#edf4ec] disabled:cursor-not-allowed disabled:opacity-40"
            >
              ›
            </button>
          </div>
        </div>
      </main>
    </div>
  );
}