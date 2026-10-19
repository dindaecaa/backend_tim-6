
"use client";

import { useMemo, useState } from "react";
import {
  Search,
  Pencil,
  Trash2,
  Truck,
  Users,
  UserCheck,
  UserX,
  ChevronLeft,
  ChevronRight,
  Building2,
  MapPin,
  Phone,
  Mail,
  Package,
  SlidersHorizontal,
} from "lucide-react";

import Sidebar from "../components/Sidebar";
import ProfilManager from "../components/ProfilManager";

type Pemasok = {
  id: number;
  nama: string;
  telepon: string;
  email: string;
  alamat: string;
  kategori: string;
  status: "Aktif" | "Non Aktif";
};

const dataPemasok: Pemasok[] = [
  {
    id: 1,
    nama: "PT ABC Sejahtera",
    telepon: "1029383745",
    email: "abc@gmail.com",
    alamat: "Jl. Selamat",
    kategori: "Elektronik",
    status: "Aktif",
  },
  {
    id: 2,
    nama: "",
    telepon: "",
    email: "",
    alamat: "",
    kategori: "",
    status: "Non Aktif",
  },
  {
    id: 3,
    nama: "",
    telepon: "",
    email: "",
    alamat: "",
    kategori: "",
    status: "Aktif",
  },
  {
    id: 4,
    nama: "",
    telepon: "",
    email: "",
    alamat: "",
    kategori: "",
    status: "Aktif",
  },
  {
    id: 5,
    nama: "",
    telepon: "",
    email: "",
    alamat: "",
    kategori: "",
    status: "Aktif",
  },
  {
    id: 6,
    nama: "",
    telepon: "",
    email: "",
    alamat: "",
    kategori: "",
    status: "Aktif",
  },
];

const PAGE_SIZE = 6;

export default function DataPemasokPage() {
  const [search, setSearch] = useState("");
  const [statusFilter, setStatusFilter] = useState<
    "Semua" | Pemasok["status"]
  >("Semua");

  const [halaman, setHalaman] = useState(1);

  // Filter data berdasarkan pencarian dan status
  const filteredData = useMemo(() => {
    const keyword = search.trim().toLowerCase();

    return dataPemasok.filter((item) => {
      const cocokPencarian =
        !keyword ||
        [
          item.nama,
          item.telepon,
          item.email,
          item.alamat,
          item.kategori,
        ].some((value) =>
          value.toLowerCase().includes(keyword)
        );

      const cocokStatus =
        statusFilter === "Semua" ||
        item.status === statusFilter;

      return cocokPencarian && cocokStatus;
    });
  }, [search, statusFilter]);

  // Pagination
  const totalPages = Math.max(
    1,
    Math.ceil(filteredData.length / PAGE_SIZE)
  );

  const currentPage = Math.min(halaman, totalPages);

  const pageData = filteredData.slice(
    (currentPage - 1) * PAGE_SIZE,
    currentPage * PAGE_SIZE
  );

  // Statistik pemasok
  const aktif = dataPemasok.filter(
    (item) => item.status === "Aktif"
  ).length;

  const nonAktif = dataPemasok.filter(
    (item) => item.status === "Non Aktif"
  ).length;

  // Pencarian
  const changeSearch = (value: string) => {
    setSearch(value);
    setHalaman(1);
  };

  // Aksi edit dan hapus
  const handleEdit = (id: number) => {
    alert(`Edit pemasok ${id}`);
  };

  const handleDelete = (id: number) => {
    const konfirmasi = window.confirm(
      `Apakah kamu yakin ingin menghapus pemasok ${id}?`
    );

    if (konfirmasi) {
      alert(
        "Hubungkan aksi hapus ini ke database agar data benar-benar terhapus."
      );
    }
  };

  return (
    <div className="supplier-page">
      <Sidebar />

      <main className="supplier-main">
        {/* HEADER */}
        <header className="supplier-topbar">
          <div className="supplier-heading">
            <h1>Data Pemasok</h1>

            <p>
              Kelola informasi dan pantau status pemasok
              yang bekerja sama dengan gudang.
            </p>
          </div>

          <ProfilManager />
        </header>

        {/* BANNER */}
        <section className="supplier-welcome">
          <div className="supplier-welcome-icon">
            <Truck size={25} />
          </div>

          <div>
            <h2>
              Hubungan pemasok lebih terorganisir
            </h2>

            <p>
              Semua informasi pemasok dalam satu tempat,
              mudah dicari dan dikelola.
            </p>
          </div>

          <div className="supplier-welcome-mark">
            <Package size={42} strokeWidth={1.2} />
          </div>
        </section>

        {/* CARD STATISTIK INTERAKTIF */}
        <section
          className="supplier-stats"
          aria-label="Ringkasan pemasok"
        >
          {/* TOTAL PEMASOK */}
          <button
            type="button"
            className={`supplier-stat-card ${
              statusFilter === "Semua"
                ? "is-selected"
                : ""
            }`}
            onClick={() => {
              setStatusFilter("Semua");
              setHalaman(1);
            }}
            aria-pressed={statusFilter === "Semua"}
          >
            <div className="supplier-stat-icon stat-purple">
              <Users size={20} />
            </div>

            <div className="supplier-stat-content">
              <span>Total pemasok</span>

              <strong>{dataPemasok.length}</strong>

              <small>
                {statusFilter === "Semua"
                  ? "Semua pemasok ditampilkan"
                  : "Klik untuk melihat semua"}
              </small>
            </div>
          </button>

          {/* PEMASOK AKTIF */}
          <button
            type="button"
            className={`supplier-stat-card ${
              statusFilter === "Aktif"
                ? "is-selected"
                : ""
            }`}
            onClick={() => {
              setStatusFilter("Aktif");
              setHalaman(1);
            }}
            aria-pressed={statusFilter === "Aktif"}
          >
            <div className="supplier-stat-icon stat-green">
              <UserCheck size={20} />
            </div>

            <div className="supplier-stat-content">
              <span>Pemasok aktif</span>

              <strong>{aktif}</strong>

              <small>
                {statusFilter === "Aktif"
                  ? "Menampilkan pemasok aktif"
                  : "Klik untuk melihat data aktif"}
              </small>
            </div>
          </button>

          {/* PEMASOK NONAKTIF */}
          <button
            type="button"
            className={`supplier-stat-card ${
              statusFilter === "Non Aktif"
                ? "is-selected"
                : ""
            }`}
            onClick={() => {
              setStatusFilter("Non Aktif");
              setHalaman(1);
            }}
            aria-pressed={statusFilter === "Non Aktif"}
          >
            <div className="supplier-stat-icon stat-red">
              <UserX size={20} />
            </div>

            <div className="supplier-stat-content">
              <span>Pemasok nonaktif</span>

              <strong>{nonAktif}</strong>

              <small>
                {statusFilter === "Non Aktif"
                  ? "Menampilkan pemasok nonaktif"
                  : "Klik untuk melihat data nonaktif"}
              </small>
            </div>
          </button>
        </section>

        {/* TABEL DATA PEMASOK */}
        <section className="supplier-table-card">
          <div className="supplier-table-heading">
            <div>
              <h2>Daftar Pemasok</h2>

              <p>
                Lihat dan kelola informasi pemasok Anda.
              </p>
            </div>

            <span className="supplier-count">
              <Users size={15} />
              {filteredData.length} data
            </span>
          </div>

          {/* SEARCH DAN FILTER */}
          <div className="supplier-toolbar">
            <label className="supplier-search">
              <Search size={18} />

              <input
                type="search"
                value={search}
                onChange={(event) =>
                  changeSearch(event.target.value)
                }
                placeholder="Cari nama, kontak, alamat..."
                aria-label="Cari data pemasok"
              />

              {search && (
                <button
                  type="button"
                  onClick={() => changeSearch("")}
                  aria-label="Hapus pencarian"
                >
                  ×
                </button>
              )}
            </label>

            <label className="supplier-filter">
              <SlidersHorizontal size={16} />

              <select
                value={statusFilter}
                onChange={(event) => {
                  setStatusFilter(
                    event.target.value as
                      | "Semua"
                      | Pemasok["status"]
                  );

                  setHalaman(1);
                }}
                aria-label="Filter status pemasok"
              >
                <option value="Semua">
                  Semua status
                </option>

                <option value="Aktif">
                  Aktif
                </option>

                <option value="Non Aktif">
                  Nonaktif
                </option>
              </select>
            </label>
          </div>

          {/* TABEL */}
          <div className="supplier-table-scroll">
            <table className="supplier-table">
              <thead>
                <tr>
                  <th className="supplier-number">No.</th>
                  <th>Nama Pemasok</th>
                  <th>Kontak</th>
                  <th>Alamat</th>
                  <th>Kategori Barang</th>
                  <th>Status</th>
                  <th className="supplier-actions-heading">
                    Aksi
                  </th>
                </tr>
              </thead>

              <tbody>
                {pageData.map((item, index) => (
                  <tr key={item.id}>
                    <td className="supplier-number">
                      {(currentPage - 1) * PAGE_SIZE +
                        index +
                        1}
                    </td>

                    {/* NAMA PEMASOK */}
                    <td>
                      {item.nama ? (
                        <div className="supplier-name-cell">
                          <span className="supplier-company-icon">
                            <Building2 size={17} />
                          </span>

                          <span>
                            <strong>{item.nama}</strong>

                            <small>
                              ID pemasok #
                              {String(item.id).padStart(
                                3,
                                "0"
                              )}
                            </small>
                          </span>
                        </div>
                      ) : (
                        <span className="supplier-empty">
                          Belum diisi
                        </span>
                      )}
                    </td>

                    {/* KONTAK */}
                    <td>
                      {item.telepon || item.email ? (
                        <div className="supplier-contact-cell">
                          {item.telepon && (
                            <span>
                              <Phone size={13} />
                              {item.telepon}
                            </span>
                          )}

                          {item.email && (
                            <span>
                              <Mail size={13} />
                              {item.email}
                            </span>
                          )}
                        </div>
                      ) : (
                        <span className="supplier-empty">
                          —
                        </span>
                      )}
                    </td>

                    {/* ALAMAT */}
                    <td>
                      {item.alamat ? (
                        <span className="supplier-address">
                          <MapPin size={14} />
                          {item.alamat}
                        </span>
                      ) : (
                        <span className="supplier-empty">
                          —
                        </span>
                      )}
                    </td>

                    {/* KATEGORI */}
                    <td>
                      {item.kategori ? (
                        <span className="supplier-category">
                          <Package size={13} />
                          {item.kategori}
                        </span>
                      ) : (
                        <span className="supplier-empty">
                          —
                        </span>
                      )}
                    </td>

                    {/* STATUS */}
                    <td>
                      <span
                        className={`supplier-status ${
                          item.status === "Aktif"
                            ? "is-active"
                            : "is-inactive"
                        }`}
                      >
                        <span />
                        {item.status}
                      </span>
                    </td>

                    {/* AKSI */}
                    <td>
                      <div className="supplier-row-actions">
                        <button
                          type="button"
                          className="supplier-icon-button edit"
                          onClick={() =>
                            handleEdit(item.id)
                          }
                          aria-label={`Edit pemasok ${item.id}`}
                          title="Edit pemasok"
                        >
                          <Pencil size={16} />
                        </button>

                        <button
                          type="button"
                          className="supplier-icon-button delete"
                          onClick={() =>
                            handleDelete(item.id)
                          }
                          aria-label={`Hapus pemasok ${item.id}`}
                          title="Hapus pemasok"
                        >
                          <Trash2 size={16} />
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}

                {/* DATA KOSONG */}
                {pageData.length === 0 && (
                  <tr>
                    <td
                      className="supplier-no-results"
                      colSpan={7}
                    >
                      <Search size={24} />

                      <strong>
                        Data tidak ditemukan
                      </strong>

                      <span>
                        Coba kata kunci atau filter status
                        yang lain.
                      </span>

                      <button
                        type="button"
                        onClick={() => {
                          changeSearch("");
                          setStatusFilter("Semua");
                          setHalaman(1);
                        }}
                      >
                        Reset pencarian
                      </button>
                    </td>
                  </tr>
                )}
              </tbody>
            </table>
          </div>

          {/* PAGINATION */}
          <footer className="supplier-table-footer">
            <p>
              Menampilkan{" "}
              <strong>
                {pageData.length > 0
                  ? (currentPage - 1) * PAGE_SIZE + 1
                  : 0}
                –
                {(currentPage - 1) * PAGE_SIZE +
                  pageData.length}
              </strong>{" "}
              dari{" "}
              <strong>{filteredData.length}</strong>{" "}
              data
            </p>

            <nav
              className="supplier-pagination"
              aria-label="Navigasi halaman"
            >
              <button
                type="button"
                disabled={currentPage <= 1}
                onClick={() =>
                  setHalaman((page) =>
                    Math.max(1, page - 1)
                  )
                }
                aria-label="Halaman sebelumnya"
              >
                <ChevronLeft size={17} />
              </button>

              {Array.from(
                { length: totalPages },
                (_, index) => index + 1
              ).map((page) => (
                <button
                  type="button"
                  key={page}
                  className={
                    page === currentPage
                      ? "current"
                      : ""
                  }
                  onClick={() => setHalaman(page)}
                  aria-current={
                    page === currentPage
                      ? "page"
                      : undefined
                  }
                >
                  {page}
                </button>
              ))}

              <button
                type="button"
                disabled={currentPage >= totalPages}
                onClick={() =>
                  setHalaman((page) =>
                    Math.min(totalPages, page + 1)
                  )
                }
                aria-label="Halaman berikutnya"
              >
                <ChevronRight size={17} />
              </button>
            </nav>
          </footer>
        </section>

        {/* FOOTER */}
        <p className="supplier-footnote">
          Stock.co <span>•</span> Sistem manajemen inventaris
        </p>
      </main>
    </div>
  );
}
