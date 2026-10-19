"use client";

import Link from "next/link";
import { useState } from "react";
import Sidebar from "../../components/Sidebar";
import ProfilManager from "../../components/ProfilManager";

type Period = 3 | 6 | 9 | 12;

const dataStokKeluar = [
  {
    tanggal: "03 Juni 2026",
    kode: "SKU-001",
    nama: "Laptop ASUS",
    kategori: "Elektronik",
    jumlah: 3,
    tujuan: "Ruang Administrasi",
  },
  {
    tanggal: "08 Juni 2026",
    kode: "SKU-002",
    nama: "Keyboard",
    kategori: "Aksesoris",
    jumlah: 2,
    tujuan: "Ruang Komputer",
  },
  {
    tanggal: "14 Juni 2026",
    kode: "SKU-003",
    nama: "Mouse Wireless",
    kategori: "Aksesoris",
    jumlah: 2,
    tujuan: "Ruang Komputer",
  },
  {
    tanggal: "21 Juni 2026",
    kode: "SKU-004",
    nama: "Monitor",
    kategori: "Elektronik",
    jumlah: 5,
    tujuan: "Ruang Administrasi",
  },
  {
    tanggal: "27 Juni 2026",
    kode: "SKU-005",
    nama: "Printer",
    kategori: "Elektronik",
    jumlah: 0,
    tujuan: "Ruang Tata Usaha",
  },
  {
    tanggal: "18 Mei 2026",
    kode: "SKU-006",
    nama: "Headset",
    kategori: "Aksesoris",
    jumlah: 4,
    tujuan: "Ruang Komputer",
  },
  {
    tanggal: "10 April 2026",
    kode: "SKU-007",
    nama: "Webcam",
    kategori: "Aksesoris",
    jumlah: 3,
    tujuan: "Ruang Administrasi",
  },
  {
    tanggal: "08 Maret 2026",
    kode: "SKU-008",
    nama: "Keyboard Mechanical",
    kategori: "Aksesoris",
    jumlah: 2,
    tujuan: "Ruang Komputer",
  },
  {
    tanggal: "15 Februari 2026",
    kode: "SKU-009",
    nama: "Laptop Lenovo",
    kategori: "Elektronik",
    jumlah: 4,
    tujuan: "Ruang Administrasi",
  },
];

const periodeData = {
  3: dataStokKeluar.slice(0, 5),
  6: dataStokKeluar.slice(0, 6),
  9: dataStokKeluar.slice(0, 8),
  12: dataStokKeluar,
};

export default function DetailStokKeluarPage() {
  const [period, setPeriod] = useState<Period>(6);

  const [activeCard, setActiveCard] = useState<
    "barang" | "transaksi" | "periode"
  >("barang");

  const [showPeriodOptions, setShowPeriodOptions] = useState(false);

  const dataTampil = periodeData[period];

  const totalBarang = dataTampil.reduce(
    (total, item) => total + item.jumlah,
    0
  );

  const jumlahTransaksi = dataTampil.length;

  const getPeriodText = () => {
    if (period === 3) return "3 Bulan Terakhir";
    if (period === 6) return "6 Bulan Terakhir";
    if (period === 9) return "9 Bulan Terakhir";
    return "1 Tahun Terakhir";
  };

  const getDateText = () => {
    if (period === 3) return "April - Juni 2026";
    if (period === 6) return "Januari - Juni 2026";
    if (period === 9) return "Oktober 2025 - Juni 2026";
    return "Juli 2025 - Juni 2026";
  };

  const handlePeriodChange = (newPeriod: Period) => {
    setPeriod(newPeriod);
    setActiveCard("periode");
    setShowPeriodOptions(false);
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

            <h1>
              Detail Stok Keluar
            </h1>

            <p>
              Rincian pengeluaran barang berdasarkan data stok keluar.
            </p>
          </div>

          <div className="detail-header-right">

            <span className="detail-period-text">
              {getPeriodText()}
            </span>

            <ProfilManager />

          </div>

        </header>


        {/* SUMMARY */}
        <section className="detail-summary">

          {/* TOTAL BARANG KELUAR */}
          <button
            type="button"
            className={`detail-summary-card ${
              activeCard === "barang"
                ? "summary-active"
                : ""
            }`}
            onClick={() => {
              setActiveCard("barang");
              setShowPeriodOptions(false);
            }}
          >

            <span>
              Total Barang Keluar
            </span>

            <strong>
              {totalBarang}
            </strong>

            <small>
              unit
            </small>

          </button>


          {/* JUMLAH TRANSAKSI */}
          <button
            type="button"
            className={`detail-summary-card ${
              activeCard === "transaksi"
                ? "summary-active"
                : ""
            }`}
            onClick={() => {
              setActiveCard("transaksi");
              setShowPeriodOptions(false);
            }}
          >

            <span>
              Jumlah Transaksi
            </span>

            <strong>
              {jumlahTransaksi}
            </strong>

            <small>
              transaksi pengeluaran
            </small>

          </button>


          {/* PERIODE */}
          <div className="period-card-wrapper">

            <button
              type="button"
              className={`detail-summary-card ${
                activeCard === "periode"
                  ? "summary-active"
                  : ""
              }`}
              onClick={() => {
                setActiveCard("periode");
                setShowPeriodOptions(!showPeriodOptions);
              }}
            >

              <span>
                Periode
              </span>

              <strong>
                {period}
              </strong>

              <small>
                Bulan Terakhir
              </small>

            </button>


            {/* DROPDOWN PERIODE */}
            {showPeriodOptions && (
              <div className="period-options">

                <button
                  type="button"
                  onClick={() => handlePeriodChange(3)}
                  className={
                    period === 3
                      ? "period-option-active"
                      : ""
                  }
                >
                  3 Bulan
                </button>

                <button
                  type="button"
                  onClick={() => handlePeriodChange(6)}
                  className={
                    period === 6
                      ? "period-option-active"
                      : ""
                  }
                >
                  6 Bulan
                </button>

                <button
                  type="button"
                  onClick={() => handlePeriodChange(9)}
                  className={
                    period === 9
                      ? "period-option-active"
                      : ""
                  }
                >
                  9 Bulan
                </button>

                <button
                  type="button"
                  onClick={() => handlePeriodChange(12)}
                  className={
                    period === 12
                      ? "period-option-active"
                      : ""
                  }
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

              <h2>
                Rincian Stok Keluar
              </h2>

              <p>
                Daftar barang yang telah dikeluarkan dari gudang.
              </p>

            </div>

            <span className="table-period">
              {getDateText()}
            </span>

          </div>


          <div className="table-wrapper">

            <table className="stok-detail-table">

              <thead>

                <tr>

                  <th>
                    No
                  </th>

                  <th>
                    Tanggal
                  </th>

                  <th>
                    Kode SKU
                  </th>

                  <th>
                    Nama Barang
                  </th>

                  <th>
                    Kategori
                  </th>

                  <th>
                    Jumlah
                  </th>

                  <th>
                    Tujuan
                  </th>

                </tr>

              </thead>


              <tbody>

                {dataTampil.map((item, index) => (

                  <tr key={item.kode}>

                    <td>
                      {index + 1}
                    </td>

                    <td>
                      {item.tanggal}
                    </td>

                    <td>
                      <span className="sku-badge">
                        {item.kode}
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
                      <strong className="jumlah-keluar">
                        -{item.jumlah}
                      </strong>
                    </td>

                    <td>
                      {item.tujuan}
                    </td>

                  </tr>

                ))}

              </tbody>

            </table>

          </div>


          {dataTampil.length === 0 && (
            <div className="empty-table">
              Belum ada data stok keluar pada periode ini.
            </div>
          )}

        </section>

      </section>

    </main>
  );
}