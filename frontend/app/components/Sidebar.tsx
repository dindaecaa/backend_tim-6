"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { useState } from "react";

export default function Sidebar() {
  const pathname = usePathname();
  const router = useRouter();

  const [showLogoutPopup, setShowLogoutPopup] = useState(false);

  const handleLogout = () => {
    setShowLogoutPopup(false);
    router.push("/login");
  };

  return (
    <>
      <aside className="sidebar fixed left-0 top-0 z-50 h-screen w-[250px]">

        {/* LOGO */}
        <div className="dashboard-logo">
          <img
            src="/stock-logo.png"
            alt="stock.co"
          />
        </div>


        {/* MENU */}
        <nav className="sidebar-menu">

          {/* DASHBOARD */}
          <Link
            href="/dashboard"
            className={`sidebar-item ${
              pathname === "/dashboard"
                ? "active"
                : ""
            }`}
          >
            <span className="menu-icon">
              <svg
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              >
                <path d="M3 10.5L12 3l9 7.5" />
                <path d="M5 9.5V21h14V9.5" />
                <path d="M9 21v-7h6v7" />
              </svg>
            </span>

            <span>Dashboard</span>
          </Link>


          {/* ANALISIS STOK */}
          <Link
            href="/analisis-stok"
            className={`sidebar-item ${
              pathname === "/analisis-stok"
                ? "active"
                : ""
            }`}
          >
            <span className="menu-icon">
              <svg
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              >
                <polyline points="4 17 9 12 13 15 20 7" />
                <polyline points="16 7 20 7 20 11" />
                <line
                  x1="4"
                  y1="20"
                  x2="20"
                  y2="20"
                />
              </svg>
            </span>

            <span>Analisis Stok</span>
          </Link>


          {/* SKU DATABASE */}
          <Link
            href="/sku-database"
            className={`sidebar-item ${
              pathname === "/sku-database"
                ? "active"
                : ""
            }`}
          >
            <span className="menu-icon">
              <svg
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              >
                <rect
                  x="4"
                  y="5"
                  width="16"
                  height="14"
                  rx="1"
                />
                <line
                  x1="4"
                  y1="9"
                  x2="20"
                  y2="9"
                />
                <line
                  x1="7"
                  y1="13"
                  x2="17"
                  y2="13"
                />
                <line
                  x1="7"
                  y1="16"
                  x2="14"
                  y2="16"
                />
              </svg>
            </span>

            <span>SKU Database</span>
          </Link>


          {/* STOK MASUK */}
          <Link
            href="/stok-masuk"
            className={`sidebar-item ${
              pathname === "/stok-masuk"
                ? "active"
                : ""
            }`}
          >
            <span className="menu-icon">
              <svg
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              >
                <rect
                  x="4"
                  y="7"
                  width="16"
                  height="12"
                  rx="1"
                />
                <line
                  x1="4"
                  y1="10"
                  x2="20"
                  y2="10"
                />
                <line
                  x1="9"
                  y1="15"
                  x2="15"
                  y2="15"
                />
              </svg>
            </span>

            <span>Stok Masuk</span>
          </Link>


          {/* STOK KELUAR */}
          <Link
            href="/stok-keluar"
            className={`sidebar-item ${
              pathname === "/stok-keluar"
                ? "active"
                : ""
            }`}
          >
            <span className="menu-icon">
              <svg
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              >
                <rect
                  x="4"
                  y="7"
                  width="16"
                  height="12"
                  rx="1"
                />
                <line
                  x1="4"
                  y1="10"
                  x2="20"
                  y2="10"
                />
                <line
                  x1="9"
                  y1="15"
                  x2="15"
                  y2="15"
                />
              </svg>
            </span>

            <span>Stok Keluar</span>
          </Link>


          {/* RIWAYAT STOK */}
          <Link
            href="/riwayat-stok"
            className={`sidebar-item ${
              pathname === "/riwayat-stok"
                ? "active"
                : ""
            }`}
          >
            <span className="menu-icon">
              <svg
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              >
                <rect
                  x="5"
                  y="3"
                  width="14"
                  height="18"
                  rx="1"
                />
                <line
                  x1="8"
                  y1="7"
                  x2="16"
                  y2="7"
                />
                <line
                  x1="8"
                  y1="11"
                  x2="16"
                  y2="11"
                />
                <line
                  x1="8"
                  y1="15"
                  x2="14"
                  y2="15"
                />
              </svg>
            </span>

            <span>Riwayat Stok</span>
          </Link>


          {/* DATA PEMASOK */}
          <Link
            href="/data-pemasok"
            className={`sidebar-item ${
              pathname === "/data-pemasok"
                ? "active"
                : ""
            }`}
          >
            <span className="menu-icon">
              <svg
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              >
                <circle
                  cx="9"
                  cy="8"
                  r="3"
                />
                <path d="M3 20c0-3.3 2.7-6 6-6s6 2.7 6 6" />
                <path d="M16 11c2.8 0 5 2.2 5 5v4" />
                <path d="M16 5.5a3 3 0 0 1 0 5" />
              </svg>
            </span>

            <span>Data Pemasok</span>
          </Link>

        </nav>


        {/* LOGOUT */}
        <button
          type="button"
          className="logout-button"
          onClick={() =>
            setShowLogoutPopup(true)
          }
        >
          <svg
            width="25"
            height="25"
            viewBox="0 0 24 24"
            fill="none"
            stroke="currentColor"
            strokeWidth="2"
            strokeLinecap="round"
            strokeLinejoin="round"
          >
            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4" />
            <polyline points="16 17 21 12 16 7" />
            <line
              x1="21"
              y1="12"
              x2="9"
              y2="12"
            />
          </svg>

          <span>Logout</span>
        </button>

      </aside>


      {/* POPUP KONFIRMASI LOGOUT */}
      {showLogoutPopup && (
        <div
          className="logout-overlay"
          onClick={() =>
            setShowLogoutPopup(false)
          }
        >
          <div
            className="logout-modal"
            onClick={(e) =>
              e.stopPropagation()
            }
          >

            <h2>Konfirmasi Logout</h2>

            <p>
              Apakah Anda yakin ingin logout?
            </p>

            <div className="logout-modal-actions">

              <button
                type="button"
                className="logout-cancel-button"
                onClick={() =>
                  setShowLogoutPopup(false)
                }
              >
                Tidak
              </button>

              <button
                type="button"
                className="logout-confirm-button"
                onClick={handleLogout}
              >
                Logout
              </button>

            </div>

          </div>
        </div>
      )}

    </>
  );
}