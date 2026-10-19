"use client";

import Link from "next/link";
import { useState } from "react";
import { useSearchParams } from "next/navigation";
import Sidebar from "../../components/Sidebar";
import ProfilManager from "../../components/ProfilManager";

type Period = 3 | 6 | 9 | 12;

const dataStokMasuk = [
  {
    tanggal: "02 Juni 2026",
    sku: "SKU-001",
    nama: "Laptop ASUS",
    kategori: "Elektronik",
    jumlah: 5,
    pemasok: "PT Teknologi Jaya",
  },
  {
    tanggal: "07 Juni 2026",
    sku: "SKU-002",
    nama: "Keyboard",
    kategori: "Aksesoris",
    jumlah: 4,
    pemasok: "CV Digital Mandiri",
  },
  {
    tanggal: "12 Juni 2026",
    sku: "SKU-003",
    nama: "Mouse Wireless",
    kategori: "Aksesoris",
    jumlah: 3,
    pemasok: "PT Teknologi Jaya",
  },
  {
    tanggal: "18 Juni 2026",
    sku: "SKU-004",
    nama: "Monitor",
    kategori: "Elektronik",
    jumlah: 6,
    pemasok: "CV Sumber Komputer",
  },
  {
    tanggal: "22 Mei 2026",
    sku: "SKU-005",
    nama: "Printer",
    kategori: "Elektronik",
    jumlah: 8,
    pemasok: "PT Teknologi Jaya",
  },
  {
    tanggal: "10 April 2026",
    sku: "SKU-006",
    nama: "Headset",
    kategori: "Aksesoris",
    jumlah: 7,
    pemasok: "CV Digital Mandiri",
  },
  {
    tanggal: "18 Maret 2026",
    sku: "SKU-007",
    nama: "Webcam",
    kategori: "Aksesoris",
    jumlah: 5,
    pemasok: "PT Teknologi Jaya",
  },
  {
    tanggal: "08 Februari 2026",
    sku: "SKU-008",
    nama: "Keyboard Mechanical",
    kategori: "Aksesoris",
    jumlah: 6,
    pemasok: "CV Sumber Komputer",
  },
  {
    tanggal: "15 Januari 2026",
    sku: "SKU-009",
    nama: "Laptop Lenovo",
    kategori: "Elektronik",
    jumlah: 9,
    pemasok: "PT Teknologi Jaya",
  },
];

const periodeData = {
  3: dataStokMasuk.slice(0, 4),
  6: dataStokMasuk.slice(0, 6),
  9: dataStokMasuk.slice(0, 8),
  12: dataStokMasuk,
};

export default function DetailStokMasukPage() {
  const searchParams = useSearchParams();

  const periodParam = Number(searchParams.get("period"));

  const initialPeriod: Period =
    periodParam === 3 ||
    periodParam === 6 ||
    periodParam === 9 ||
    periodParam === 12
      ? periodParam
      : 6;

  const [period, setPeriod] = useState<Period>(initialPeriod);

  // Menentukan kartu mana yang sedang aktif
  const [activeCard, setActiveCard] = useState<
    "barang" | "transaksi" | "periode"
  >("barang");

  // Membuka / menutup pilihan periode
  const [showPeriodOptions, setShowPeriodOptions] = useState(false);

  const dataTampil = periodeData[period];

  const totalBarang = dataTampil.reduce(
    (total, item) => total + item.jumlah,
    0
  );

  const jumlahTransaksi = dataTampil.length;

  const handlePeriodChange = (newPeriod: Period) => {
    setPeriod(newPeriod);
    setShowPeriodOptions(false);
    setActiveCard("periode");
  };

  return (
    <main className="detail-stok-page">
      <Sidebar />

      <section className="detail-stok-content">

        {/* HEADER */}
        <header className="detail-stok-header">
          <div>
            <Link
              href="/analisis-stok"
              className="back-to-analisis"
            >
              ← Kembali ke Analisis Stok
            </Link>

            <h1>Detail Stok Masuk</h1>

            <p>
              Rincian penerimaan barang berdasarkan data stok masuk.
            </p>
          </div>

          <div className="detail-header-right">
            <span className="detail-period-text">
              {period === 3 && "3 Bulan Terakhir"}
              {period === 6 && "6 Bulan Terakhir"}
              {period === 9 && "9 Bulan Terakhir"}
              {period === 12 && "1 Tahun Terakhir"}
            </span>

            <ProfilManager />
          </div>
        </header>

        {/* RINGKASAN */}
        <section className="detail-summary">

          {/* TOTAL BARANG */}
          <button
            type="button"
            className={`detail-summary-card green ${
              activeCard === "barang" ? "summary-active" : ""
            }`}
            onClick={() => {
              setActiveCard("barang");
              setShowPeriodOptions(false);
            }}
          >
            <span>Total Barang Masuk</span>

            <strong>{totalBarang}</strong>

            <small>unit</small>
          </button>

          {/* JUMLAH TRANSAKSI */}
          <button
            type="button"
            className={`detail-summary-card ${
              activeCard === "transaksi" ? "summary-active" : ""
            }`}
            onClick={() => {
              setActiveCard("transaksi");
              setShowPeriodOptions(false);
            }}
          >
            <span>Jumlah Transaksi</span>

            <strong>{jumlahTransaksi}</strong>

            <small>transaksi penerimaan</small>
          </button>

          {/* PERIODE */}
          <div className="period-card-wrapper">

            <button
              type="button"
              className={`detail-summary-card ${
                activeCard === "periode" ? "summary-active" : ""
              }`}
              onClick={() => {
                setActiveCard("periode");
                setShowPeriodOptions(!showPeriodOptions);
              }}
            >
              <span>Periode</span>

              <strong>{period}</strong>

              <small>Bulan Terakhir</small>
            </button>

            {/* PILIHAN PERIODE */}
            {showPeriodOptions && (
              <div className="period-options">

                <button
                  type="button"
                  onClick={() => handlePeriodChange(3)}
                  className={period === 3 ? "period-option-active" : ""}
                >
                  3 Bulan
                </button>

                <button
                  type="button"
                  onClick={() => handlePeriodChange(6)}
                  className={period === 6 ? "period-option-active" : ""}
                >
                  6 Bulan
                </button>

                <button
                  type="button"
                  onClick={() => handlePeriodChange(9)}
                  className={period === 9 ? "period-option-active" : ""}
                >
                  9 Bulan
                </button>

                <button
                  type="button"
                  onClick={() => handlePeriodChange(12)}
                  className={period === 12 ? "period-option-active" : ""}
                >
                  1 Tahun
                </button>

              </div>
            )}

          </div>

        </section>

        {/* TABEL */}
        <section className="detail-table-card">

          <div className="detail-table-header">

            <div>
              <h2>Rincian Stok Masuk</h2>

              <p>
                Daftar barang yang diterima di gudang.
              </p>
            </div>

            <span className="table-period">
              {period === 3 && "3 Bulan Terakhir"}
              {period === 6 && "6 Bulan Terakhir"}
              {period === 9 && "9 Bulan Terakhir"}
              {period === 12 && "1 Tahun Terakhir"}
            </span>

          </div>

          <div className="table-wrapper">

            <table className="stok-detail-table">

              <thead>
                <tr>
                  <th>No</th>
                  <th>Tanggal</th>
                  <th>Kode SKU</th>
                  <th>Nama Barang</th>
                  <th>Kategori</th>
                  <th>Jumlah</th>
                  <th>Pemasok</th>
                </tr>
              </thead>

              <tbody>

                {dataTampil.map((item, index) => (
                  <tr key={item.sku}>

                    <td>{index + 1}</td>

                    <td>{item.tanggal}</td>

                    <td>
                      <span className="sku-badge">
                        {item.sku}
                      </span>
                    </td>

                    <td className="barang-name">
                      {item.nama}
                    </td>

                    <td>
                      <span className="kategori-badge">
                        {item.kategori}
                      </span>
                    </td>

                    <td>
                      <strong className="jumlah-masuk">
                        +{item.jumlah}
                      </strong>
                    </td>

                    <td>{item.pemasok}</td>

                  </tr>
                ))}

              </tbody>

            </table>

          </div>

          {dataTampil.length === 0 && (
            <div className="empty-table">
              Belum ada data stok masuk pada periode ini.
            </div>
          )}

        </section>

      </section>
    </main>
  );
}