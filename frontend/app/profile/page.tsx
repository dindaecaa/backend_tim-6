"use client";

import { useEffect, useRef, useState } from "react";
import Link from "next/link";
import {
  ArrowLeft,
  User,
  Mail,
  Phone,
  Camera,
} from "lucide-react";

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

export default function ProfilePage() {
  const [profile, setProfile] =
    useState<ProfileData>(defaultProfile);

  const [isEditing, setIsEditing] =
    useState(false);

  const [nama, setNama] =
    useState(defaultProfile.nama);

  const [email, setEmail] =
    useState(defaultProfile.email);

  const [telepon, setTelepon] =
    useState(defaultProfile.telepon);

  // Untuk membuka File Explorer
  const fileInputRef =
    useRef<HTMLInputElement>(null);

  // Mengambil data profil yang sudah tersimpan
  useEffect(() => {
    const data =
      localStorage.getItem("profilManager");

    if (data) {
      const savedProfile =
        JSON.parse(data);

      setProfile({
        ...defaultProfile,
        ...savedProfile,
      });

      setNama(savedProfile.nama);
      setEmail(savedProfile.email);
      setTelepon(savedProfile.telepon);
    }
  }, []);

  // Membuka File Explorer
  const handleChoosePhoto = () => {
    fileInputRef.current?.click();
  };

  // Saat foto dipilih
  const handlePhotoChange = (
    event: React.ChangeEvent<HTMLInputElement>
  ) => {
    const file =
      event.target.files?.[0];

    if (!file) return;

    // Pastikan yang dipilih adalah gambar
    if (!file.type.startsWith("image/")) {
      alert("Silakan pilih file gambar.");
      return;
    }

    const reader =
      new FileReader();

    reader.onload = () => {
      const foto =
        reader.result as string;

      const updatedProfile = {
        ...profile,
        foto,
      };

      setProfile(updatedProfile);

      localStorage.setItem(
        "profilManager",
        JSON.stringify(updatedProfile)
      );

      // Beritahu dashboard bahwa profil berubah
      window.dispatchEvent(
        new Event("profilManagerUpdated")
      );
    };

    reader.readAsDataURL(file);
  };

  // Saat Edit Profil diklik
  const handleEdit = () => {
    setNama(profile.nama);
    setEmail(profile.email);
    setTelepon(profile.telepon);

    setIsEditing(true);
  };

  // Saat Cancel
  const handleCancel = () => {
    setIsEditing(false);
  };

  // Saat Simpan
  const handleSave = () => {
    const updatedProfile = {
      ...profile,
      nama,
      email,
      telepon,
    };

    localStorage.setItem(
      "profilManager",
      JSON.stringify(updatedProfile)
    );

    window.dispatchEvent(
      new Event("profilManagerUpdated")
    );

    setProfile(updatedProfile);
    setIsEditing(false);
  };

  return (
    <main className="profile-page">

      {/* HEADER */}
      <div className="profile-page-header">

        <Link
          href="/dashboard"
          className="profile-back"
        >
          <ArrowLeft
            size={26}
            strokeWidth={1.6}
          />
        </Link>

        <h1>Profil</h1>

      </div>


      {/* PROFILE CONTENT */}
      <section className="profile-content">

        {/* FOTO PROFIL */}
        <div className="profile-photo-wrapper">

          <div className="profile-main-photo">

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


          {/* TOMBOL KAMERA */}
          <button
            type="button"
            className="profile-camera-button"
            onClick={handleChoosePhoto}
          >
            <Camera
              size={22}
              strokeWidth={1.6}
            />
          </button>


          {/* INPUT FILE */}
          <input
            ref={fileInputRef}
            type="file"
            accept="image/*"
            onChange={handlePhotoChange}
            style={{
              display: "none",
            }}
          />

        </div>


        {!isEditing ? (

          <>

            {/* NAMA */}
            <div className="profile-detail">

              <div className="profile-detail-icon">
                <User
                  size={28}
                  strokeWidth={1.5}
                />
              </div>

              <div>
                <h3>Nama</h3>

                <p>
                  {profile.nama}
                </p>
              </div>

            </div>


            {/* EMAIL */}
            <div className="profile-detail">

              <div className="profile-detail-icon">
                <Mail
                  size={28}
                  strokeWidth={1.5}
                />
              </div>

              <div>
                <h3>Email</h3>

                <p>
                  {profile.email}
                </p>
              </div>

            </div>


            {/* NOMOR TELEPON */}
            <div className="profile-detail">

              <div className="profile-detail-icon">
                <Phone
                  size={28}
                  strokeWidth={1.5}
                />
              </div>

              <div>
                <h3>
                  Nomor Telepon
                </h3>

                <p>
                  {profile.telepon}
                </p>
              </div>

            </div>


            {/* EDIT PROFIL */}
            <button
              type="button"
              className="profile-edit-button"
              onClick={handleEdit}
            >
              Edit Profil
            </button>

          </>

        ) : (

          /* FORM EDIT */
          <div className="profile-edit-form">

            <h2>
              Edit Profil
            </h2>


            {/* NAMA */}
            <div className="profile-input-group">

              <label htmlFor="nama">
                Nama
              </label>

              <input
                id="nama"
                type="text"
                value={nama}
                onChange={(e) =>
                  setNama(e.target.value)
                }
              />

            </div>


            {/* EMAIL */}
            <div className="profile-input-group">

              <label htmlFor="email">
                Email
              </label>

              <input
                id="email"
                type="email"
                value={email}
                onChange={(e) =>
                  setEmail(e.target.value)
                }
              />

            </div>


            {/* NOMOR TELEPON */}
            <div className="profile-input-group">

              <label htmlFor="telepon">
                Nomor Telepon
              </label>

              <input
                id="telepon"
                type="tel"
                value={telepon}
                onChange={(e) =>
                  setTelepon(e.target.value)
                }
              />

            </div>


            {/* TOMBOL */}
            <div className="profile-edit-actions">

              <button
                type="button"
                className="profile-cancel-button"
                onClick={handleCancel}
              >
                Cancel
              </button>

              <button
                type="button"
                className="profile-save-button"
                onClick={handleSave}
              >
                Simpan
              </button>

            </div>

          </div>

        )}

      </section>

    </main>
  );
}