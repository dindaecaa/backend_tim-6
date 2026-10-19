import Link from "next/link";
import Sidebar from "../../components/Sidebar";

export default function RiwayatStokMasukPage() {
  return (
    <main className="dashboard-page">

      {/* SIDEBAR */}
      <Sidebar />

      {/* KONTEN UTAMA */}
      <section className="dashboard-content">

        {/* HEADER */}
        <div className="penerimaan-page-topbar">

          <div className="penerimaan-title">

            <Link
              href="/stok-masuk"
              className="penerimaan-back-button"
            >
              ←
            </Link>

            <div>
              <h1>Riwayat Stok Masuk</h1>

              <p>
                Daftar lengkap penerimaan stok barang yang masuk ke sistem.
              </p>
            </div>

          </div>

        </div>


        {/* CARD TABEL */}
        <div className="penerimaan-full-card">

          <div className="penerimaan-card-header">

            <div>
              <h2>Riwayat Penerimaan Stok</h2>

              <p>
                Menampilkan seluruh data stok barang yang masuk.
              </p>
            </div>

            <div className="penerimaan-total">
              <span>Total Data</span>
              <strong>1</strong>
            </div>

          </div>


          {/* TABEL */}
          <div className="table-wrapper">

            <table>

              <thead>
                <tr>
                  <th>Tanggal</th>
                  <th>SKU</th>
                  <th>Nama Barang</th>
                  <th>Jumlah</th>
                  <th>Catatan</th>
                </tr>
              </thead>

              <tbody>

                <tr>
                  <td>20 Jun 2026</td>
                  <td>ELC - 001</td>
                  <td>Laptop</td>
                  <td>5</td>
                  <td>–</td>
                </tr>

              </tbody>

            </table>

          </div>

        </div>

      </section>

    </main>
  );
}