import Link from "next/link";
import Image from "next/image";

export default function HomePage() {
  return (
    <main className="home-page">
      {/* NAVBAR */}
      <nav className="home-navbar">
        <div className="home-container navbar-inner">
          <Link href="/" className="home-logo">
            <Image
              src="/stock-logo.png"
              alt="stock.co"
              width={150}
              height={50}
            />
          </Link>

          <div className="navbar-menu">
            <a href="#fitur">Fitur</a>
            <a href="#solusi">Solusi</a>
            <a href="#tentang">Tentang</a>
          </div>

          <div className="navbar-actions">
            <Link href="/login" className="btn-login">
              Login
            </Link>

            <Link href="/login" className="btn-primary">
              Mulai Sekarang
            </Link>
          </div>
        </div>
      </nav>

      {/* HERO */}
      <section className="home-hero">
        <div className="home-container hero-inner">
          <div className="hero-content">
            <span className="hero-label">
              INVENTORY MANAGEMENT SYSTEM
            </span>

            <h1>
              Kelola Stok
              <br />
              Lebih Mudah dengan
              <span> stock.co</span>
            </h1>

            <p>
              Sistem manajemen inventori untuk membantu bisnis
              memantau stok, mencatat barang masuk dan keluar,
              serta mengelola data gudang dengan lebih mudah.
            </p>

            <div className="hero-buttons">
              <Link href="/login" className="hero-primary-button">
                Mulai Kelola Stok
                <span>→</span>
              </Link>

              <a href="#fitur" className="hero-secondary-button">
                Lihat Fitur
              </a>
            </div>

            <div className="hero-benefits">
              <div className="benefit-item">
                <div className="benefit-icon">✓</div>
                <div>
                  <strong>Real-Time</strong>
                  <span>Pantau stok</span>
                </div>
              </div>

              <div className="benefit-item">
                <div className="benefit-icon">✓</div>
                <div>
                  <strong>Terorganisir</strong>
                  <span>Kelola inventori</span>
                </div>
              </div>

              <div className="benefit-item">
                <div className="benefit-icon">✓</div>
                <div>
                  <strong>Terintegrasi</strong>
                  <span>Satu sistem</span>
                </div>
              </div>
            </div>
          </div>

          {/* DASHBOARD PREVIEW */}
          <div className="hero-preview">
            <div className="preview-window">
              <div className="preview-topbar">
                <div className="window-dots">
                  <span></span>
                  <span></span>
                  <span></span>
                </div>

                <div className="preview-manager">
                  <div className="manager-avatar">M</div>

                  <div>
                    <strong>Manager</strong>
                    <small>manager@stock.co</small>
                  </div>
                </div>
              </div>

              <div className="preview-body">
                {/* SIDEBAR PREVIEW */}
                <aside className="preview-sidebar">
                  <div className="preview-logo">
                    <span>◆</span> stock.co
                  </div>

                  <div className="preview-menu active">
                    <span>⌂</span>
                    Dashboard
                  </div>

                  <div className="preview-menu">
                    <span>▥</span>
                    Analisis Stok
                  </div>

                  <div className="preview-menu">
                    <span>▤</span>
                    SKU Database
                  </div>

                  <div className="preview-menu">
                    <span>↓</span>
                    Stok Masuk
                  </div>

                  <div className="preview-menu">
                    <span>↑</span>
                    Stok Keluar
                  </div>

                  <div className="preview-menu">
                    <span>◷</span>
                    Riwayat Stok
                  </div>
                </aside>

                {/* PREVIEW CONTENT */}
                <div className="preview-main">
                  <div className="preview-heading">
                    <small>Dashboard</small>

                    <h3>Selamat Datang, Manager!</h3>

                    <p>
                      Ringkasan kondisi inventori hari ini.
                    </p>
                  </div>

                  {/* STAT */}
                  <div className="preview-stats">
                    <div className="preview-stat">
                      <span>Total SKU</span>
                      <strong>128</strong>
                      <small>↑ 12%</small>
                    </div>

                    <div className="preview-stat">
                      <span>Total Stok</span>
                      <strong>2.340</strong>
                      <small>↑ 8%</small>
                    </div>

                    <div className="preview-stat warning">
                      <span>Menipis</span>
                      <strong>12</strong>
                      <small>↓ 3%</small>
                    </div>

                    <div className="preview-stat danger">
                      <span>Habis</span>
                      <strong>4</strong>
                      <small>↓ 50%</small>
                    </div>
                  </div>

                  {/* CHART */}
                  <div className="preview-charts">
                    <div className="mini-chart">
                      <div className="mini-chart-header">
                        <strong>Pergerakan Stok</strong>

                        <span>
                          <b className="green-dot"></b>
                          Masuk
                          <b className="orange-dot"></b>
                          Keluar
                        </span>
                      </div>

                      <div className="chart-area">
                        <div className="chart-lines">
                          <span></span>
                          <span></span>
                          <span></span>
                          <span></span>
                        </div>

                        <svg
                          viewBox="0 0 400 140"
                          preserveAspectRatio="none"
                        >
                          <polyline
                            points="0,105 50,85 90,95 130,65 175,75 220,50 260,70 300,35 350,45 400,20"
                            fill="none"
                            stroke="#169b76"
                            strokeWidth="4"
                          />

                          <polyline
                            points="0,120 50,110 90,115 130,95 175,105 220,90 260,100 300,80 350,85 400,72"
                            fill="none"
                            stroke="#f0a63b"
                            strokeWidth="4"
                          />
                        </svg>
                      </div>

                      <div className="chart-months">
                        <span>Jan</span>
                        <span>Feb</span>
                        <span>Mar</span>
                        <span>Apr</span>
                        <span>Mei</span>
                        <span>Jun</span>
                      </div>
                    </div>

                    {/* DONUT */}
                    <div className="mini-donut">
                      <strong>Kategori Terbanyak</strong>

                      <div className="donut-wrapper">
                        <div className="donut"></div>

                        <div className="donut-center">
                          <strong>128</strong>
                          <span>Total SKU</span>
                        </div>
                      </div>

                      <div className="donut-list">
                        <span>
                          <i></i>
                          Elektronik
                        </span>

                        <span>
                          <i></i>
                          Peralatan Kantor
                        </span>

                        <span>
                          <i></i>
                          Furnitur
                        </span>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* TRUST */}
      <section className="trust-section">
        <div className="home-container">
          <p className="section-small-title">
            PENGELOLAAN INVENTORI JADI LEBIH MUDAH
          </p>

          <p className="trust-description">
            Satu sistem untuk membantu mengelola stok secara
            lebih sederhana dan terorganisir.
          </p>

          <div className="trust-items">
            <div>
              <span>▣</span>
              Inventory
            </div>

            <div>
              <span>⌂</span>
              Warehouse
            </div>

            <div>
              <span>◔</span>
              Stock Monitoring
            </div>

            <div>
              <span>◇</span>
              SKU Management
            </div>

            <div>
              <span>▤</span>
              Reporting
            </div>
          </div>
        </div>
      </section>

      {/* MASALAH */}
      <section className="problem-section" id="solusi">
        <div className="home-container problem-inner">
          <div className="problem-intro">
            <span className="section-label">
              MASALAH YANG SERING TERJADI
            </span>

            <h2>
              Masih mengelola stok
              <br />
              secara manual?
            </h2>

            <p>
              Pengelolaan inventori yang tidak teratur dapat
              menyebabkan data stok sulit dipantau dan proses
              operasional menjadi lebih lambat.
            </p>

            <a href="#fitur" className="outline-button">
              Lihat Solusi →
            </a>
          </div>

          <div className="problem-cards">
            <div className="problem-card">
              <div className="number">01</div>

              <div className="problem-icon">▤</div>

              <h3>Data stok tidak akurat</h3>

              <p>
                Kesalahan pencatatan dapat membuat jumlah stok
                pada sistem berbeda dengan kondisi barang sebenarnya.
              </p>
            </div>

            <div className="problem-card">
              <div className="number">02</div>

              <div className="problem-icon">⌕</div>

              <h3>Sulit memantau barang</h3>

              <p>
                Banyaknya data barang membuat proses pencarian
                dan pemantauan stok menjadi lebih sulit.
              </p>
            </div>

            <div className="problem-card">
              <div className="number">03</div>

              <div className="problem-icon">◷</div>

              <h3>Pencatatan masih manual</h3>

              <p>
                Pencatatan menggunakan dokumen terpisah dapat
                memperlambat proses pengelolaan inventori.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* FITUR */}
      <section className="feature-section" id="fitur">
        <div className="home-container feature-inner">
          <div className="feature-intro">
            <span className="section-label">
              FITUR STOCK.CO
            </span>

            <h2>
              Semua kebutuhan stok
              <br />
              dalam satu sistem
            </h2>

            <p>
              stock.co membantu mengelola data inventori mulai
              dari pencatatan SKU hingga pemantauan pergerakan stok.
            </p>
          </div>

          <div className="feature-grid">
            <div className="feature-card">
              <div className="feature-icon">▤</div>

              <h3>SKU Database</h3>

              <p>
                Kelola kode SKU, nama barang, kategori, lokasi rak,
                jumlah stok, dan status barang.
              </p>
            </div>

            <div className="feature-card">
              <div className="feature-icon">⌁</div>

              <h3>Analisis Stok</h3>

              <p>
                Pantau pergerakan stok masuk dan keluar melalui
                informasi dan grafik yang mudah dipahami.
              </p>
            </div>

            <div className="feature-card">
              <div className="feature-icon">↕</div>

              <h3>Stok Masuk & Keluar</h3>

              <p>
                Catat setiap transaksi barang sehingga perubahan
                jumlah stok lebih mudah ditelusuri.
              </p>
            </div>

            <div className="feature-card">
              <div className="feature-icon">◷</div>

              <h3>Riwayat Stok</h3>

              <p>
                Lihat aktivitas perubahan stok untuk membantu
                proses monitoring dan pengecekan data.
              </p>
            </div>

            <div className="feature-card">
              <div className="feature-icon">△</div>

              <h3>Status Stok</h3>

              <p>
                Ketahui barang yang masih aman, mulai menipis,
                atau sudah habis.
              </p>
            </div>

            <div className="feature-card">
              <div className="feature-icon">♙</div>

              <h3>Data Pemasok</h3>

              <p>
                Simpan dan kelola informasi pemasok untuk
                mendukung proses pengelolaan barang.
              </p>
            </div>
          </div>
        </div>
      </section>

      {/* CTA */}
      <section className="cta-section">
        <div className="home-container">
          <div className="cta-box">
            <div className="cta-content">
              <span>SATU SISTEM, LEBIH TERATUR</span>

              <h2>Kelola inventori tanpa ribet.</h2>

              <p>
                Pantau kondisi stok, kelola barang, dan lihat
                aktivitas inventori dari satu dashboard.
              </p>

              <Link href="/login" className="cta-button">
                Mulai Sekarang →
              </Link>
            </div>

            <div className="cta-preview">
              <div className="cta-card-main">
                <small>Total Stok</small>

                <strong>2.340</strong>

                <div className="small-line">
                  <span></span>
                  <span></span>
                  <span></span>
                  <span></span>
                  <span></span>
                </div>
              </div>

              <div className="cta-card-small">
                <small>SKU</small>

                <strong>128</strong>

                <span>Semua barang terdata</span>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* TENTANG */}
      <section className="about-section" id="tentang">
        <div className="home-container about-inner">
          <div className="about-image">
            <div className="warehouse-illustration">
              <div className="warehouse-header"></div>

              <div className="warehouse-rack">
                <div className="rack-row">
                  <span></span>
                  <span></span>
                  <span></span>
                </div>

                <div className="rack-row">
                  <span></span>
                  <span></span>
                  <span></span>
                </div>

                <div className="rack-row">
                  <span></span>
                  <span></span>
                  <span></span>
                </div>
              </div>

              <div className="warehouse-box"></div>

              <div className="warehouse-person"></div>
            </div>
          </div>

          <div className="about-content">
            <span className="section-label">
              TENTANG STOCK.CO
            </span>

            <h2>
              Dibuat untuk membuat
              <br />
              pengelolaan stok lebih mudah.
            </h2>

            <p>
              stock.co merupakan sistem manajemen inventori yang
              membantu pengguna memantau data barang, mencatat stok,
              serta melihat aktivitas inventori secara lebih terstruktur.
            </p>

            <p>
              Dengan tampilan yang sederhana dan informasi yang
              terorganisir, proses pengelolaan stok dapat dilakukan
              dengan lebih mudah.
            </p>
          </div>
        </div>
      </section>

      {/* FINAL CTA */}
      <section className="final-cta-section">
        <div className="home-container">
          <div className="final-cta">
            <span>SIAP MENGELOLA STOK?</span>

            <h2>
              Mulai kelola inventori bersama stock.co
            </h2>

            <p>
              Masuk ke dashboard dan mulai kelola data inventori kamu.
            </p>

            <Link href="/login" className="final-button">
              Masuk ke Dashboard →
            </Link>
          </div>
        </div>
      </section>

      {/* FOOTER */}
      <footer className="home-footer">
        <div className="home-container footer-inner">
          <div className="footer-brand">
            <Image
              src="/stock-logo.png"
              alt="stock.co"
              width={130}
              height={45}
            />

            <p>Inventory Management System</p>
          </div>

          <div className="footer-links">
            <a href="#fitur">Fitur</a>
            <a href="#solusi">Solusi</a>
            <a href="#tentang">Tentang</a>
            <Link href="/login">Login</Link>
          </div>

          <div className="footer-copy">
            © 2026 stock.co. All rights reserved.
          </div>
        </div>
      </footer>
    </main>
  );
}