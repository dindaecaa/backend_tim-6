import Link from "next/link";
import Sidebar from "../components/Sidebar";

export default function PenerimaanPage() {
  return (
    <main className="dashboard-page">

      {/* SIDEBAR */}
      <Sidebar />

      {/* MAIN CONTENT */}
      <section className="dashboard-content">

        {/* HEADER */}
        <div className="penerimaan-page-topbar">

          <div className="penerimaan-title">

            <Link
              href="/dashboard"
              className="penerimaan-back-button"
            >
              ←
            </Link>

            <div>
              <h1>Daftar Penerimaan Barang</h1>

              <p>
                Daftar lengkap penerimaan barang yang tercatat di sistem.
              </p>
            </div>

          </div>

        </div>


        {/* CARD TABLE */}
        <div className="penerimaan-full-card">

          <div className="penerimaan-card-header">

            <div>
              <h2>Penerimaan Barang</h2>

              <p>
                Menampilkan seluruh data penerimaan barang.
              </p>
            </div>

            <div className="penerimaan-total">
              <span>Total Data</span>
              <strong>5</strong>
            </div>

          </div>


          {/* TABLE */}
          <div className="table-wrapper">

            <table>

              <thead>
                <tr>
                  <th>No</th>
                  <th>Nama Barang</th>
                  <th>SKU</th>
                  <th>Jumlah Diterima</th>
                  <th>Waktu Penerimaan</th>
                  <th>Lokasi</th>
                </tr>
              </thead>

              <tbody>

                <tr>
                  <td>1</td>
                  <td>Laptop Asus</td>
                  <td>ELC-001</td>
                  <td>10 unit</td>
                  <td>20 September 2026, 10.24</td>
                  <td>Rak A</td>
                </tr>

                <tr>
                  <td>2</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                </tr>

                <tr>
                  <td>3</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                </tr>

                <tr>
                  <td>4</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                </tr>

                <tr>
                  <td>5</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                  <td>-</td>
                </tr>

              </tbody>

            </table>

          </div>

        </div>

      </section>

    </main>
  );
}