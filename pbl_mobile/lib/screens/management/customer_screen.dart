import 'package:flutter/material.dart';
import '../../models/user_data.dart';
import '../home/home_screen.dart';

class CustomerScreen extends StatefulWidget {
  final UserData user;

  const CustomerScreen({
    super.key,
    required this.user,
  });

  @override
  State<CustomerScreen> createState() =>
      _CustomerScreenState();
}

class _CustomerScreenState
    extends State<CustomerScreen> {
  final TextEditingController searchController =
      TextEditingController();

  final List<CustomerData> customers = [
    CustomerData(
      name: 'Dewi Lestari',
      phone: '0812-8765-4301',
      address:
          'Jl. Ijen No. 18, Malang',
      lastTransaction:
          '5 Okt 2026',
      transactionCount: 6,
    ),
    CustomerData(
      name: 'Arif Setiawan',
      phone: '0857-9012-6402',
      address:
          'Jl. Soekarno Hatta No. 42, Malang',
      lastTransaction:
          '4 Okt 2026',
      transactionCount: 3,
    ),
    CustomerData(
      name: 'Nadia Kusuma',
      phone: '0821-7654-3203',
      address:
          'Jl. Kawi No. 27, Malang',
      lastTransaction:
          '2 Okt 2026',
      transactionCount: 4,
    ),
    CustomerData(
      name: 'Bagus Wicaksono',
      phone: '0813-6543-2104',
      address:
          'Jl. Veteran No. 9, Malang',
      lastTransaction:
          '1 Okt 2026',
      transactionCount: 1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(
      _searchCustomers,
    );
  }

  @override
  void dispose() {
    searchController.removeListener(
      _searchCustomers,
    );
    searchController.dispose();
    super.dispose();
  }

  void _searchCustomers() {
    setState(() {});
  }

  List<CustomerData>
      get filteredCustomers {
    final query =
        searchController.text
            .trim()
            .toLowerCase();

    if (query.isEmpty) {
      return customers;
    }

    return customers.where((customer) {
      return customer.name
              .toLowerCase()
              .contains(query) ||
          customer.phone.contains(query);
    }).toList();
  }

  // ============================================================
  // KEMBALI KE HOME
  // ============================================================

  void _goHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
            HomeScreen(
          user: widget.user,
        ),
      ),
    );
  }

  // ============================================================
  // TAMBAH PELANGGAN
  // ============================================================

  void _showAddCustomerDialog() {
    final nameController =
        TextEditingController();
    final phoneController =
        TextEditingController();
    final addressController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
          title: const Text(
            'Tambah Pelanggan',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.w700,
              color:
                  Color(0xFF202124),
            ),
          ),
          content:
              SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                _dialogField(
                  controller:
                      nameController,
                  label:
                      'Nama Pelanggan',
                  icon:
                      Icons.person_outline,
                ),
                const SizedBox(
                  height: 12,
                ),
                _dialogField(
                  controller:
                      phoneController,
                  label:
                      'Nomor Telepon',
                  icon:
                      Icons.phone_outlined,
                  keyboardType:
                      TextInputType.phone,
                ),
                const SizedBox(
                  height: 12,
                ),
                _dialogField(
                  controller:
                      addressController,
                  label: 'Alamat',
                  icon:
                      Icons.location_on_outlined,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color:
                      Color(0xFF587B55),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name =
                    nameController.text
                        .trim();
                final phone =
                    phoneController.text
                        .trim();
                final address =
                    addressController.text
                        .trim();

                if (name.isEmpty ||
                    phone.isEmpty ||
                    address.isEmpty) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Lengkapi semua data pelanggan',
                      ),
                    ),
                  );
                  return;
                }

                setState(() {
                  customers.add(
                    CustomerData(
                      name: name,
                      phone: phone,
                      address: address,
                      lastTransaction:
                          '-',
                      transactionCount:
                          0,
                    ),
                  );
                });

                Navigator.pop(
                  dialogContext,
                );

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Pelanggan berhasil ditambahkan',
                    ),
                  ),
                );
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFF587B55,
                ),
                foregroundColor:
                    Colors.white,
              ),
              child:
                  const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // EDIT PELANGGAN
  // ============================================================

  void _showEditCustomerDialog(
    CustomerData customer,
  ) {
    final nameController =
        TextEditingController(
      text: customer.name,
    );
    final phoneController =
        TextEditingController(
      text: customer.phone,
    );
    final addressController =
        TextEditingController(
      text: customer.address,
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
          title: const Text(
            'Edit Pelanggan',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
          content:
              SingleChildScrollView(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              children: [
                _dialogField(
                  controller:
                      nameController,
                  label:
                      'Nama Pelanggan',
                  icon:
                      Icons.person_outline,
                ),
                const SizedBox(
                  height: 12,
                ),
                _dialogField(
                  controller:
                      phoneController,
                  label:
                      'Nomor Telepon',
                  icon:
                      Icons.phone_outlined,
                  keyboardType:
                      TextInputType.phone,
                ),
                const SizedBox(
                  height: 12,
                ),
                _dialogField(
                  controller:
                      addressController,
                  label: 'Alamat',
                  icon:
                      Icons.location_on_outlined,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'Batal',
                style: TextStyle(
                  color:
                      Color(0xFF587B55),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name =
                    nameController.text
                        .trim();
                final phone =
                    phoneController.text
                        .trim();
                final address =
                    addressController.text
                        .trim();

                if (name.isEmpty ||
                    phone.isEmpty ||
                    address.isEmpty) {
                  return;
                }

                setState(() {
                  customer.name = name;
                  customer.phone =
                      phone;
                  customer.address =
                      address;
                });

                Navigator.pop(
                  dialogContext,
                );

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Data pelanggan berhasil diperbarui',
                    ),
                  ),
                );
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFF587B55,
                ),
                foregroundColor:
                    Colors.white,
              ),
              child:
                  const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // HAPUS PELANGGAN
  // ============================================================

  void _deleteCustomer(
    CustomerData customer,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(16),
          ),
          title: const Text(
            'Hapus Pelanggan?',
            style: TextStyle(
              fontSize: 18,
              fontWeight:
                  FontWeight.w700,
            ),
          ),
          content: Text(
            'Apakah kamu yakin ingin menghapus ${customer.name}?',
            style: const TextStyle(
              fontSize: 13,
              color:
                  Color(0xFF6D7480),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  dialogContext,
                );
              },
              child: const Text(
                'Batal',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  customers.remove(
                    customer,
                  );
                });

                Navigator.pop(
                  dialogContext,
                );

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Pelanggan berhasil dihapus',
                    ),
                  ),
                );
              },
              style:
                  ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(
                  0xFFD9534F,
                ),
                foregroundColor:
                    Colors.white,
              ),
              child:
                  const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // DETAIL PELANGGAN
  // ============================================================

  void _showCustomerDetail(
    CustomerData customer,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape:
          const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.fromLTRB(
              20,
              15,
              20,
              24,
            ),
            child: Column(
              mainAxisSize:
                  MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration:
                        BoxDecoration(
                      color:
                          const Color(
                        0xFFD8DDE2,
                      ),
                      borderRadius:
                          BorderRadius
                              .circular(
                        10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration:
                          BoxDecoration(
                        color:
                            const Color(
                          0xFFEAF0E7,
                        ),
                        shape:
                            BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons
                            .person_outline,
                        color:
                            Color(
                          0xFF587B55,
                        ),
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,
                        children: [
                          Text(
                            customer.name,
                            style:
                                const TextStyle(
                              fontSize: 17,
                              fontWeight:
                                  FontWeight
                                      .w700,
                            ),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            customer.phone,
                            style:
                                const TextStyle(
                              fontSize: 11,
                              color:
                                  Color(
                                0xFF7A828D,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                _detailRow(
                  icon:
                      Icons.phone_outlined,
                  title: 'Telepon',
                  value:
                      customer.phone,
                ),
                _detailRow(
                  icon: Icons
                      .location_on_outlined,
                  title: 'Alamat',
                  value:
                      customer.address,
                ),
                _detailRow(
                  icon: Icons
                      .calendar_today_outlined,
                  title:
                      'Transaksi terakhir',
                  value:
                      customer.lastTransaction,
                ),
                _detailRow(
                  icon: Icons
                      .receipt_long_outlined,
                  title:
                      'Jumlah transaksi',
                  value:
                      '${customer.transactionCount} transaksi',
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child:
                          OutlinedButton(
                        onPressed: () {
                          Navigator.pop(
                            sheetContext,
                          );
                          _showEditCustomerDialog(
                            customer,
                          );
                        },
                        style:
                            OutlinedButton.styleFrom(
                          foregroundColor:
                              const Color(
                            0xFF587B55,
                          ),
                          side:
                              const BorderSide(
                            color:
                                Color(
                              0xFF587B55,
                            ),
                          ),
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              10,
                            ),
                          ),
                        ),
                        child:
                            const Text(
                          'Edit',
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child:
                          ElevatedButton(
                        onPressed: () {
                          Navigator.pop(
                            sheetContext,
                          );
                          _deleteCustomer(
                            customer,
                          );
                        },
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(
                            0xFFD9534F,
                          ),
                          foregroundColor:
                              Colors.white,
                          elevation: 0,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              10,
                            ),
                          ),
                        ),
                        child:
                            const Text(
                          'Hapus',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final visibleCustomers =
        filteredCustomers;

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F5F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildSearch(),
            Expanded(
              child:
                  visibleCustomers.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                          padding:
                              const EdgeInsets
                                  .fromLTRB(
                            12,
                            8,
                            12,
                            20,
                          ),
                          itemCount:
                              visibleCustomers
                                  .length,
                          itemBuilder:
                              (context,
                                  index) {
                            return _customerCard(
                              visibleCustomers[
                                  index],
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton.extended(
        onPressed:
            _showAddCustomerDialog,
        backgroundColor:
            const Color(0xFF587B55),
        foregroundColor:
            Colors.white,
        icon: const Icon(
          Icons.add,
          size: 20,
        ),
        label: const Text(
          'Tambah Pelanggan',
          style: TextStyle(
            fontSize: 11,
            fontWeight:
                FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar:
          _buildBottomNavigation(),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF4F5F8),
      padding: const EdgeInsets.fromLTRB(
        12,
        11,
        12,
        8,
      ),
      child: Row(
        children: [
          InkWell(
            onTap: _goHome,
            borderRadius:
                BorderRadius.circular(
              20,
            ),
            child: const Padding(
              padding:
                  EdgeInsets.all(4),
              child: Icon(
                Icons.arrow_back,
                size: 21,
                color:
                    Color(0xFF30343B),
              ),
            ),
          ),
          const SizedBox(
            width: 7,
          ),
          const Text(
            'Data Pelanggan',
            style: TextStyle(
              fontSize: 17,
              fontWeight:
                  FontWeight.w700,
              color:
                  Color(0xFF25282D),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearch() {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(
        12,
        2,
        12,
        5,
      ),
      child: Container(
        height: 40,
        decoration:
            BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(
            10,
          ),
        ),
        child: TextField(
          controller:
              searchController,
          style:
              const TextStyle(
            fontSize: 11,
          ),
          decoration:
              InputDecoration(
            hintText:
                'Cari nama pelanggan atau nomor telepon...',
            hintStyle:
                const TextStyle(
              fontSize: 10,
              color:
                  Color(0xFF9AA1AC),
            ),
            prefixIcon:
                const Icon(
              Icons.search,
              size: 18,
              color:
                  Color(0xFF87909B),
            ),
            border:
                InputBorder.none,
            contentPadding:
                const EdgeInsets
                    .symmetric(
              vertical: 11,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CUSTOMER CARD
  // ============================================================

  Widget _customerCard(
    CustomerData customer,
  ) {
    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 8,
      ),
      padding:
          const EdgeInsets.all(12),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(
          12,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.035),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration:
                    const BoxDecoration(
                  color:
                      Color(0xFFEAF0E7),
                  shape:
                      BoxShape.circle,
                ),
                child: const Icon(
                  Icons
                      .person_outline,
                  color:
                      Color(0xFF587B55),
                  size: 22,
                ),
              ),
              const SizedBox(
                width: 11,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                  children: [
                    Text(
                      customer.name,
                      style:
                          const TextStyle(
                        fontSize: 12,
                        fontWeight:
                            FontWeight.w700,
                        color:
                            Color(
                          0xFF30343B,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      customer.phone,
                      style:
                          const TextStyle(
                        fontSize: 9,
                        color:
                            Color(
                          0xFF7B838E,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets
                        .symmetric(
                  horizontal: 7,
                  vertical: 4,
                ),
                decoration:
                    BoxDecoration(
                  color:
                      const Color(
                    0xFFEAF0E7,
                  ),
                  borderRadius:
                      BorderRadius.circular(
                    6,
                  ),
                ),
                child: Text(
                  '${customer.transactionCount} transaksi',
                  style:
                      const TextStyle(
                    fontSize: 7,
                    color:
                        Color(
                      0xFF587B55,
                    ),
                    fontWeight:
                        FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 9,
          ),
          Container(
            height: 1,
            color:
                const Color(0xFFE9EBEE),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              const Icon(
                Icons
                    .location_on_outlined,
                size: 13,
                color:
                    Color(0xFF74807A),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  customer.address,
                  style:
                      const TextStyle(
                    fontSize: 8,
                    color:
                        Color(
                      0xFF707985,
                    ),
                  ),
                  maxLines: 1,
                  overflow:
                      TextOverflow
                          .ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _showEditCustomerDialog(
                      customer,
                    );
                  },
                  child: const Text(
                    'Edit pelanggan',
                    style:
                        TextStyle(
                      fontSize: 8,
                      color:
                          Color(
                        0xFF587B55,
                      ),
                      fontWeight:
                          FontWeight.w500,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _showCustomerDetail(
                    customer,
                  );
                },
                child: const Row(
                  children: [
                    Text(
                      'Lihat detail',
                      style:
                          TextStyle(
                        fontSize: 8,
                        color:
                            Color(
                          0xFF587B55,
                        ),
                        fontWeight:
                            FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Icon(
                      Icons.chevron_right,
                      size: 14,
                      color:
                          Color(
                        0xFF587B55,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DETAIL ROW
  // ============================================================

  Widget _detailRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 12,
      ),
      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 16,
            color:
                const Color(0xFF587B55),
          ),
          const SizedBox(
            width: 9,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(
                    fontSize: 9,
                    color:
                        Color(
                      0xFF8A929E,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Text(
                  value,
                  style:
                      const TextStyle(
                    fontSize: 11,
                    fontWeight:
                        FontWeight.w600,
                    color:
                        Color(
                      0xFF30343B,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DIALOG FIELD
  // ============================================================

  Widget _dialogField({
    required TextEditingController
        controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType =
        TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: const TextStyle(
        fontSize: 12,
      ),
      decoration:
          InputDecoration(
        labelText: label,
        labelStyle:
            const TextStyle(
          fontSize: 11,
        ),
        prefixIcon: Icon(
          icon,
          size: 17,
        ),
        border:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            10,
          ),
        ),
        focusedBorder:
            OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(
            10,
          ),
          borderSide:
              const BorderSide(
            color:
                Color(0xFF587B55),
          ),
        ),
        contentPadding:
            const EdgeInsets
                .symmetric(
          horizontal: 10,
          vertical: 10,
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY STATE
  // ============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.people_outline,
              size: 48,
              color:
                  Color(0xFF9AA3AE),
            ),
            const SizedBox(
              height: 12,
            ),
            const Text(
              'Pelanggan tidak ditemukan',
              style: TextStyle(
                fontSize: 12,
                fontWeight:
                    FontWeight.w600,
                color:
                    Color(0xFF4A515A),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            const Text(
              'Coba gunakan nama atau nomor telepon lain.',
              textAlign:
                  TextAlign.center,
              style: TextStyle(
                fontSize: 9,
                color:
                    Color(0xFF89919D),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM NAVIGATION
  // ============================================================

  Widget _buildBottomNavigation() {
    return Container(
      height: 65,
      decoration:
          const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color:
                Color(0xFFE9EBEE),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment
                .spaceAround,
        children: [
          _bottomItem(
            icon:
                Icons.home_outlined,
            label: 'Home',
            selected: false,
            onTap: _goHome,
          ),
          _bottomItem(
            icon:
                Icons.people_outline,
            label: 'Pelanggan',
            selected: true,
            onTap: () {},
          ),
          _bottomItem(
            icon:
                Icons.history,
            label: 'Riwayat',
            selected: false,
            onTap: () {},
          ),
          _bottomItem(
            icon:
                Icons.person_outline,
            label: 'Profil',
            selected: false,
            onTap: () {},
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
      behavior:
          HitTestBehavior.opaque,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 19,
              color: selected
                  ? const Color(
                      0xFF587B55,
                    )
                  : const Color(
                      0xFF78828D,
                    ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 8,
                fontWeight: selected
                    ? FontWeight.w600
                    : FontWeight.w400,
                color: selected
                    ? const Color(
                        0xFF587B55,
                      )
                    : const Color(
                        0xFF78828D,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CUSTOMER DATA MODEL
// ============================================================

class CustomerData {
  String name;
  String phone;
  String address;
  String lastTransaction;
  int transactionCount;

  CustomerData({
    required this.name,
    required this.phone,
    required this.address,
    required this.lastTransaction,
    required this.transactionCount,
  });
}