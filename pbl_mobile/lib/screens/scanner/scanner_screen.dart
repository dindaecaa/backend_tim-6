import 'package:flutter/material.dart';

import 'scanner_camera_screen.dart';
import 'scan_result_screen.dart';

class ScannerScreen extends StatelessWidget {
  const ScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    16,
                    15,
                    16,
                    20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // =====================================================
                      // HEADER
                      // =====================================================

                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              size: 22,
                            ),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 14),
                          const Text(
                            'Scanner Gudang',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF111111),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 22),

                      // =====================================================
                      // DESCRIPTION
                      // =====================================================

                      const Center(
                        child: Text(
                          'Pindai barcode untuk memantau stok dan lokasi',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF777777),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // =====================================================
                      // FILTER INBOUND / OUTBOUND
                      // =====================================================

                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE7F0E5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Inbound',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF587354),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'Outbound',
                                style: TextStyle(
                                  fontSize: 9,
                                  color: Color(0xFF777777),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 15),

                      // =====================================================
                      // GUDANG AKTIF
                      // =====================================================

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFE7E7E7),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Gudang Aktif',
                                  style: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFF6C816A),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 9,
                                    vertical: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8F2E5),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: const Text(
                                    'Siap',
                                    style: TextStyle(
                                      fontSize: 8,
                                      color: Color(0xFF547250),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 3),
                            const Text(
                              'WH-01 • Malang Jatim',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 14),
                            const Row(
                              children: [
                                Expanded(
                                  child: _StockInfo(
                                    title: 'Stok aktif',
                                    value: '1.284',
                                  ),
                                ),
                                Expanded(
                                  child: _StockInfo(
                                    title: 'Stok kosong',
                                    value: '216',
                                  ),
                                ),
                                Expanded(
                                  child: _StockInfo(
                                    title: 'Scan hari ini',
                                    value: '38',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 12),

                      // =====================================================
                      // BARCODE / SKU
                      // =====================================================

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: const Color(0xFFE7E7E7),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Barcode / SKU',
                                    style: TextStyle(
                                      fontSize: 9,
                                      color: Color(0xFF777777),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Pindai atau masukkan manual',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF0F4EF),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text(
                                'Manual',
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Color(0xFF587354),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 9),

                      // =====================================================
                      // BUTTON SCAN
                      // =====================================================

                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 38,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const ScannerCameraScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color(0xFF5E7C5B),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                                child: const Text(
                                  'Mulai Scan',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SizedBox(
                              height: 38,
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  foregroundColor:
                                      const Color(0xFF5E7C5B),
                                  side: const BorderSide(
                                    color: Color(0xFFE1E8DE),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(11),
                                  ),
                                ),
                                child: const Text(
                                  'Riwayat Scan',
                                  style: TextStyle(
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      // =====================================================
                      // SCAN TERBARU
                      // =====================================================

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Scan Terbaru',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Lihat semua',
                              style: TextStyle(
                                fontSize: 8,
                                color: Color(0xFF5E7C5B),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // =====================================================
                      // SCAN TERBARU 1
                      // =====================================================

                      _recentScan(
                        context: context,
                        sku: 'SKU-1042 • Kabel UTP Cat 6',
                        detail: 'Rak A-12 • 12 unit • 09:42',
                        barcode: 'SKU-1042',
                      ),

                      const SizedBox(height: 7),

                      // =====================================================
                      // SCAN TERBARU 2
                      // =====================================================

                      _recentScan(
                        context: context,
                        sku: 'SKU-2198 • Switch 8 Port',
                        detail: 'Rak B-05 • 4 unit • 09:18',
                        barcode: 'SKU-2198',
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // =====================================================
            // BOTTOM NAVIGATION
            // =====================================================

            _BottomNavigation(
              selectedIndex: 1,
              onHome: () {
                Navigator.pop(context);
              },
              onScanner: () {},
            ),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // SCAN TERBARU CARD
  // ===============================================================

  Widget _recentScan({
    required BuildContext context,
    required String sku,
    required String detail,
    required String barcode,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScanResultScreen(
              barcode: barcode,
            ),
          ),
        );
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(11),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: const Color(0xFFE9E9E9),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 29,
              height: 29,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F5EE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                size: 15,
                color: Color(0xFF607D5C),
              ),
            ),

            const SizedBox(width: 9),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sku,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    detail,
                    style: const TextStyle(
                      fontSize: 7,
                      color: Color(0xFF777777),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3E8),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Diterima',
                style: TextStyle(
                  fontSize: 7,
                  color: Color(0xFF5B7757),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===================================================================
// STOCK INFO
// ===================================================================

class _StockInfo extends StatelessWidget {
  final String title;
  final String value;

  const _StockInfo({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 8,
            color: Color(0xFF777777),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

// ===================================================================
// BOTTOM NAVIGATION
// ===================================================================

class _BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final VoidCallback onHome;
  final VoidCallback onScanner;

  const _BottomNavigation({
    required this.selectedIndex,
    required this.onHome,
    required this.onScanner,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            label: 'Home',
            selected: selectedIndex == 0,
            onTap: onHome,
          ),
          _NavItem(
            icon: Icons.qr_code_scanner,
            label: 'Scanner',
            selected: selectedIndex == 1,
            onTap: onScanner,
            scanner: true,
          ),
          _NavItem(
            icon: Icons.receipt_long_outlined,
            label: 'Riwayat',
            selected: selectedIndex == 2,
            onTap: () {},
          ),
          _NavItem(
            icon: Icons.person_outline,
            label: 'Profil',
            selected: selectedIndex == 3,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ===================================================================
// NAV ITEM
// ===================================================================

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final bool scanner;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.scanner = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: scanner ? 42 : 27,
            height: scanner ? 42 : 27,
            decoration: scanner && selected
                ? BoxDecoration(
                    color: const Color(0xFF6D8968),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD8E4D5),
                      width: 4,
                    ),
                  )
                : null,
            child: Icon(
              icon,
              size: 19,
              color: selected
                  ? const Color(0xFF5E7C5B)
                  : const Color(0xFF6D7480),
            ),
          ),
          if (!scanner) ...[
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 8,
                color: selected
                    ? const Color(0xFF5E7C5B)
                    : const Color(0xFF6D7480),
              ),
            ),
          ],
        ],
      ),
    );
  }
}