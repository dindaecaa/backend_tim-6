"use client";

import { useState } from "react";

type SKUData = {
  id: number;
  sku: string;
  nama: string;
  kategori: string;
  stok: number;
  lokasi: string;
};


/* =========================================================
   PROPS TAMBAH SKU
========================================================= */

type AddProps = {
  mode: "add";
  initialData?: undefined;
  onClose: () => void;
  onSave: (data: Omit<SKUData, "id">) => void;
};


/* =========================================================
   PROPS EDIT SKU
========================================================= */

type EditProps = {
  mode: "edit";
  initialData: SKUData;
  onClose: () => void;
  onSave: (data: SKUData) => void;
};


type UpdateStokModalProps = AddProps | EditProps;


/* =========================================================
   COMPONENT
========================================================= */

export default function UpdateStokModal(
  props: UpdateStokModalProps
) {

  const {
    mode,
    onClose,
  } = props;


  const [sku, setSku] = useState(
    props.mode === "edit"
      ? props.initialData.sku
      : ""
  );

  const [nama, setNama] = useState(
    props.mode === "edit"
      ? props.initialData.nama
      : ""
  );

  const [kategori, setKategori] = useState(
    props.mode === "edit"
      ? props.initialData.kategori
      : ""
  );

  const [stok, setStok] = useState(
    props.mode === "edit"
      ? String(props.initialData.stok)
      : ""
  );

  const [lokasi, setLokasi] = useState(
    props.mode === "edit"
      ? props.initialData.lokasi
      : ""
  );


  /* =====================================================
     SIMPAN
  ===================================================== */

  const handleSubmit = () => {

    if (
      !sku.trim() ||
      !nama.trim() ||
      !kategori ||
      !stok ||
      !lokasi.trim()
    ) {
      alert("Mohon lengkapi semua data SKU.");
      return;
    }


    const data = {
      sku: sku.trim(),
      nama: nama.trim(),
      kategori,
      stok: Number(stok),
      lokasi: lokasi.trim(),
    };


    /* EDIT */

    if (mode === "edit") {

      props.onSave({
        id: props.initialData.id,
        ...data,
      });

      return;
    }


    /* TAMBAH */

    props.onSave(data);

  };


  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-black/30">

      <div className="w-97.5 bg-white p-5 shadow-lg">

        {/* =================================================
            TITLE
        ================================================= */}

        <h2 className="mb-6 text-lg font-bold text-[#1A1A1A]">

          {mode === "edit"
            ? "Edit SKU"
            : "Tambah SKU"}

        </h2>


        {/* =================================================
            KODE SKU
        ================================================= */}

        <div className="mb-3 flex items-center">

          <label className="w-26.25 text-xs">
            Kode SKU
          </label>

          <input
            type="text"
            value={sku}
            onChange={(e) =>
              setSku(e.target.value)
            }
            placeholder="Contoh : SKU - 003"
            className="h-10 flex-1 border border-[#22C77A] px-3 text-xs outline-none"
          />

        </div>


        {/* =================================================
            NAMA BARANG
        ================================================= */}

        <div className="mb-3 flex items-center">

          <label className="w-26.25 text-xs">
            Nama Barang
          </label>

          <input
            type="text"
            value={nama}
            onChange={(e) =>
              setNama(e.target.value)
            }
            placeholder="Masukkan nama barang"
            className="h-10 flex-1 border border-[#22C77A] px-3 text-xs outline-none"
          />

        </div>


        {/* =================================================
            KATEGORI
        ================================================= */}

        <div className="mb-3 flex items-center">

          <label className="w-26.25 text-xs">
            Kategori
          </label>

          <select
            value={kategori}
            onChange={(e) =>
              setKategori(e.target.value)
            }
            className="h-10 flex-1 border border-[#22C77A] bg-white px-3 text-xs outline-none"
          >

            <option value="">
              Pilih Kategori
            </option>

            <option value="Elektronik">
              Elektronik
            </option>

            <option value="ATK">
              ATK
            </option>

            <option value="Kabel">
              Kabel
            </option>

            <option value="Furniture">
              Furniture
            </option>

            <option value="Peralatan Gudang">
              Peralatan Gudang
            </option>

          </select>

        </div>


        {/* =================================================
            JUMLAH STOK
        ================================================= */}

        <div className="mb-3 flex items-center">

          <label className="w-26.25 text-xs">
            Jumlah Stok
          </label>

          <input
            type="number"
            min="0"
            value={stok}
            onChange={(e) =>
              setStok(e.target.value)
            }
            placeholder="Masukkan jumlah stok"
            className="h-10 flex-1 border border-[#22C77A] px-3 text-xs outline-none"
          />

        </div>


        {/* =================================================
            RAK
        ================================================= */}

        <div className="mb-5 flex items-center">

          <label className="w-26.25 text-xs">
            Rak
          </label>

          <input
            type="text"
            value={lokasi}
            onChange={(e) =>
              setLokasi(e.target.value)
            }
            placeholder="Contoh : A1"
            className="h-10 flex-1 border border-[#22C77A] px-3 text-xs outline-none"
          />

        </div>


        {/* =================================================
            BUTTON
        ================================================= */}

        <div className="flex justify-end gap-5">

          <button
            type="button"
            onClick={onClose}
            className="h-8 w-16.25 rounded-md border border-[#22C77A] text-xs"
          >
            Batal
          </button>


          <button
            type="button"
            onClick={handleSubmit}
            className="h-8 w-16.25 rounded-md bg-[#587653] text-xs text-white"
          >

            {mode === "edit"
              ? "Update"
              : "Simpan"}

          </button>

        </div>

      </div>

    </div>
  );
}