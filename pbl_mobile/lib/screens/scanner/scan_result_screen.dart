import 'package:flutter/material.dart';

class ScanProductData {
  final String name;
  final String sku;
  final String stock;
  final String location;
  final String warehouse;
  final String area;
  final String level;

  const ScanProductData({
    required this.name,
    required this.sku,
    required this.stock,
    required this.location,
    required this.warehouse,
    required this.area,
    required this.level,
  });

  static const Map<String, ScanProductData> products = {
    'SKU-1042': ScanProductData(
      name: 'Kabel UTP Cat 6',
      sku: 'SKU-1042',
      stock: '12 unit',
      location: 'Rak A-12',
      warehouse: 'WH-01 • Malang Jatim',
      area: 'A • Penyimpanan kabel',
      level: 'Tingkat 2',
    ),
    'SKU-2198': ScanProductData(
      name: 'Switch 8 Port',
      sku: 'SKU-2198',
      stock: '4 unit',
      location: 'Rak B-05',
      warehouse: 'WH-01 • Malang Jatim',
      area: 'B • Perangkat jaringan',
      level: 'Tingkat 1',
    ),
    'SKU-3301': ScanProductData(
      name: 'Router WiFi AC1200',
      sku: 'SKU-3301',
      stock: '8 unit',
      location: 'Rak C-02',
      warehouse: 'WH-01 • Malang Jatim',
      area: 'C • Perangkat jaringan',
      level: 'Tingkat 2',
    ),
    'SKU-1587': ScanProductData(
      name: 'Konektor RJ45',
      sku: 'SKU-1587',
      stock: '50 unit',
      location: 'Rak A-08',
      warehouse: 'WH-01 • Malang Jatim',
      area: 'A • Kabel & konektor',
      level: 'Tingkat 1',
    ),
    'SKU-4420': ScanProductData(
      name: 'Patch Panel 24P',
      sku: 'SKU-4420',
      stock: '3 unit',
      location: 'Rak B-11',
      warehouse: 'WH-01 • Malang Jatim',
      area: 'B • Perangkat jaringan',
      level: 'Tingkat 3',
    ),
  };

  factory ScanProductData.fromBarcode(String barcode) {
    final value = barcode.trim();

    return products[value] ??
        ScanProductData(
          name: 'Barang Tidak Ditemukan',
          sku: value,
          stock: '—',
          location: '—',
          warehouse: 'WH-01 • Malang Jatim',
          area: 'Belum terdaftar',
          level: '—',
        );
  }
}

class ScanResultScreen extends StatelessWidget {
  final String barcode;

  const ScanResultScreen({
    super.key,
    required this.barcode,
  });

  @override
  Widget build(BuildContext context) {
    final product = ScanProductData.fromBarcode(barcode);

    final productName = product.name;
    final sku = product.sku;
    final stock = product.stock;
    final location = product.location;
    final warehouse = product.warehouse;
    final area = product.area;
    final level = product.level;

    final bool productFound =
        product.name != 'Barang Tidak Ditemukan';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: Column(
          children: [
            // =====================================================
            // HEADER
            // =====================================================

            Container(
              height: 50,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 32,
                      minHeight: 32,
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 19,
                      color: Color(0xFF202124),
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    'Scanner Gudang',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202124),
                    ),
                  ),
                ],
              ),
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  14,
                  10,
                  14,
                  16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // SUCCESS CARD
                    // =================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: productFound
                            ? const Color(0xFFE7F5E8)
                            : const Color(0xFFFFF2E8),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              color: productFound
                                  ? const Color(0xFFD5EED7)
                                  : const Color(0xFFFFE0C7),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              productFound
                                  ? Icons.check
                                  : Icons.warning_amber_rounded,
                              size: 12,
                              color: productFound
                                  ? const Color(0xFF587B55)
                                  : const Color(0xFFC27632),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                productFound
                                    ? 'Scan Berhasil'
                                    : 'Barang Tidak Ditemukan',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.w700,
                                  color: productFound
                                      ? const Color(0xFF587B55)
                                      : const Color(0xFFC27632),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                productFound
                                    ? 'Barang ditemukan di gudang aktif'
                                    : 'Barcode belum terdaftar di gudang aktif',
                                style: const TextStyle(
                                  fontSize: 7,
                                  color: Color(0xFF738174),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 9),

                    // =================================================
                    // PRODUCT CARD
                    // =================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                        9,
                        9,
                        9,
                        8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: 0.04,
                            ),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF3F6F3),
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.inventory_2_outlined,
                              size: 17,
                              color: Color(0xFF587B55),
                            ),
                          ),
                          const SizedBox(width: 9),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  productName,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF252936),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'SKU / Barcode: $sku',
                                  style: const TextStyle(
                                    fontSize: 7,
                                    color: Color(0xFF7D8794),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  'Stok tersedia',
                                  style: TextStyle(
                                    fontSize: 7,
                                    color: Color(0xFF87909D),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F3E8),
                              borderRadius:
                                  BorderRadius.circular(7),
                            ),
                            child: Text(
                              stock,
                              style: const TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF587B55),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 9),

                    // =================================================
                    // LOCATION CARD
                    // =================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                        9,
                        8,
                        9,
                        9,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: 0.04,
                            ),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 13,
                                color: Color(0xFF587B55),
                              ),
                              const SizedBox(width: 5),
                              const Text(
                                'Lokasi Penyimpanan Utama',
                                style: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF587B55),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 7),

                          Container(
                            width: double.infinity,
                            padding:
                                const EdgeInsets.symmetric(
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE7F3E7),
                              borderRadius:
                                  BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  location,
                                  style: const TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF587B55),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  productFound
                                      ? 'Barang saat ini berada di $location'
                                      : 'Lokasi barang belum tersedia',
                                  style: const TextStyle(
                                    fontSize: 6,
                                    color: Color(0xFF687A69),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 8),

                          _infoRow(
                            'Gudang',
                            warehouse,
                          ),

                          const Divider(
                            height: 12,
                            color: Color(0xFFE9ECEF),
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: _infoColumn(
                                  'Area',
                                  area,
                                ),
                              ),
                              Expanded(
                                child: _infoColumn(
                                  'Tingkat rak',
                                  level,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 9),

                    // =================================================
                    // BARCODE RESULT
                    // =================================================

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.qr_code_2,
                            size: 15,
                            color: Color(0xFF7D8794),
                          ),
                          const SizedBox(width: 7),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hasil barcode',
                                  style: TextStyle(
                                    fontSize: 7,
                                    color: Color(0xFF8A929E),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  barcode,
                                  style: const TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF30343B),
                                  ),
                                  maxLines: 1,
                                  overflow:
                                      TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 9),

                    // =================================================
                    // SCAN AGAIN
                    // =================================================

                    SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.qr_code_scanner,
                          size: 13,
                        ),
                        label: const Text(
                          'Scan Lagi',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF587B55),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 7),

                    // =================================================
                    // DETAIL BUTTON
                    // =================================================

                    SizedBox(
                      width: double.infinity,
                      height: 32,
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(
                            SnackBar(
                              content: Text(
                                productFound
                                    ? 'Detail $productName akan dibuka.'
                                    : 'Detail barang belum tersedia.',
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor:
                              const Color(0xFF587B55),
                          side: const BorderSide(
                            color: Color(0xFFE1E6E2),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Lihat Detail Barang',
                          style: TextStyle(
                            fontSize: 8,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // =====================================================
            // BOTTOM NAVIGATION
            // =====================================================

            Container(
              height: 56,
              color: Colors.white,
              child: Row(
                children: [
                  _bottomItem(
                    icon: Icons.home_outlined,
                    label: 'Beranda',
                    active: false,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _bottomItem(
                    icon: Icons.qr_code_scanner,
                    label: 'Scanner',
                    active: true,
                    onTap: () {},
                  ),
                  _bottomItem(
                    icon: Icons.receipt_long_outlined,
                    label: 'Riwayat',
                    active: false,
                    onTap: () {},
                  ),
                  _bottomItem(
                    icon: Icons.person_outline,
                    label: 'Profil',
                    active: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =============================================================
  // INFO ROW
  // =============================================================

  static Widget _infoRow(
    String label,
    String value,
  ) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 7,
            color: Color(0xFF87909D),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 7,
              fontWeight: FontWeight.w600,
              color: Color(0xFF30343B),
            ),
          ),
        ),
      ],
    );
  }

  // =============================================================
  // INFO COLUMN
  // =============================================================

  static Widget _infoColumn(
    String label,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 6,
            color: Color(0xFF87909D),
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 7,
            fontWeight: FontWeight.w600,
            color: Color(0xFF30343B),
          ),
        ),
      ],
    );
  }

  // =============================================================
  // BOTTOM ITEM
  // =============================================================

  static Widget _bottomItem({
    required IconData icon,
    required String label,
    required bool active,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: active ? 34 : 25,
              height: active ? 28 : 22,
              decoration: active
                  ? const BoxDecoration(
                      color: Color(0xFFE2EDE2),
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Icon(
                icon,
                size: active ? 16 : 15,
                color: active
                    ? const Color(0xFF587B55)
                    : const Color(0xFF7E8793),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 7,
                fontWeight:
                    active ? FontWeight.w600 : FontWeight.w400,
                color: active
                    ? const Color(0xFF587B55)
                    : const Color(0xFF7E8793),
              ),
            ),
          ],
        ),
      ),
    );
  }
}