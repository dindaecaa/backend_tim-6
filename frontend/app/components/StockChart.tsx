
"use client";

import { useState } from "react";
import { ChevronDown } from "lucide-react";

type StockData = {
  month: string;
  masuk: number;
  keluar: number;
};

const data3Bulan: StockData[] = [
  { month: "Agu", masuk: 135, keluar: 55 },
  { month: "Sep", masuk: 115, keluar: 67 },
  { month: "Okt", masuk: 157, keluar: 68 },
];

const data6Bulan: StockData[] = [
  { month: "Mei", masuk: 78, keluar: 25 },
  { month: "Jun", masuk: 108, keluar: 52 },
  { month: "Jul", masuk: 105, keluar: 57 },
  { month: "Agu", masuk: 135, keluar: 58 },
  { month: "Sep", masuk: 115, keluar: 70 },
  { month: "Okt", masuk: 157, keluar: 69 },
];

const data1Tahun: StockData[] = [
  { month: "Jan", masuk: 45, keluar: 15 },
  { month: "Feb", masuk: 98, keluar: 40 },
  { month: "Mar", masuk: 78, keluar: 30 },
  { month: "Apr", masuk: 99, keluar: 42 },
  { month: "Mei", masuk: 78, keluar: 25 },
  { month: "Jun", masuk: 108, keluar: 52 },
  { month: "Jul", masuk: 105, keluar: 57 },
  { month: "Agu", masuk: 135, keluar: 58 },
  { month: "Sep", masuk: 115, keluar: 67 },
  { month: "Okt", masuk: 157, keluar: 68 },
  { month: "Nov", masuk: 142, keluar: 76 },
  { month: "Des", masuk: 180, keluar: 85 },
];

const periods = [
  "3 Bulan Terakhir",
  "6 Bulan Terakhir",
  "1 Tahun",
];

const chartWidth = 760;
const chartHeight = 270;
const left = 42;
const right = 12;
const top = 18;
const bottom = 35;
const maxValue = 200;

const plotWidth = chartWidth - left - right;
const plotHeight = chartHeight - top - bottom;
const baseline = top + plotHeight;

function getY(value: number) {
  return baseline - (value / maxValue) * plotHeight;
}

function getPoints(data: StockData[], key: "masuk" | "keluar") {
  return data.map((item, index) => ({
    x: left + (index * plotWidth) / Math.max(data.length - 1, 1),
    y: getY(item[key]),
    month: item.month,
    value: item[key],
  }));
}

function smoothPath(points: { x: number; y: number }[]) {
  if (!points.length) return "";
  if (points.length === 1) {
    return `M ${points[0].x} ${points[0].y}`;
  }

  return points.reduce((path, point, index) => {
    if (index === 0) {
      return `M ${point.x} ${point.y}`;
    }

    const previous = points[index - 1];
    const midX = (previous.x + point.x) / 2;

    return (
      path +
      ` C ${midX} ${previous.y}, ${midX} ${point.y}, ${point.x} ${point.y}`
    );
  }, "");
}

function areaPath(points: { x: number; y: number }[]) {
  if (!points.length) return "";

  return (
    smoothPath(points) +
    ` L ${points[points.length - 1].x} ${baseline}` +
    ` L ${points[0].x} ${baseline} Z`
  );
}

export default function StockChart() {
  const [period, setPeriod] = useState("6 Bulan Terakhir");
  const [showDropdown, setShowDropdown] = useState(false);
  const [selectedMonth, setSelectedMonth] = useState<string | null>(null);

  const data =
    period === "3 Bulan Terakhir"
      ? data3Bulan
      : period === "1 Tahun"
        ? data1Tahun
        : data6Bulan;

  const masukPoints = getPoints(data, "masuk");
  const keluarPoints = getPoints(data, "keluar");

  const selectedData = data.find(
    (item) => item.month === selectedMonth
  );

  return (
    <section className="stock-chart-card">
      <div className="stock-chart-header">
        <div className="stock-chart-heading">
          <h2>Pergerakan Stok</h2>
          <p className="stock-chart-subtitle">
            Ringkasan stok masuk dan keluar
          </p>
        </div>

        <div className="stock-chart-controls">
          <div className="stock-chart-legend">
            <span>
              <i className="stock-legend-dot stock-legend-in" />
              Stok Masuk
            </span>
            <span>
              <i className="stock-legend-dot stock-legend-out" />
              Stok Keluar
            </span>
          </div>

          <div className="stock-period-wrapper">
            <button
              type="button"
              className="stock-period-button"
              aria-expanded={showDropdown}
              onClick={() => setShowDropdown((value) => !value)}
            >
              {period}
              <ChevronDown
                size={15}
                className={showDropdown ? "rotate-arrow" : ""}
              />
            </button>

            {showDropdown && (
              <div className="stock-period-menu">
                {periods.map((option) => (
                  <button
                    key={option}
                    type="button"
                    className={period === option ? "selected" : ""}
                    onClick={() => {
                      setPeriod(option);
                      setSelectedMonth(null);
                      setShowDropdown(false);
                    }}
                  >
                    {option}
                  </button>
                ))}
              </div>
            )}
          </div>
        </div>
      </div>

      <div className="stock-chart-visual">
        <svg
          className="stock-chart-svg"
          viewBox={`0 0 ${chartWidth} ${chartHeight}`}
          role="img"
          aria-label={`Grafik stok masuk dan keluar, ${period}`}
        >
          <defs>
            <linearGradient id="stockInGradient" x1="0" y1="0" x2="0" y2="1">
              <stop offset="0%" stopColor="#239966" stopOpacity="0.19" />
              <stop offset="100%" stopColor="#239966" stopOpacity="0.01" />
            </linearGradient>

            <linearGradient id="stockOutGradient" x1="0" y1="0" x2="0" y2="1">
              <stop offset="0%" stopColor="#f5ae38" stopOpacity="0.15" />
              <stop offset="100%" stopColor="#f5ae38" stopOpacity="0.01" />
            </linearGradient>
          </defs>

          {/* Garis grid dan angka sumbu Y */}
          {[0, 50, 100, 150, 200].map((tick) => {
            const y = getY(tick);

            return (
              <g key={tick}>
                <line
                  x1={left}
                  y1={y}
                  x2={chartWidth - right}
                  y2={y}
                  className="stock-chart-grid-line"
                />

                <text
                  x={left - 10}
                  y={y + 4}
                  textAnchor="end"
                  className="stock-chart-axis-label"
                >
                  {tick}
                </text>
              </g>
            );
          })}

          {/* Area berwarna di bawah garis */}
          <path
            d={areaPath(masukPoints)}
            fill="url(#stockInGradient)"
            className="stock-chart-area"
          />

          <path
            d={areaPath(keluarPoints)}
            fill="url(#stockOutGradient)"
            className="stock-chart-area"
          />

          {/* Garis stok masuk */}
          <path
            d={smoothPath(masukPoints)}
            className="stock-line stock-line-in"
          />

          {/* Garis stok keluar */}
          <path
            d={smoothPath(keluarPoints)}
            className="stock-line stock-line-out"
          />

          {/* Titik data stok masuk */}
          {masukPoints.map((point) => {
            const active = selectedMonth === point.month;

            return (
              <g
                key={`in-${point.month}`}
                className="stock-point-group"
                tabIndex={0}
                role="button"
                aria-label={`${point.month}, stok masuk ${point.value}`}
                onMouseEnter={() => setSelectedMonth(point.month)}
                onMouseLeave={() => setSelectedMonth(null)}
                onFocus={() => setSelectedMonth(point.month)}
                onBlur={() => setSelectedMonth(null)}
                onClick={() =>
                  setSelectedMonth((current) =>
                    current === point.month ? null : point.month
                  )
                }
                onKeyDown={(event) => {
                  if (event.key === "Enter" || event.key === " ") {
                    event.preventDefault();
                    setSelectedMonth((current) =>
                      current === point.month ? null : point.month
                    );
                  }
                }}
              >
                <circle
                  cx={point.x}
                  cy={point.y}
                  r="12"
                  fill="transparent"
                />
                <circle
                  cx={point.x}
                  cy={point.y}
                  r={active ? 5 : 3.5}
                  className="stock-point stock-point-in"
                />
              </g>
            );
          })}

          {/* Titik data stok keluar */}
          {keluarPoints.map((point) => {
            const active = selectedMonth === point.month;

            return (
              <g
                key={`out-${point.month}`}
                className="stock-point-group"
                tabIndex={0}
                role="button"
                aria-label={`${point.month}, stok keluar ${point.value}`}
                onMouseEnter={() => setSelectedMonth(point.month)}
                onMouseLeave={() => setSelectedMonth(null)}
                onFocus={() => setSelectedMonth(point.month)}
                onBlur={() => setSelectedMonth(null)}
                onClick={() =>
                  setSelectedMonth((current) =>
                    current === point.month ? null : point.month
                  )
                }
                onKeyDown={(event) => {
                  if (event.key === "Enter" || event.key === " ") {
                    event.preventDefault();
                    setSelectedMonth((current) =>
                      current === point.month ? null : point.month
                    );
                  }
                }}
              >
                <circle
                  cx={point.x}
                  cy={point.y}
                  r="12"
                  fill="transparent"
                />
                <circle
                  cx={point.x}
                  cy={point.y}
                  r={active ? 5 : 3.5}
                  className="stock-point stock-point-out"
                />
              </g>
            );
          })}

          {/* Label bulan */}
          {data.map((item, index) => {
            const x =
              left + (index * plotWidth) / Math.max(data.length - 1, 1);

            return (
              <text
                key={item.month}
                x={x}
                y={baseline + 22}
                textAnchor="middle"
                className={
                  selectedMonth === item.month
                    ? "stock-chart-month-label active"
                    : "stock-chart-month-label"
                }
              >
                {item.month}
              </text>
            );
          })}

          {/* Garis vertikal penanda bulan terpilih */}
          {selectedData && (
            <line
              x1={
                left +
                (data.findIndex((item) => item.month === selectedMonth) *
                  plotWidth) /
                  Math.max(data.length - 1, 1)
              }
              x2={
                left +
                (data.findIndex((item) => item.month === selectedMonth) *
                  plotWidth) /
                  Math.max(data.length - 1, 1)
              }
              y1={top}
              y2={baseline}
              className="stock-chart-crosshair"
            />
          )}
        </svg>

        {/* Detail interaktif */}
        {selectedData && (
          <div className="stock-chart-detail" aria-live="polite">
            <strong>{selectedData.month}</strong>
            <span>
              <i className="stock-legend-dot stock-legend-in" />
              Masuk: <b>{selectedData.masuk}</b>
            </span>
            <span>
              <i className="stock-legend-dot stock-legend-out" />
              Keluar: <b>{selectedData.keluar}</b>
            </span>
          </div>
        )}
      </div>

      <div className="stock-chart-footer">
        <span>Data pergerakan stok bulanan</span>
        <span>Jumlah dalam unit</span>
      </div>
    </section>
  );
}
