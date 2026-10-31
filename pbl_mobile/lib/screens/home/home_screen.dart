import 'package:flutter/material.dart';

import '../../models/user_data.dart';
import '../../widgets/ai_stock_notification.dart';

import '../scanner/scanner_screen.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';

import '../inventory/stock_in_screen.dart';
import '../inventory/stock_out_screen.dart';
import '../inventory/data_barang_screen.dart';
import '../inventory/category_custom_screen.dart';
import '../inventory/unit_custom_screen.dart';

import '../management/supplier_screen.dart';
import '../management/customer_screen.dart';

class HomeScreen extends StatelessWidget {
  final UserData? user;

  const HomeScreen({
    super.key,
    this.user,
  });

  static const Color primaryGreen = Color(0xFF587B55);
  static const Color backgroundColor = Color(0xFFF4F5F8);

  // =========================================================
  // NAVIGATION
  // =========================================================

  void _openPage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => page,
      ),
    );
  }

  void _openScanner(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const ScannerScreen(),
      ),
    );
  }

  void _openHistory(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HistoryScreen(),
      ),
    );
  }

  void _openProfile(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => ProfileScreen(
          user: user,
        ),
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final displayName = user?.name.trim().isNotEmpty == true
        ? user!.name.trim()
        : 'Zefanya.A';

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, displayName),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  10,
                  12,
                  20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPromoCard(),
                    const SizedBox(height: 8),
                    _buildWarehouseCard(),
                    const SizedBox(height: 8),
                    _buildTotalDataCard(),
                    const SizedBox(height: 14),
                    _buildDataBarang(context),
                    const SizedBox(height: 14),

                    const Text(
                      'Menu Cepat',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF30343B),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: _menuCard(
                            icon: Icons.inventory_2_outlined,
                            title: 'Stok Masuk',
                            color: primaryGreen,
                            onTap: () {
                              _openPage(
                                context,
                                StockInScreen(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _menuCard(
                            icon: Icons.outbox_outlined,
                            title: 'Stok Keluar',
                            color: const Color(0xFFF44336),
                            onTap: () {
                              _openPage(
                                context,
                                StockOutScreen(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _menuCard(
                            icon: Icons.people_outline,
                            title: 'Pelanggan',
                            color: const Color(0xFFFF9800),
                            onTap: () {
                              _openPage(
                                context,
                                CustomerScreen(
                                  user: user ??
                                      UserData(
                                        name: 'Zefanya.A',
                                        email: '',
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Row(
                      children: [
                        Expanded(
                          child: _menuCard(
                            icon: Icons.category_outlined,
                            title: 'Kategori',
                            color: const Color(0xFF7C3AED),
                            onTap: () {
                              _openPage(
                                context,
                                const CategoryCustomScreen(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _menuCard(
                            icon: Icons.straighten_outlined,
                            title: 'Satuan',
                            color: const Color(0xFF2563EB),
                            onTap: () {
                              _openPage(
                                context,
                                const UnitCustomScreen(),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _menuCard(
                            icon: Icons.local_shipping_outlined,
                            title: 'Pemasok',
                            color: const Color(0xFF11A8E2),
                            onTap: () {
                              _openPage(
                                context,
                                const SupplierScreen(),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  // =========================================================
  // HEADER
  // =========================================================

  Widget _buildHeader(
    BuildContext context,
    String displayName,
  ) {
    return Container(
      height: 72,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.white,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: primaryGreen,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              _getInitials(displayName),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Text(
              displayName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),
          ),

          IconButton(
            tooltip: 'Notifikasi stok',
            onPressed: () {
              AiStockNotification.show(
                context,
                onFillStock: () {
                  _openPage(
                    context,
                    StockInScreen(),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.notifications_none_outlined,
              color: Color(0xFF596579),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // PROMO CARD
  // =========================================================

  Widget _buildPromoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8EF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFFFD59B),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFFF9200),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.bolt,
              color: Colors.white,
              size: 24,
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Promo Spesial!',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF7800),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Gratis 2 bulan jika berlangganan tahunan',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF777777),
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right,
            color: Color(0xFF777777),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // WAREHOUSE CARD
  // =========================================================

  Widget _buildWarehouseCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFD7E5FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.storefront_outlined,
              color: Color(0xFF3878E8),
              size: 23,
            ),
          ),

          const SizedBox(width: 12),

          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'stock.co',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF30343B),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Owner',
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF7B8490),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // =========================================================
  // TOTAL DATA CARD
  // =========================================================

  Widget _buildTotalDataCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Total Data',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF30343B),
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F5F7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 12,
                      color: Color(0xFF718096),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '30 Hari Terakhir',
                      style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF718096),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: _totalDataItem(
                  title: 'Stok Masuk',
                  value: '0',
                  subtitle: 'Transaksi masuk',
                  icon: Icons.arrow_downward,
                  color: const Color(0xFF16B86A),
                ),
              ),

              Container(
                width: 1,
                height: 65,
                color: const Color(0xFFF0F1F3),
              ),

              Expanded(
                child: _totalDataItem(
                  title: 'Stok Keluar',
                  value: '0',
                  subtitle: 'Transaksi keluar',
                  icon: Icons.arrow_upward,
                  color: const Color(0xFFFF4D4D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _totalDataItem({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF7D8694),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),

          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFF7D8694),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // DATA BARANG
  // =========================================================

  Widget _buildDataBarang(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openPage(
          context,
          const DataBarangScreen(),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3E8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                color: primaryGreen,
                size: 24,
              ),
            ),

            const SizedBox(width: 12),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Data Barang',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF30343B),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Stok: 0 Unit',
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xFF7D8694),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Nilai Modal: Rp 0',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.chevron_right,
              color: Color(0xFF718096),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // MENU CARD
  // =========================================================

  Widget _menuCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 105,
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.035),
                blurRadius: 7,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 22,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: const TextStyle(
                  fontSize: 10,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF30343B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // BOTTOM NAVIGATION
  // =========================================================

  Widget _buildBottomNavigation(BuildContext context) {
    return Container(
      height: 68,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFECEEF1),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomItem(
            icon: Icons.home_outlined,
            label: 'Home',
            selected: true,
            onTap: () {},
          ),

          _bottomItem(
            icon: Icons.qr_code_scanner,
            label: 'Scanner',
            selected: false,
            onTap: () => _openScanner(context),
          ),

          _bottomItem(
            icon: Icons.receipt_long_outlined,
            label: 'Riwayat',
            selected: false,
            onTap: () => _openHistory(context),
          ),

          _bottomItem(
            icon: Icons.person_outline,
            label: 'Profil',
            selected: false,
            onTap: () => _openProfile(context),
          ),
        ],
      ),
    );
  }

  Widget _bottomItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 22,
                color: selected
                    ? primaryGreen
                    : const Color(0xFF718096),
              ),

              const SizedBox(height: 4),

              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: selected
                      ? FontWeight.w700
                      : FontWeight.w400,
                  color: selected
                      ? primaryGreen
                      : const Color(0xFF718096),
                ),
              ),

              const SizedBox(height: 3),

              Container(
                width: selected ? 5 : 0,
                height: 5,
                decoration: const BoxDecoration(
                  color: primaryGreen,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // INITIALS
  // =========================================================

  String _getInitials(String name) {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.isEmpty) {
      return 'ZA';
    }

    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }

    final value = parts.first;

    if (value.length >= 2) {
      return value.substring(0, 2).toUpperCase();
    }

    return value[0].toUpperCase();
  }
}