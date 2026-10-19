"use client";

import Link from "next/link";
import { useState } from "react";

type Category = {
  name: string;
  value: number;
  dotClass: string;
};

const categories: Category[] = [
  {
    name: "Elektronik",
    value: 40,
    dotClass: "dot-green",
  },
  {
    name: "Peralatan Kantor",
    value: 25,
    dotClass: "dot-blue",
  },
  {
    name: "Furniture",
    value: 15,
    dotClass: "dot-yellow",
  },
  {
    name: "Aksesoris",
    value: 12,
    dotClass: "dot-red",
  },
  {
    name: "Lainnya",
    value: 8,
    dotClass: "dot-purple",
  },
];

export default function CategoryChart() {
  const [selectedCategory, setSelectedCategory] =
    useState<Category | null>(null);

  return (
    <div className="category-dashboard-card">

      {/* HEADER */}
      <div className="category-dashboard-header">

        <div className="category-title">

          <div className="category-title-icon">
            📋
          </div>

          <h2>
            Kategori Terbanyak
          </h2>

        </div>

        <Link
          href="/kategori-terbanyak"
          className="category-see-all"
        >
          Lihat Semua →
        </Link>

      </div>


      {/* CONTENT */}
      <div className="category-dashboard-content">

        {/* DONUT */}
        <div className="donut-wrapper">

          <div
            className={`donut-chart ${
              selectedCategory
                ? "donut-active"
                : ""
            }`}
          >

            <div className="donut-center">

              <strong>
                {selectedCategory
                  ? `${selectedCategory.value}%`
                  : "128"}
              </strong>

              <span>
                {selectedCategory
                  ? selectedCategory.name
                  : "Total SKU"}
              </span>

            </div>

          </div>

        </div>


        {/* LEGEND */}
        <div className="category-legend">

          {categories.map((category) => (

            <div
              key={category.name}
              className={`category-row ${
                selectedCategory?.name ===
                category.name
                  ? "category-row-active"
                  : ""
              }`}
              onMouseEnter={() =>
                setSelectedCategory(category)
              }
              onMouseLeave={() =>
                setSelectedCategory(null)
              }
            >

              <span>

                <i
                  className={`category-dot ${category.dotClass}`}
                ></i>

                {category.name}

              </span>

              <strong>
                {category.value}%
              </strong>

            </div>

          ))}

        </div>

      </div>

    </div>
  );
}