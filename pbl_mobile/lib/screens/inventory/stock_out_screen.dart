import 'package:flutter/material.dart';

import '../../models/user_data.dart';
import '../home/home_screen.dart';
import '../scanner/scanner_screen.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';

class StockOutScreen extends StatefulWidget {
  final UserData user;

  StockOutScreen({
    super.key,
    UserData? user,
  }) : user = user ??
            UserData(
              name: 'Zefanya',
              email: '',
            );

  @override
  State<StockOutScreen> createState() => _StockOutScreenState();
}

class _StockOutScreenState extends State<StockOutScreen> {
  final TextEditingController searchController =
      TextEditingController();

  String searchQuery = '';

  final List<StockOutTransaction> transactions = [
    StockOutTransaction(
      date: '28 Sep 2026',
      time: '14:32',
      product: 'Air Mineral 600ml',
      customer: 'PT Sinar Abadi',
      transactionCode: '#SK-260928-018',
      quantity: '-24 unit',
      status: StockOutStatus.success,
    ),
    StockOutTransaction(
      date: '28 Sep 2026',
      time: '11:08',
      product: 'Kertas A4 80 gsm',
      customer: 'Toko Berkah Jaya',
      transactionCode: '#SK-260928-017',
      quantity: '-10 rim',
      status: StockOutStatus.success,
    ),
    StockOutTransaction(
      date: '27 Sep 2026',
      time: '16:45',
      product: 'Kabel Data USB-C',
      customer: 'Rina Elektronik',
      transactionCode: '#SK-260927-016',
      quantity: '-8 pcs',
      status: StockOutStatus.failed,
    ),
    StockOutTransaction(
      date: '27 Sep 2026',
      time: '09:20',
      product: 'Tinta Printer Epson 003',
      customer: 'CV Maju Bersama',
      transactionCode: '#SK-260927-015',
      quantity: '-6 botol',
      status: StockOutStatus.success,
    ),
  ];

  List<StockOutTransaction> get filteredTransactions {
    if (searchQuery.trim().isEmpty) {
      return transactions;
    }

    final query = searchQuery.toLowerCase().trim();

    return transactions.where((transaction) {
      return transaction.product.toLowerCase().contains(query) ||
          transaction.customer.toLowerCase().contains(query) ||
          transaction.transactionCode.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // NAVIGATION

  void goHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  void goScanner() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ScannerScreen(),
      ),
    );
  }

  void goHistory() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HistoryScreen(),
      ),
    );
  }

  void goProfile() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(),
      ),
    );
  }

  // FILTER

  void showFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter Stok Keluar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(
                    Icons.calendar_today_outlined,
                  ),
                  title: const Text('Tanggal'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Pelanggan'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.error_outline),
                  title: const Text('Status'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  // TRANSACTION DETAIL

  void openTransactionDetail(
    StockOutTransaction transaction,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        final bool isFailed =
            transaction.status == StockOutStatus.failed;

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Detail Transaksi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(),
                _detailRow('Barang', transaction.product),
                _detailRow(
                  'Tanggal',
                  '${transaction.date}, ${transaction.time}',
                ),
                _detailRow('Pelanggan', transaction.customer),
                _detailRow('Jumlah', transaction.quantity),
                _detailRow('Kode', transaction.transactionCode),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isFailed
                        ? const Color(0xFFFFEEEE)
                        : const Color(0xFFE8F8EF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isFailed
                            ? Icons.error_outline
                            : Icons.check_circle_outline,
                        size: 18,
                        color: isFailed
                            ? const Color(0xFFFF5964)
                            : const Color(0xFF20B968),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isFailed
                            ? 'Transaksi Gagal'
                            : 'Transaksi Berhasil',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isFailed
                              ? const Color(0xFFFF5964)
                              : const Color(0xFF20B968),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 85,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF8A929E),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xFF30343B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // BUILD

  @override
  Widget build(BuildContext context) {
    final data = filteredTransactions;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F8),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              height: 52,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF0F4FF),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 18,
                        color: Color(0xFF3576E8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Stok Keluar',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202124),
                    ),
                  ),
                ],
              ),
            ),

            // CONTENT
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _searchBar(),
                    const SizedBox(height: 9),
                    _summaryCard(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Transaksi terbaru',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF30343B),
                            ),
                          ),
                        ),
                        const Text(
                          'September 2026',
                          style: TextStyle(
                            fontSize: 8,
                            color: Color(0xFF7D8590),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (data.isEmpty)
                      _emptySearchState()
                    else
                      ...data.map(
                        (transaction) => _transactionCard(transaction),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // SEARCH BAR

  Widget _searchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE1E5EA),
              ),
            ),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              style: const TextStyle(fontSize: 9),
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.search,
                  size: 16,
                  color: Color(0xFF657286),
                ),
                hintText: 'Cari barang atau transaksi',
                hintStyle: TextStyle(
                  fontSize: 8,
                  color: Color(0xFF9CA3AF),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 34,
          height: 34,
          child: ElevatedButton(
            onPressed: showFilter,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF707C6E),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
            child: const Icon(
              Icons.tune,
              size: 17,
            ),
          ),
        ),
      ],
    );
  }

  // SUMMARY CARD

  Widget _summaryCard() {
    return Container(
      height: 73,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF667A65),
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 33,
            height: 33,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.inventory_2_outlined,
              color: Colors.white,
              size: 19,
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Barang keluar bulan ini',
                  style: TextStyle(
                    fontSize: 8,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 1),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '128',
                      style: TextStyle(
                        fontSize: 22,
                        height: 1,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 1),
                      child: Text(
                        'unit',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 45,
            height: 42,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '18',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'transaksi',
                  style: TextStyle(
                    fontSize: 6,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // TRANSACTION CARD

  Widget _transactionCard(StockOutTransaction transaction) {
    final bool isFailed =
        transaction.status == StockOutStatus.failed;

    return GestureDetector(
      onTap: () {
        openTransactionDetail(transaction);
      },
      child: Container(
        width: double.infinity,
        height: 67,
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(
          horizontal: 9,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ICON
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF0FF),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.inventory_2_outlined,
                size: 16,
                color: Color(0xFF687993),
              ),
            ),
            const SizedBox(width: 8),

            // INFORMATION
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${transaction.date} · ${transaction.time}',
                    style: const TextStyle(
                      fontSize: 7,
                      color: Color(0xFF8A929E),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    transaction.product,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF30343B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          transaction.customer,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 7,
                            color: Color(0xFF8A929E),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        transaction.transactionCode,
                        style: const TextStyle(
                          fontSize: 6,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 5),

            // QUANTITY
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: isFailed
                    ? const Color(0xFFFF0000)
                    : const Color(0xFFF0F3F8),
                borderRadius: BorderRadius.circular(9),
              ),
              child: Text(
                transaction.quantity,
                style: TextStyle(
                  fontSize: 7,
                  fontWeight: FontWeight.w600,
                  color: isFailed
                      ? Colors.white
                      : const Color(0xFF677181),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // EMPTY SEARCH

  Widget _emptySearchState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: const Column(
        children: [
          Icon(
            Icons.search_off,
            size: 40,
            color: Color(0xFFB5BBC4),
          ),
          SizedBox(height: 10),
          Text(
            'Transaksi tidak ditemukan',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF555C66),
            ),
          ),
          SizedBox(height: 5),
          Text(
            'Coba gunakan kata kunci yang berbeda.',
            style: TextStyle(
              fontSize: 8,
              color: Color(0xFF9AA1AC),
            ),
          ),
        ],
      ),
    );
  }

  // BOTTOM NAVIGATION

  Widget _buildBottomNavigation() {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomItem(
            icon: Icons.home_outlined,
            label: 'Home',
            selected: false,
            onTap: goHome,
          ),
          _bottomItem(
            icon: Icons.qr_code_scanner,
            label: 'Scanner',
            selected: false,
            onTap: goScanner,
          ),
          _bottomItem(
            icon: Icons.receipt_long_outlined,
            label: 'Riwayat',
            selected: false,
            onTap: goHistory,
          ),
          _bottomItem(
            icon: Icons.person_outline,
            label: 'Profil',
            selected: false,
            onTap: goProfile,
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
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 19,
              color: selected
                  ? const Color(0xFF587B55)
                  : const Color(0xFF718096),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 8,
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.w400,
                color: selected
                    ? const Color(0xFF587B55)
                    : const Color(0xFF718096),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// MODEL

class StockOutTransaction {
  final String date;
  final String time;
  final String product;
  final String customer;
  final String transactionCode;
  final String quantity;
  final StockOutStatus status;

  StockOutTransaction({
    required this.date,
    required this.time,
    required this.product,
    required this.customer,
    required this.transactionCode,
    required this.quantity,
    required this.status,
  });
}

enum StockOutStatus {
  success,
  failed,
}