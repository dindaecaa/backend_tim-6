"use client";

import Link from "next/link";
import Sidebar from "../components/Sidebar";
import ProfilManager from "../components/ProfilManager";
import { useState } from "react";

type Period = 3 | 6 | 9 | 12;

const semuaBulan = [
  "Jan",
  "Feb",
  "Mar",
  "Apr",
  "Mei",
  "Jun",
  "Jul",
  "Agu",
  "Sep",
  "Okt",
  "Nov",
  "Des",
];

const dataStokMasuk = [
  { bulan: "Jan", jumlah: 7 },
  { bulan: "Feb", jumlah: 11 },
  { bulan: "Mar", jumlah: 9 },
  { bulan: "Apr", jumlah: 9 },
  { bulan: "Mei", jumlah: 4 },
  { bulan: "Jun", jumlah: 18 },
  { bulan: "Jul", jumlah: 13 },
  { bulan: "Agu", jumlah: 16 },
  { bulan: "Sep", jumlah: 10 },
  { bulan: "Okt", jumlah: 15 },
  { bulan: "Nov", jumlah: 12 },
  { bulan: "Des", jumlah: 17 },
];

const dataStokKeluar = [
  { bulan: "Jan", jumlah: 5 },
  { bulan: "Feb", jumlah: 8 },
  { bulan: "Mar", jumlah: 6 },
  { bulan: "Apr", jumlah: 10 },
  { bulan: "Mei", jumlah: 3 },
  { bulan: "Jun", jumlah: 12 },
  { bulan: "Jul", jumlah: 9 },
  { bulan: "Agu", jumlah: 11 },
  { bulan: "Sep", jumlah: 7 },
  { bulan: "Okt", jumlah: 10 },
  { bulan: "Nov", jumlah: 8 },
  { bulan: "Des", jumlah: 13 },
];

function getNamaRentang(period: Period) {
  const bulan = semuaBulan.slice(0, period);

  return `${bulan[0]} - ${bulan[bulan.length - 1]} 2026`;
}

export default function AnalisisStokPage() {
  const [period, setPeriod] = useState<Period>(6);

  return (
    <main className="analisis-page">
      <Sidebar />

      <section className="analisis-content">

        {/* HEADER */}
        <header className="analisis-header">

          <div className="analisis-header-left">
            <h1>Analisis Stok</h1>

            <p>
              Lihat tren penerimaan dan pengeluaran barang di gudang.
            </p>
          </div>

          <div className="analisis-header-right">

            <select
              className="date-filter-select"
              value={period}
              onChange={(e) =>
                setPeriod(Number(e.target.value) as Period)
              }
            >
              <option value={3}>
                Januari - Maret 2026
              </option>

              <option value={6}>
                Januari - Juni 2026
              </option>

              <option value={9}>
                Januari - September 2026
              </option>

              <option value={12}>
                Januari - Desember 2026
              </option>
            </select>

            <ProfilManager />

          </div>

        </header>


        {/* STOK MASUK */}
        <StockChart
          title="Stok Masuk"
          data={dataStokMasuk}
          type="masuk"
          period={period}
          setPeriod={setPeriod}
          detailLink="/analisis-stok/detail-stok-masuk"
          detailText="Detail Stok Masuk"
        />


        {/* STOK KELUAR */}
        <StockChart
          title="Stok Keluar"
          data={dataStokKeluar}
          type="keluar"
          period={period}
          setPeriod={setPeriod}
          detailLink="/analisis-stok/detail-stok-keluar"
          detailText="Detail Stok Keluar"
        />

      </section>
    </main>
  );
}


function StockChart({
  title,
  data,
  type,
  period,
  setPeriod,
  detailLink,
  detailText,
}: {
  title: string;

  data: {
    bulan: string;
    jumlah: number;
  }[];

  type: "masuk" | "keluar";

  period: Period;

  setPeriod: (period: Period) => void;

  detailLink: string;

  detailText: string;
}) {

  /* DATA SESUAI PERIODE */
  const dataTampil = data.slice(0, period);


  /* TOTAL SESUAI PERIODE */
  const totalPeriode = dataTampil.reduce(
    (total, item) => total + item.jumlah,
    0
  );


  /* TOTAL PERIODE SEBELUMNYA */
  const dataSebelumnya = data.slice(
    Math.max(0, period - 3),
    period
  );

  const totalSebelumnya = dataSebelumnya.reduce(
    (total, item) => total + item.jumlah,
    0
  );


  /* PERSENTASE PERUBAHAN */
  const persentase =
    totalSebelumnya === 0
      ? 0
      : Math.round(
          ((totalPeriode - totalSebelumnya) /
            totalSebelumnya) *
            100
        );


  const percentageText =
    persentase > 0
      ? `+${persentase}%`
      : `${persentase}%`;


  const maxValue = Math.max(
    ...dataTampil.map((item) => item.jumlah),
    20
  );


  return (
    <section className={`stock-chart-card ${type}`}>

      {/* HEADER CARD */}
      <div className="stock-chart-header">

        <div className="stock-chart-title">

          <h2>{title}</h2>

          <select
            className="chart-period-select"
            value={period}
            onChange={(e) =>
              setPeriod(
                Number(e.target.value) as Period
              )
            }
          >
            <option value={3}>
              3 Bulan Terakhir
            </option>

            <option value={6}>
              6 Bulan Terakhir
            </option>

            <option value={9}>
              9 Bulan Terakhir
            </option>

            <option value={12}>
              1 Tahun Terakhir
            </option>
          </select>

        </div>


        <Link
          href={detailLink}
          className="chart-detail-link"
        >
          {detailText}

          <span className="chart-detail-arrow">
            →
          </span>
        </Link>

      </div>


      {/* INFO PERIODE */}
      <div className="chart-selected-period">
        Menampilkan data:{" "}
        <strong>
          {getNamaRentang(period)}
        </strong>
      </div>


      <div className="stock-chart-body">

        {/* CHART */}
        <div className="chart">

          <div className="chart-y-axis">

            <span>{maxValue}</span>

            <span>
              {Math.round(maxValue * 0.75)}
            </span>

            <span>
              {Math.round(maxValue * 0.5)}
            </span>

            <span>
              {Math.round(maxValue * 0.25)}
            </span>

            <span>0</span>

          </div>


          <div className="chart-area">

            <div className="chart-grid">

              <span></span>
              <span></span>
              <span></span>
              <span></span>
              <span></span>

            </div>


            <div className="bars">

              {dataTampil.map((item) => (

                
<div
  className={`bar ${type}`}
  key={item.bulan}
  style={{
    height: `${Math.max((item.jumlah / maxValue) * 200, 5)}px`,
    flex: "0 0 auto",
    width: `calc(100% / ${dataTampil.length} - 12px)`,
  }}
>
  <span className="bar-value">{item.jumlah}</span>
  <span className="bar-label">{item.bulan}</span>
</div>
              ))}

            </div>

          </div>

        </div>


        {/* TOTAL CARD */}
        <Link
          href={`${detailLink}?period=${period}`}
          className={`stock-summary ${type}`}
        >

          <div className="summary-icon">
            {type === "masuk" ? "↗" : "↘"}
          </div>


          <p className="summary-title">
            Total Stok{" "}
            {type === "masuk"
              ? "Masuk"
              : "Keluar"}
          </p>


          {/* TOTAL DINAMIS */}
          <h3>
            {totalPeriode}
            <span> unit</span>
          </h3>


          {/* PERSENTASE DINAMIS */}
          <p className="summary-percentage">
            {percentageText}
          </p>


          <p className="summary-description">
            dibandingkan data sebelumnya
          </p>


          <div className="summary-illustration">
            {type === "masuk"
              ? "📦"
              : "📤"}
          </div>


          <span className="summary-click-text">
            Klik untuk melihat detail →
          </span>

        </Link>

      </div>

    </section>
  );
}