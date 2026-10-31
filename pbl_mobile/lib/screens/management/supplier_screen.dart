import 'package:flutter/material.dart';

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({super.key});

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<ResellerData> resellers = [
    ResellerData(
      name: 'Sinar Jaya Cell',
      sales: 'Andi Pratama',
      phone: '0812-3456-7801',
      pickupDate: '4 Okt 2026',
      itemCount: '48 aksesori HP',
    ),
    ResellerData(
      name: 'Berkah Aksesoris',
      sales: 'Rina Wulandari',
      phone: '0857-2345-8902',
      pickupDate: '3 Okt 2026',
      itemCount: '36 aksesori HP',
    ),
  ];

  final List<SalesLocation> salesLocations = [
    SalesLocation(
      name: 'Counter HP 1',
      address: 'Jl. Merdeka No. 12, Bandung',
      sales: 'Dimas Saputra',
      status: 'Sales aktif',
    ),
    SalesLocation(
      name: 'Counter HP 2',
      address: 'Jl. Sago No. 45, Bandung',
      sales: 'Siti Rahma',
      status: 'Sales aktif',
    ),
    SalesLocation(
      name: 'Counter HP 3',
      address: 'Jl. Buah Batu No. 88, Bandung',
      sales: 'Rizky Maulana',
      status: 'Sales aktif',
    ),
    SalesLocation(
      name: 'Counter HP 4',
      address: 'Jl. Cihampelas No. 21, Bandung',
      sales: 'Nadia Putri',
      status: 'Sales aktif',
    ),
    SalesLocation(
      name: 'Counter HP 5',
      address: 'Jl. Kopo No. 67, Bandung',
      sales: 'Hajar Hidayat',
      status: 'Sales cuti',
    ),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<ResellerData> get filteredResellers {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return resellers;
    }

    return resellers.where((item) {
      return item.name.toLowerCase().contains(query) ||
          item.sales.toLowerCase().contains(query) ||
          item.phone.toLowerCase().contains(query);
    }).toList();
  }

  List<SalesLocation> get filteredLocations {
    final query = searchController.text.trim().toLowerCase();

    if (query.isEmpty) {
      return salesLocations;
    }

    return salesLocations.where((item) {
      return item.name.toLowerCase().contains(query) ||
          item.address.toLowerCase().contains(query) ||
          item.sales.toLowerCase().contains(query);
    }).toList();
  }

  // =========================================================
  // TAMBAH PEMASOK
  // =========================================================

  void showAddSupplierDialog() {
    final nameController = TextEditingController();
    final salesController = TextEditingController();
    final phoneController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Tambah Pemasok',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF202124),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dialogField(
                  controller: nameController,
                  label: 'Nama Reseller',
                  hint: 'Contoh: Sinar Jaya Cell',
                ),
                const SizedBox(height: 12),
                _dialogField(
                  controller: salesController,
                  label: 'Nama Sales',
                  hint: 'Contoh: Andi Pratama',
                ),
                const SizedBox(height: 12),
                _dialogField(
                  controller: phoneController,
                  label: 'Nomor Telepon',
                  hint: 'Contoh: 081234567890',
                  keyboardType: TextInputType.phone,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color: Color(0xFF718096),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final sales = salesController.text.trim();
                final phone = phoneController.text.trim();

                if (name.isEmpty || sales.isEmpty || phone.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Lengkapi data pemasok terlebih dahulu.',
                      ),
                    ),
                  );
                  return;
                }

                setState(() {
                  resellers.add(
                    ResellerData(
                      name: name,
                      sales: sales,
                      phone: phone,
                      pickupDate: 'Hari ini',
                      itemCount: '0 aksesori HP',
                    ),
                  );
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Pemasok berhasil ditambahkan.',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF587B55),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Widget _dialogField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF30343B),
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              fontSize: 11,
              color: Color(0xFFB4BBC5),
            ),
            filled: true,
            fillColor: const Color(0xFFF7F8FA),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 11,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================
  // DETAIL RESELLER
  // =========================================================

  void showResellerDetail(ResellerData item) {
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
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              16,
              20,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9DDE3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Detail Reseller',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202124),
                  ),
                ),
                const SizedBox(height: 18),
                _detailRow('Nama Reseller', item.name),
                _detailRow('Sales', item.sales),
                _detailRow('Nomor Telepon', item.phone),
                _detailRow('Pengambilan Terakhir', item.pickupDate),
                _detailRow('Jumlah Barang', item.itemCount),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // =========================================================
  // DETAIL COUNTER
  // =========================================================

  void showLocationDetail(SalesLocation item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              16,
              20,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9DDE3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                const Text(
                  'Detail Lokasi Sales',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202124),
                  ),
                ),
                const SizedBox(height: 18),
                _detailRow('Nama Counter', item.name),
                _detailRow('Alamat', item.address),
                _detailRow('Sales', item.sales),
                _detailRow('Status', item.status),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 135,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF718096),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF30343B),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    final resellerItems = filteredResellers;
    final locationItems = filteredLocations;

    final bool hasData =
        resellerItems.isNotEmpty || locationItems.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F8),

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // HEADER
            // =================================================

            Container(
              width: double.infinity,
              height: 52,
              color: const Color(0xFFF4F5F8),
              padding: const EdgeInsets.symmetric(
                horizontal: 17,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 21,
                      color: Color(0xFF202124),
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    'Data Pemasok',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202124),
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // CONTENT
            // =================================================

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  17,
                  6,
                  17,
                  90,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // SEARCH
                    // =================================================

                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9E9EF),
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: TextField(
                        controller: searchController,
                        onChanged: (_) {
                          setState(() {});
                        },
                        style: const TextStyle(
                          fontSize: 10,
                          color: Color(0xFF30343B),
                        ),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 16,
                            color: Color(0xFF9AA3B2),
                          ),
                          hintText:
                              'Cari reseller, counter, atau sales...',
                          hintStyle: TextStyle(
                            fontSize: 10,
                            color: Color(0xFF9AA3B2),
                          ),
                          contentPadding: EdgeInsets.only(
                            right: 10,
                            bottom: 7,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 13),

                    if (!hasData)
                      _buildEmptyState()
                    else ...[
                      // =================================================
                      // RESELLER
                      // =================================================

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Reseller',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF30343B),
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Mitra yang mengambil barang dari kita',
                                style: TextStyle(
                                  fontSize: 8.5,
                                  color: Color(0xFF718096),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${resellerItems.length} reseller',
                            style: const TextStyle(
                              fontSize: 8.5,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 7),

                      ...resellerItems.map(
                        (item) => _buildResellerCard(item),
                      ),

                      const SizedBox(height: 14),

                      // =================================================
                      // LOKASI SALES
                      // =================================================

                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Lokasi Sales',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF30343B),
                                ),
                              ),
                              const SizedBox(height: 2),
                              const Text(
                                'Counter tempat penempatan sales kita',
                                style: TextStyle(
                                  fontSize: 8.5,
                                  color: Color(0xFF718096),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${locationItems.length} counter',
                            style: const TextStyle(
                              fontSize: 8.5,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 7),

                      _buildLocationCard(locationItems),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // =================================================
      // FLOATING BUTTON
      // =================================================

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 2,
          bottom: 3,
        ),
        child: SizedBox(
          width: 42,
          height: 42,
          child: FloatingActionButton(
            onPressed: showAddSupplierDialog,
            backgroundColor: const Color(0xFF587B55),
            foregroundColor: Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.add,
              size: 25,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // RESELLER CARD
  // =========================================================

  Widget _buildResellerCard(ResellerData item) {
    return GestureDetector(
      onTap: () {
        showResellerDetail(item);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 6),
        padding: const EdgeInsets.fromLTRB(
          10,
          8,
          9,
          8,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.025),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 10.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF30343B),
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  size: 17,
                  color: Color(0xFF718096),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              '${item.sales} · ${item.phone}',
              style: const TextStyle(
                fontSize: 8.5,
                color: Color(0xFF718096),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(
                  Icons.inventory_2_outlined,
                  size: 11,
                  color: Color(0xFF587B55),
                ),
                const SizedBox(width: 5),
                Text(
                  'Ambil ${item.pickupDate} · ${item.itemCount}',
                  style: const TextStyle(
                    fontSize: 8,
                    color: Color(0xFF587B55),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // LOCATION CARD
  // =========================================================

  Widget _buildLocationCard(List<SalesLocation> items) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.025),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(
          items.length,
          (index) {
            final item = items[index];

            return GestureDetector(
              onTap: () {
                showLocationDetail(item);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(
                  9,
                  7,
                  9,
                  7,
                ),
                decoration: BoxDecoration(
                  border: index == items.length - 1
                      ? null
                      : const Border(
                          bottom: BorderSide(
                            color: Color(0xFFE5E7EB),
                            width: 0.8,
                          ),
                        ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF30343B),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.address,
                            style: const TextStyle(
                              fontSize: 8,
                              color: Color(0xFF718096),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Sales: ${item.sales}',
                            style: const TextStyle(
                              fontSize: 8,
                              color: Color(0xFF718096),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 7),
                    _statusBadge(item.status),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // =========================================================
  // STATUS BADGE
  // =========================================================

  Widget _statusBadge(String status) {
    final bool active = status == 'Sales aktif';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFFEAF3E7)
            : const Color(0xFFF1F3F6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 7,
          color: active
              ? const Color(0xFF587B55)
              : const Color(0xFF718096),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // =========================================================
  // EMPTY STATE
  // =========================================================

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 35),
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              color: Color(0xFFEAF3E7),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.local_shipping_outlined,
              size: 27,
              color: Color(0xFF587B55),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Tidak ditemukan Data Pemasok',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Color(0xFF30343B),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Data pemasok yang kamu tambahkan akan muncul di sini.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              color: Color(0xFF718096),
            ),
          ),
          const SizedBox(height: 17),
          ElevatedButton(
            onPressed: showAddSupplierDialog,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF587B55),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            child: const Text(
              '+ Tambah Pemasok',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =========================================================
// MODEL RESELLER
// =========================================================

class ResellerData {
  final String name;
  final String sales;
  final String phone;
  final String pickupDate;
  final String itemCount;

  ResellerData({
    required this.name,
    required this.sales,
    required this.phone,
    required this.pickupDate,
    required this.itemCount,
  });
}

// =========================================================
// MODEL LOKASI SALES
// =========================================================

class SalesLocation {
  final String name;
  final String address;
  final String sales;
  final String status;

  SalesLocation({
    required this.name,
    required this.address,
    required this.sales,
    required this.status,
  });
}