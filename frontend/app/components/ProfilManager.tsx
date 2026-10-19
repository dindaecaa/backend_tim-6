"use client";

import { useEffect, useState } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";

type ProfileData = {
  nama: string;
  email: string;
  telepon: string;
  foto: string;
};

const defaultProfile: ProfileData = {
  nama: "Profil Manager",
  email: "stock.co.manager@gmail.com",
  telepon: "081234567890",
  foto: "",
};

export default function ProfilManager() {
  const pathname = usePathname();

  const [profile, setProfile] =
    useState<ProfileData>(defaultProfile);

  // Untuk membuka / menutup notifikasi
  const [showNotification, setShowNotification] =
    useState(false);

  useEffect(() => {
    const loadProfile = () => {
      const data = localStorage.getItem("profilManager");

      if (data) {
        const savedProfile = JSON.parse(data);

        setProfile({
          ...defaultProfile,
          ...savedProfile,
        });
      }
    };

    // Ambil data profil saat halaman dibuka
    loadProfile();

    // Update otomatis kalau profil berubah
    window.addEventListener(
      "profilManagerUpdated",
      loadProfile
    );

    return () => {
      window.removeEventListener(
        "profilManagerUpdated",
        loadProfile
      );
    };
  }, []);

  return (
    <div className="profile-manager-header">

      {/* NOTIFICATION */}
      <div
        className="profile-notification"
        onClick={() =>
          setShowNotification(!showNotification)
        }
        style={{
          cursor: "pointer",
          position: "relative",
        }}
      >

        <svg
          width="20"
          height="20"
          viewBox="0 0 24 24"
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
        >
          <path
            d="M18 8C18 4.686 15.314 2 12 2C8.686 2 6 4.686 6 8C6 14 3 14 3 16H21C21 14 18 14 18 8Z"
            stroke="currentColor"
            strokeWidth="1.8"
            strokeLinecap="round"
            strokeLinejoin="round"
          />

          <path
            d="M10 20C10.5 21 11.2 22 12 22C12.8 22 13.5 21 14 20"
            stroke="currentColor"
            strokeWidth="1.8"
            strokeLinecap="round"
          />
        </svg>


        {/* JUMLAH NOTIFIKASI */}
        <span
          style={{
            position: "absolute",
            top: "-4px",
            right: "-4px",
            background: "#e74c3c",
            color: "white",
            width: "16px",
            height: "16px",
            borderRadius: "50%",
            fontSize: "10px",
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
          }}
        >
          2
        </span>


        {/* KOTAK NOTIFIKASI */}
        {showNotification && (
          <div
            onClick={(e) => e.stopPropagation()}
            style={{
              position: "absolute",
              top: "35px",
              right: "0",
              width: "300px",
              background: "white",
              borderRadius: "10px",
              boxShadow:
                "0 4px 15px rgba(0,0,0,0.15)",
              padding: "16px",
              zIndex: 1000,
              color: "#333",
            }}
          >

            <h3
              style={{
                margin: "0 0 12px 0",
                fontSize: "16px",
              }}
            >
              Notifikasi
            </h3>


            {/* NOTIFIKASI 1 */}
            <div
              style={{
                padding: "10px 0",
                borderBottom:
                  "1px solid #eeeeee",
              }}
            >
              <strong
                style={{
                  fontSize: "14px",
                }}
              >
                Stok barang menipis
              </strong>

              <p
                style={{
                  margin: "4px 0 0",
                  fontSize: "12px",
                  color: "#777",
                }}
              >
                Beberapa barang perlu segera
                diperiksa.
              </p>
            </div>


            {/* NOTIFIKASI 2 */}
            <div
              style={{
                padding: "10px 0",
              }}
            >
              <strong
                style={{
                  fontSize: "14px",
                }}
              >
                Penerimaan barang hari ini
              </strong>

              <p
                style={{
                  margin: "4px 0 0",
                  fontSize: "12px",
                  color: "#777",
                }}
              >
                Ada barang yang dijadwalkan
                masuk hari ini.
              </p>
            </div>

          </div>
        )}

      </div>


      {/* PROFILE */}
      <Link
        href={`/profile?from=${encodeURIComponent(pathname)}`}
        className="profile-button"
      >

        {/* NAMA & EMAIL */}
        <div className="profile-info">

          <strong>
            {profile.nama}
          </strong>

          <span>
            {profile.email}
          </span>

        </div>


        {/* FOTO PROFIL */}
        <div className="profile-photo-small">

          {profile.foto ? (

            <img
              src={profile.foto}
              alt="Foto Profil"
              style={{
                width: "100%",
                height: "100%",
                objectFit: "cover",
              }}
            />

          ) : (

            <span>
              PM
            </span>

          )}

        </div>

      </Link>

    </div>
  );
}