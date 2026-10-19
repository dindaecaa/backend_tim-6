"use client";

import Link from "next/link";
import Sidebar from "../components/Sidebar";
import { useState } from "react";

const categories = [
  {
    name: "Elektronik",
    percentage: 40,
    sku: 51,
    className: "detail-green",
  },
  {
    name: "Peralatan Kantor",
    percentage: 25,
    sku: 32,
    className: "detail-blue",
  },
  {
    name: "Furniture",
    percentage: 15,
    sku: 19,
    className: "detail-yellow",
  },
  {
    name: "Aksesoris",
    percentage: 12,
    sku: 15,
    className: "detail-red",
  },
  {
    name: "Lainnya",
    percentage: 8,
    sku: 11,
    className: "detail-purple",
  },
];

const products = [
  {
    no: 1,
    nama: "Laptop Asus",
    sku: "ELC-001",
    kategori: "Elektronik",
    stok: 20,
  },
  {
    no: 2,
    nama: "Mouse Logitech",
    sku: "ELC-002",
    kategori: "Elektronik",
    stok: 50,
  },
  {
    no: 3,
    nama: "Keyboard Mechanical",
    sku: "ELC-003",
    kategori: "Elektronik",
    stok: 30,
  },
  {
    no: 4,
    nama: "Monitor Samsung",
    sku: "ELC-004",
    kategori: "Elektronik",
    stok: 8,
  },
  {
    no: 5,
    nama: "Kursi Kantor",
    sku: "FUR-001",
    kategori: "Furniture",
    stok: 5,
  },
];

export default function KategoriTerbanyakPage() {
  const [activeCard, setActiveCard] = useState<string | null>(null);
  const [selectedCategory, setSelectedCategory] =
    useState("Elektronik");

  const selectedCategoryData =
    categories.find(
      (category) => category.name === selectedCategory
    ) || categories[0];

  const selectedProducts = products.filter(
    (product) => product.kategori === selectedCategory
  );

  const handleCardClick = (card: string) => {
    setActiveCard(
      activeCard === card ? null : card
    );
  };

  const handleCategoryClick = (categoryName: string) => {
    setSelectedCategory(categoryName);
    setActiveCard("category");
  };

  return (
    <main className="dashboard-page">

      {/* SIDEBAR */}
      <Sidebar />

      {/* CONTENT */}
      <section className="dashboard-content">

        {/* HEADER */}
        <div className="category-detail-header">

          <Link
            href="/dashboard"
            className="category-detail-back"
            aria-label="Kembali ke Dashboard"
          >
            ←
          </Link>

          <div>
            <h1>Detail Kategori Terbanyak</h1>

            <p>
              Lihat distribusi SKU berdasarkan kategori barang.
            </p>
          </div>

        </div>


        {/* SUMMARY CARDS */}
        <div className="category-detail-summary">

          {/* TOTAL SKU */}
          <button
            type="button"
            className={`category-summary-card ${
              activeCard === "total"
                ? "category-summary-card-active"
                : ""
            }`}
            onClick={() => handleCardClick("total")}
          >
            <span>Total SKU</span>

            <strong>128</strong>

            <p>Seluruh kategori</p>
          </button>


          {/* KATEGORI TERBANYAK */}
          <button
            type="button"
            className={`category-summary-card ${
              activeCard === "top"
                ? "category-summary-card-active"
                : ""
            }`}
            onClick={() => handleCardClick("top")}
          >
            <span>Kategori Terbanyak</span>

            <strong>Elektronik</strong>

            <p>40% dari total SKU</p>
          </button>


          {/* JUMLAH KATEGORI */}
          <button
            type="button"
            className={`category-summary-card ${
              activeCard === "jumlah"
                ? "category-summary-card-active"
                : ""
            }`}
            onClick={() => handleCardClick("jumlah")}
          >
            <span>Jumlah Kategori</span>

            <strong>5</strong>

            <p>Kategori barang</p>
          </button>

        </div>


        {/* INFORMATION AFTER CARD CLICK */}
        {activeCard && (
          <div className="category-interaction-info">

            {activeCard === "total" && (
              <>
                <strong>Total SKU</strong>

                <span>
                  Terdapat <b>128 SKU</b> yang
                  terdaftar dari seluruh kategori barang.
                </span>
              </>
            )}

            {activeCard === "top" && (
              <>
                <strong>Kategori Terbanyak: Elektronik</strong>

                <span>
                  Elektronik memiliki <b>51 SKU</b>,
                  atau sekitar <b>40%</b> dari total SKU.
                </span>
              </>
            )}

            {activeCard === "jumlah" && (
              <>
                <strong>5 Kategori Barang</strong>

                <span>
                  Terdapat 5 kategori yang tercatat
                  dalam database inventori.
                </span>
              </>
            )}

            {activeCard === "category" && (
              <>
                <strong>
                  {selectedCategoryData.name}
                </strong>

                <span>
                  Kategori ini memiliki{" "}
                  <b>{selectedCategoryData.sku} SKU</b>{" "}
                  ({selectedCategoryData.percentage}% dari
                  total SKU).
                </span>
              </>
            )}

          </div>
        )}


        {/* CHART + CATEGORY LIST */}
        <div className="category-detail-main">

          {/* DONUT */}
<div className="category-detail-chart-card">

  <div className="category-detail-card-header">
    <h2>Distribusi Kategori</h2>

    <span>128 SKU</span>
  </div>

  <div className="detail-donut-wrapper">

    <div className="interactive-donut">

      <svg
        width="210"
        height="210"
        viewBox="0 0 210 210"
        className="interactive-donut-svg"
      >

        {(() => {
          const radius = 82;
          const circumference = 2 * Math.PI * radius;

          let accumulated = 0;

          const colorMap: Record<string, string> = {
            "detail-green": "#2ca36d",
            "detail-blue": "#5d9ee5",
            "detail-yellow": "#f6c85f",
            "detail-red": "#f28a82",
            "detail-purple": "#aa7de5",
          };

          return categories.map((category) => {

            const segmentLength =
              (category.percentage / 100) *
              circumference;

            const offset =
              -(accumulated / 100) *
              circumference;

            accumulated += category.percentage;

            const isSelected =
              selectedCategory === category.name;

            return (
              <circle
                key={category.name}
                cx="105"
                cy="105"
                r={radius}
                fill="none"
                stroke={colorMap[category.className]}
                strokeWidth={isSelected ? 50 : 46}
                strokeDasharray={`${segmentLength} ${circumference}`}
                strokeDashoffset={offset}
                transform="rotate(-90 105 105)"
                className={`donut-segment ${
                  isSelected
                    ? "donut-segment-active"
                    : ""
                }`}
                onClick={() =>
                  handleCategoryClick(category.name)
                }
                role="button"
                tabIndex={0}
                aria-label={`${category.name}, ${category.percentage}%`}
              />
            );
          });
        })()}

      </svg>


      {/* TENGAH DONUT */}
      <div className="interactive-donut-center">

        <strong>
          {selectedCategoryData.percentage}%
        </strong>

        <span>
          {selectedCategoryData.name}
        </span>

      </div>

    </div>

  </div>

</div>


          {/* CATEGORY LIST */}
          <div className="category-detail-list-card">

            <div className="category-detail-card-header">

              <h2>Rincian Kategori</h2>

            </div>

            <div className="category-detail-list">

              {categories.map((category) => (

                <button
                  type="button"
                  key={category.name}
                  className={`category-detail-row ${
                    selectedCategory === category.name
                      ? "category-detail-row-active"
                      : ""
                  }`}
                  onClick={() =>
                    handleCategoryClick(category.name)
                  }
                >

                  <div className="category-detail-name">

                    <span
                      className={`category-detail-dot ${category.className}`}
                    ></span>

                    <div>

                      <strong>
                        {category.name}
                      </strong>

                      <small>
                        {category.sku} SKU
                      </small>

                    </div>

                  </div>

                  <strong className="category-detail-percentage">
                    {category.percentage}%
                  </strong>

                </button>

              ))}

            </div>

          </div>

        </div>


        {/* TOP CATEGORY */}
        <div className="top-category-card">

          <div className="top-category-info">

            <span className="top-category-label">
              KATEGORI TERBANYAK
            </span>

            <h2>Elektronik</h2>

            <p>
              Kategori Elektronik memiliki jumlah SKU
              paling banyak dibandingkan kategori lainnya.
            </p>

          </div>

          <div className="top-category-number">

            <strong>40%</strong>

            <span>51 dari 128 SKU</span>

          </div>

        </div>


        {/* PRODUCT TABLE */}
        <div className="category-products-card">

          <div className="category-products-header">

            <div>

              <h2>Detail Barang</h2>

              <p>
                Contoh barang berdasarkan kategori yang
                tersedia.
              </p>

            </div>

          </div>

          <div className="category-products-table-wrapper">

            <table className="category-products-table">

              <thead>

                <tr>
                  <th>No</th>
                  <th>Nama Barang</th>
                  <th>SKU</th>
                  <th>Kategori</th>
                  <th>Stok</th>
                </tr>

              </thead>

              <tbody>

                {products.map((product) => (

                  <tr key={product.no}>

                    <td>{product.no}</td>

                    <td>
                      <strong>
                        {product.nama}
                      </strong>
                    </td>

                    <td>{product.sku}</td>

                    <td>
                      <span className="product-category-badge">
                        {product.kategori}
                      </span>
                    </td>

                    <td>
                      <strong>
                        {product.stok} unit
                      </strong>
                    </td>

                  </tr>

                ))}

              </tbody>

            </table>

          </div>

        </div>

      </section>

    </main>
  );
}