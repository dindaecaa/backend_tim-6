"use client";

import Link from "next/link";
import {
  Package,
  Database,
  AlertTriangle,
  LockKeyhole,
  ArrowUpRight,
  ArrowDownRight,
  ChevronRight,
  BarChart3,
} from "lucide-react";

export default function StatCards() {
  const cards = [
    {
      title: "Total SKU",
      value: "128",
      description: "12% dari bulan lalu",
      type: "up",
      icon: Package,
      chartIcon: BarChart3,
      className: "stat-green",
      href: "/sku-database",
    },
    {
      title: "Total Stok",
      value: "2.340",
      description: "8% dari bulan lalu",
      type: "up",
      icon: Database,
      chartIcon: BarChart3,
      className: "stat-blue",
      href: "/analisis-stok",
    },
    {
      title: "Stok Menipis",
      value: "12",
      description: "3% dari bulan lalu",
      type: "down",
      icon: AlertTriangle,
      chartIcon: BarChart3,
      className: "stat-orange",
      href: "/analisis-stok",
    },
    {
      title: "Stok Habis",
      value: "4",
      description: "50% dari bulan lalu",
      type: "down",
      icon: LockKeyhole,
      chartIcon: BarChart3,
      className: "stat-red",
      href: "/analisis-stok",
    },
  ];

  return (
    <div className="dashboard-stat-grid">

      {cards.map((card) => {
        const Icon = card.icon;
        const ChartIcon = card.chartIcon;

        return (
          <Link
            key={card.title}
            href={card.href}
            className={`dashboard-stat-card ${card.className}`}
          >

            {/* ICON */}
            <div className="stat-icon-box">
              <Icon size={27} />
            </div>

            {/* INFORMASI CARD */}
            <div className="stat-main">

              <span className="stat-title">
                {card.title}
              </span>

              <strong className="stat-value">
                {card.value}
              </strong>

              <span
                className={`stat-change ${
                  card.type === "up"
                    ? "change-up"
                    : "change-down"
                }`}
              >
                {card.type === "up" ? (
                  <ArrowUpRight size={13} />
                ) : (
                  <ArrowDownRight size={13} />
                )}

                {card.description}
              </span>

            </div>

            {/* ARROW */}
            <ChevronRight
              className="stat-arrow"
              size={18}
            />

            {/* MINI CHART */}
            <div className="stat-mini-chart">
              <ChartIcon size={24} />
            </div>

          </Link>
        );
      })}

    </div>
  );
}