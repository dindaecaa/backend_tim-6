import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../scanner/scanner_screen.dart';
import 'receipt_preview_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  int selectedTab = 0;

  final List<HistoryItem> historyData = [
    HistoryItem(
      name: 'Kabel UTP Cat 6',
      sku: 'SKU-1042',
      quantity: '12 unit',
      date: 'Hari ini, 08:30',
      type: HistoryType.inbound,
      status: 'Diterima',
    ),
    HistoryItem(
      name: 'Switch 8 Port',
      sku: 'SKU-2198',
      quantity: '4 unit',
      date: 'Kemarin, 09:18',
      type: HistoryType.outbound,
      status: 'Dikeluarkan',
    ),
    HistoryItem(
      name: 'Router WiFi AC1200',
      sku: 'SKU-3301',
      quantity: '8 unit',
      date: 'Kemarin, 14:15',
      type: HistoryType.inbound,
      status: 'Diterima',
    ),
    HistoryItem(
      name: 'Konektor RJ45',
      sku: 'SKU-1587',
      quantity: '50 unit',
      date: '25 Sep, 10:00',
      type: HistoryType.outbound,
      status: 'Dikeluarkan',
    ),
    HistoryItem(
      name: 'Patch Panel 24P',
      sku: 'SKU-4420',
      quantity: '3 unit',
      date: '24 Sep, 16:45',
      type: HistoryType.inbound,
      status: 'Diterima',
    ),
  ];

  List<HistoryItem> get filteredHistory {
    if (selectedTab == 0) return historyData;

    if (selectedTab == 1) {
      return historyData
          .where((item) => item.type == HistoryType.inbound)
          .toList();
    }

    return historyData
        .where((item) => item.type == HistoryType.outbound)
        .toList();
  }

  void _openReceipt(HistoryItem item) {
    final transactionNumber = item.type == HistoryType.inbound
        ? '#SM-260928-${item.sku.substring(4)}'
        : '#SK-260928-${item.sku.substring(4)}';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptPreviewScreen(
          transactionNumber: transactionNumber,
          date: item.date,
          type: item.type == HistoryType.inbound ? 'Stok Masuk' : 'Stok Keluar',
          productName: item.name,
          sku: item.sku,
          quantity: item.quantity,
          status: item.status,
        ),
      ),
    );
  }

  void _showSearchDialog() {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Cari Riwayat'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'Nama barang atau SKU',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                final query = controller.text.trim().toLowerCase();

                if (query.isEmpty) {
                  Navigator.pop(dialogContext);
                  return;
                }

                final found = historyData.where((item) {
                  return item.name.toLowerCase().contains(query) ||
                      item.sku.toLowerCase().contains(query);
                }).toList();

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      found.isEmpty
                          ? 'Riwayat tidak ditemukan'
                          : '${found.length} riwayat ditemukan',
                    ),
                  ),
                );
              },
              child: const Text('Cari'),
            ),
          ],
        );
      },
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Filter Riwayat',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                ListTile(
                  leading: const Icon(Icons.calendar_today_outlined),
                  title: const Text('Tanggal'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  leading: const Icon(Icons.warehouse_outlined),
                  title: const Text('Gudang'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPrintMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Pilih salah satu riwayat untuk melihat pratinjau struk.',
        ),
      ),
    );
  }

  void _onBottomNavigationTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }

    if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ScannerScreen(),
        ),
      );
    }

    if (index == 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Halaman Profil akan dibuka dari menu Profil.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = filteredHistory;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F8),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 9),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Riwayat',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF202124),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _showSearchDialog,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 38,
                      minHeight: 32,
                    ),
                    icon: const Icon(
                      Icons.search,
                      size: 21,
                      color: Color(0xFF4F5573),
                    ),
                  ),
                  IconButton(
                    onPressed: _showFilterDialog,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 38,
                      minHeight: 32,
                    ),
                    icon: const Icon(
                      Icons.filter_alt_outlined,
                      size: 20,
                      color: Color(0xFF4F5573),
                    ),
                  ),
                  IconButton(
                    onPressed: _showPrintMessage,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(
                      minWidth: 38,
                      minHeight: 32,
                    ),
                    icon: const Icon(
                      Icons.print_outlined,
                      size: 20,
                      color: Color(0xFF4F5573),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    _buildTabBar(),
                    const SizedBox(height: 10),
                    if (data.isEmpty)
                      _buildEmptyState()
                    else
                      _buildHistoryList(data),
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

  Widget _buildTabBar() {
    return Container(
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
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
          _tabItem(title: 'Semua', index: 0),
          _tabItem(title: 'Stok Masuk', index: 1),
          _tabItem(title: 'Stok Keluar', index: 2),
        ],
      ),
    );
  }

  Widget _tabItem({
    required String title,
    required int index,
  }) {
    final isSelected = selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedTab = index;
          });
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border(
              right: index != 2
                  ? const BorderSide(color: Color(0xFFF0F0F0))
                  : BorderSide.none,
              bottom: isSelected
                  ? const BorderSide(
                      color: Color(0xFF2388E8),
                      width: 2,
                    )
                  : BorderSide.none,
            ),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              color: isSelected
                  ? const Color(0xFF2388E8)
                  : const Color(0xFF687080),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHistoryList(List<HistoryItem> data) {
    return Column(
      children: data.map(_historyCard).toList(),
    );
  }

  Widget _historyCard(HistoryItem item) {
    final isInbound = item.type == HistoryType.inbound;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        elevation: 1,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () => _openReceipt(item),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 9,
              vertical: 8,
            ),
            child: Row(
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: isInbound
                        ? const Color(0xFFD9F8E8)
                        : const Color(0xFFFFE4E5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isInbound
                        ? Icons.arrow_downward
                        : Icons.arrow_upward,
                    size: 15,
                    color: isInbound
                        ? const Color(0xFF18C77A)
                        : const Color(0xFFFF5964),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF30343B),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${item.sku} Â· ${item.quantity}',
                        style: const TextStyle(
                          fontSize: 8,
                          color: Color(0xFF8B93A1),
                        ),
                      ),
                      const SizedBox(height: 3),
                      const Text(
                        'Ketuk untuk melihat struk',
                        style: TextStyle(
                          fontSize: 7,
                          color: Color(0xFF9AA1AC),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      item.date,
                      style: const TextStyle(
                        fontSize: 8,
                        color: Color(0xFF9AA1AC),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isInbound
                            ? const Color(0xFFD9F8E8)
                            : const Color(0xFFFFD9DB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item.status,
                        style: TextStyle(
                          fontSize: 7,
                          fontWeight: FontWeight.w500,
                          color: isInbound
                              ? const Color(0xFF18A96B)
                              : const Color(0xFFFF5964),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 3),
                const Icon(
                  Icons.chevron_right,
                  size: 17,
                  color: Color(0xFF9AA1AC),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 420,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: const BoxDecoration(
                color: Color(0xFFE1EBF9),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.folder_open_outlined,
                size: 43,
                color: Color(0xFF3974D9),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Tidak Ada Riwayat',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF202124),
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              'Tidak ditemukan riwayat, silakan lakukan\n'
              'beberapa transaksi terlebih dahulu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                height: 1.5,
                color: Color(0xFF9AA1AC),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 58,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE8E9EC)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomItem(
            icon: Icons.home_outlined,
            label: 'Home',
            selected: false,
            onTap: () => _onBottomNavigationTapped(0),
          ),
          _bottomItem(
            icon: Icons.qr_code_scanner_outlined,
            label: 'Scan',
            selected: false,
            onTap: () => _onBottomNavigationTapped(1),
          ),
          _bottomItem(
            icon: Icons.history,
            label: 'Riwayat',
            selected: true,
            onTap: () {},
          ),
          _bottomItem(
            icon: Icons.person_outline,
            label: 'Profil',
            selected: false,
            onTap: () => _onBottomNavigationTapped(3),
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

class HistoryItem {
  final String name;
  final String sku;
  final String quantity;
  final String date;
  final HistoryType type;
  final String status;

  const HistoryItem({
    required this.name,
    required this.sku,
    required this.quantity,
    required this.date,
    required this.type,
    required this.status,
  });
}

enum HistoryType {
  inbound,
  outbound,
}