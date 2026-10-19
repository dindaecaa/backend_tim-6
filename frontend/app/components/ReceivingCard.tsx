
"use client";

import Link from "next/link";

export default function ReceivingCard() {
  const data = [
    {
      no: 1,
      barang: "Laptop Asus",
      sku: "ELC-001",
      jumlah: "10 unit",
      waktu: "20 September 2026, 10.24",
      lokasi: "Rak A",
      pemasok: "PT Sumber Jaya",
    },
    {
      no: 2,
      barang: "Mouse Logitech",
      sku: "ELC-002",
      jumlah: "50 unit",
      waktu: "20 September 2026, 09.15",
      lokasi: "Rak B",
      pemasok: "CV Maju Bersama",
    },
    {
      no: 3,
      barang: "Keyboard Mechanical",
      sku: "ELC-003",
      jumlah: "30 unit",
      waktu: "20 September 2026, 08.40",
      lokasi: "Rak B",
      pemasok: "PT Global Tech",
    },
    {
      no: 4,
      barang: "Kursi Kantor",
      sku: "FUR-001",
      jumlah: "5 unit",
      waktu: "20 September 2026, 08.10",
      lokasi: "Rak C",
      pemasok: "UD Maju Jaya",
    },
    {
      no: 5,
      barang: "Monitor Samsung",
      sku: "ELC-004",
      jumlah: "8 unit",
      waktu: "20 September 2026, 07.55",
      lokasi: "Rak A",
      pemasok: "PT Sumber Jaya",
    },
  ];

  return (
    <section className="receiving-dashboard-card">
      {/* JUDUL TANPA IKON */}
      <div className="receiving-dashboard-header">
        <div className="receiving-title">
          <h2>Penerimaan Hari Ini</h2>
        </div>

        <Link
          href="/penerimaan"
          className="receiving-see-all"
        >
          Lihat Semua →
        </Link>
      </div>

      {/* TABEL PENERIMAAN */}
      <div className="receiving-table-wrapper">
        <table className="receiving-dashboard-table">
          <thead>
            <tr>
              <th>No</th>
              <th>Nama Barang</th>
              <th>SKU</th>
              <th>Jumlah Diterima</th>
              <th>Waktu Penerimaan</th>
              <th>Lokasi</th>
              <th>Pemasok</th>
              <th>Status</th>
            </tr>
          </thead>

          <tbody>
            {data.map((item) => (
              <tr key={item.no}>
                <td>{item.no}</td>

                {/* NAMA BARANG TANPA EMOJI DAN KOTAK */}
                <td>
                  <span className="receiving-product">
                    {item.barang}
                  </span>
                </td>

                <td>{item.sku}</td>
                <td>{item.jumlah}</td>
                <td>{item.waktu}</td>
                <td>{item.lokasi}</td>
                <td>{item.pemasok}</td>

                <td>
                  <span className="status-received">
                    Diterima
                  </span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </section>
  );
}
