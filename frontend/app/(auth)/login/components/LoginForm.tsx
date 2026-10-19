
"use client";

import { useRouter } from "next/navigation";
import { useState } from "react";

export default function LoginForm() {
  const router = useRouter();

  const [showForgotPassword, setShowForgotPassword] = useState(false);
  const [showPassword, setShowPassword] = useState(false);
  const [email, setEmail] = useState("");
  const [username, setUsername] = useState("");
  const [password, setPassword] = useState("");

  const handleLogin = (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();

    // Navigasi demo, belum memvalidasi akun.
    router.push("/dashboard");
  };

  const handleForgotPassword = () => {
    if (!email.trim()) {
      alert("Silakan masukkan email terlebih dahulu.");
      return;
    }

    alert("Fitur pengiriman link reset perlu dihubungkan ke layanan autentikasi.");
    setShowForgotPassword(false);
    setEmail("");
  };

  return (
    <main className="login-page">
      <div className="login-shell">
        {/* Logo */}
        <header className="login-brand">
          <img
            src="/stock-logo.png"
            alt="Stock.co"
            className="stock-logo"
          />
          <p>Inventory Management System</p>
        </header>

        {/* Form login */}
        <section className="login-card">
          <div className="login-heading">
            <h1>Selamat datang!</h1>
            <p>Masuk untuk mengelola inventori Anda.</p>
          </div>

         

          <form onSubmit={handleLogin}>
            <div className="form-group">
              <label htmlFor="username">Email / Username</label>

              <div className="input-wrapper">
                <svg
                  viewBox="0 0 24 24"
                  width="19"
                  height="19"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1.8"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  aria-hidden="true"
                >
                  <circle cx="12" cy="8" r="4" />
                  <path d="M5 21v-2a7 7 0 0 1 14 0v2" />
                </svg>

                <input
                  id="username"
                  type="text"
                  placeholder="Masukkan email atau username"
                  value={username}
                  onChange={(e) => setUsername(e.target.value)}
                  autoComplete="username"
                  required
                />
              </div>
            </div>

            <div className="form-group">
              <label htmlFor="password">Password</label>

              <div className="input-wrapper">
                <svg
                  viewBox="0 0 24 24"
                  width="19"
                  height="19"
                  fill="none"
                  stroke="currentColor"
                  strokeWidth="1.8"
                  strokeLinecap="round"
                  strokeLinejoin="round"
                  aria-hidden="true"
                >
                  <rect x="3" y="11" width="18" height="10" rx="2" />
                  <path d="M7 11V7a5 5 0 0 1 10 0v4" />
                </svg>

                <input
                  id="password"
                  type={showPassword ? "text" : "password"}
                  placeholder="Masukkan password"
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  autoComplete="current-password"
                  required
                />

                <button
                  type="button"
                  className="password-toggle"
                  onClick={() => setShowPassword(!showPassword)}
                  aria-label={showPassword ? "Sembunyikan password" : "Tampilkan password"}
                >
                  {showPassword ? (
                    <svg viewBox="0 0 24 24" width="19" height="19" fill="none" stroke="currentColor" strokeWidth="1.8">
                      <path d="M3 3l18 18M10.6 10.6a2 2 0 0 0 2.8 2.8" />
                      <path d="M9.9 5.2A10.8 10.8 0 0 1 12 5c5.5 0 9 7 9 7a15 15 0 0 1-3.1 3.8M6.2 6.2C4.1 7.6 3 12 3 12s3.5 7 9 7c1 0 2-.2 2.8-.5" />
                    </svg>
                  ) : (
                    <svg viewBox="0 0 24 24" width="19" height="19" fill="none" stroke="currentColor" strokeWidth="1.8">
                      <path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12Z" />
                      <circle cx="12" cy="12" r="3" />
                    </svg>
                  )}
                </button>
              </div>
            </div>

            <div className="forgot-wrapper">
              <button
                type="button"
                className="forgot-password"
                onClick={() => setShowForgotPassword(true)}
              >
                Lupa Password?
              </button>
            </div>

            <button type="submit" className="login-button">
              Login
            </button>
          </form>

          <p className="login-security-note">
            Dengan melanjutkan, Anda menggunakan sistem inventori Stock.co.
          </p>
        </section>

        <footer className="login-footer">
          © 2026 Stock.co · Inventory Management System
        </footer>
      </div>

      {/* POPUP LUPA PASSWORD */}
      {showForgotPassword && (
        <div
          className="forgot-password-overlay"
          onClick={() => setShowForgotPassword(false)}
        >
          <section
            className="forgot-password-modal"
            role="dialog"
            aria-modal="true"
            aria-labelledby="forgot-title"
            onClick={(e) => e.stopPropagation()}
          >
            <button
              type="button"
              className="forgot-password-close"
              aria-label="Tutup"
              onClick={() => setShowForgotPassword(false)}
            >
              ×
            </button>

            <h2 id="forgot-title">Lupa Password?</h2>

            <p>
              Masukkan email yang terdaftar untuk meminta link reset password.
            </p>

            <div className="forgot-password-form-group">
              <label htmlFor="forgot-email">Email</label>
              <input
                id="forgot-email"
                type="email"
                placeholder="Masukkan email kamu"
                value={email}
                onChange={(e) => setEmail(e.target.value)}
                autoComplete="email"
                required
              />
            </div>

            <button
              type="button"
              className="forgot-password-submit"
              onClick={handleForgotPassword}
            >
              Kirim Link Reset
            </button>

            <button
              type="button"
              className="forgot-password-back"
              onClick={() => setShowForgotPassword(false)}
            >
              Kembali ke Login
            </button>
          </section>
        </div>
      )}
    </main>
  );
}
