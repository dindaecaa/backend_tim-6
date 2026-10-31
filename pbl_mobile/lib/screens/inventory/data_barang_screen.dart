import 'package:flutter/material.dart';

import 'add_sku_screen.dart';

class DataBarangScreen extends StatefulWidget {
  const DataBarangScreen({super.key});

  @override
  State<DataBarangScreen> createState() => _DataBarangScreenState();
}

class _DataBarangScreenState extends State<DataBarangScreen> {
  final TextEditingController searchController =
      TextEditingController();

  String selectedCategory = 'Semua kategori';
  String selectedStatus = 'Semua status stok';

  final List<ProductData> products = [
    ProductData(
      name: 'Kabel UTP Cat 6',
      sku: 'SKU-1042',
      category: 'Kabel',
      unit: 'unit',
      quantity: 12,
      minimumStock: 5,
      rack: 'Rak A-12',
      status: 'Normal',
    ),
    ProductData(
      name: 'Switch 8 Port',
      sku: 'SKU-2198',
      category: 'Jaringan',
      unit: 'unit',
      quantity: 3,
      minimumStock: 5,
      rack: 'Rak B-05',
      status: 'Menipis',
    ),
    ProductData(
      name: 'Charger USB-C 20W',
      sku: 'SKU-3021',
      category: 'Aksesori HP',
      unit: 'unit',
      quantity: 24,
      minimumStock: 10,
      rack: 'Rak C-02',
      status: 'Normal',
    ),
    ProductData(
      name: 'Konektor RJ45 Cat 6',
      sku: 'SKU-1058',
      category: 'Konektor',
      unit: 'unit',
      quantity: 4,
      minimumStock: 8,
      rack: 'Rak A-14',
      status: 'Menipis',
    ),
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<ProductData> get filteredProducts {
    final query =
        searchController.text.trim().toLowerCase();

    return products.where((product) {
      final matchesSearch =
          query.isEmpty ||
          product.name.toLowerCase().contains(query) ||
          product.sku.toLowerCase().contains(query);

      final matchesCategory =
          selectedCategory == 'Semua kategori' ||
          product.category == selectedCategory;

      final matchesStatus =
          selectedStatus == 'Semua status stok' ||
          product.status == selectedStatus;

      return matchesSearch &&
          matchesCategory &&
          matchesStatus;
    }).toList();
  }

  Future<void> _addProduct() async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddSkuScreen(),
      ),
    );

    if (!mounted) {
      return;
    }

    if (result != null && result.trim().isNotEmpty) {
      setState(() {
        products.add(
          ProductData(
            name: result.trim(),
            sku: 'SKU-${1000 + products.length + 1}',
            category: 'Lainnya',
            unit: 'unit',
            quantity: 0,
            minimumStock: 5,
            rack: 'Belum ditentukan',
            status: 'Menipis',
          ),
        );
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Barang berhasil ditambahkan',
          ),
        ),
      );
    }
  }

  void _editProduct(ProductData product) {
    final nameController =
        TextEditingController(text: product.name);

    final quantityController =
        TextEditingController(
      text: product.quantity.toString(),
    );

    final minimumController =
        TextEditingController(
      text: product.minimumStock.toString(),
    );

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          title: const Text(
            'Edit Barang',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _dialogField(
                  controller: nameController,
                  label: 'Nama Barang',
                ),
                const SizedBox(height: 12),
                _dialogField(
                  controller: quantityController,
                  label: 'Jumlah Stok',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                _dialogField(
                  controller: minimumController,
                  label: 'Minimum Stok',
                  keyboardType: TextInputType.number,
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
                  color: Color(0xFF607D5C),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final quantity =
                    int.tryParse(
                          quantityController.text,
                        ) ??
                        product.quantity;

                final minimum =
                    int.tryParse(
                          minimumController.text,
                        ) ??
                        product.minimumStock;

                setState(() {
                  product.name =
                      nameController.text.trim().isEmpty
                          ? product.name
                          : nameController.text.trim();

                  product.quantity = quantity;
                  product.minimumStock = minimum;

                  product.status =
                      quantity < minimum
                          ? 'Menipis'
                          : 'Normal';
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Data barang berhasil diperbarui',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFF5E7C5B),
                foregroundColor: Colors.white,
              ),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _showDetail(ProductData product) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD8DDE2),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Container(
                      width: 46,
                      height: 46,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF0E7),
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.inventory_2_outlined,
                        color: Color(0xFF5E7C5B),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            product.sku,
                            style: const TextStyle(
                              fontSize: 10,
                              color:
                                  Color(0xFF7A828D),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _statusBadge(product.status),
                  ],
                ),
                const SizedBox(height: 20),
                _detailRow(
                  'Kategori',
                  product.category,
                ),
                _detailRow(
                  'Jumlah stok',
                  '${product.quantity} ${product.unit}',
                ),
                _detailRow(
                  'Minimum stok',
                  '${product.minimumStock} ${product.unit}',
                ),
                _detailRow(
                  'Lokasi',
                  product.rack,
                ),
                const SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  height: 43,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _editProduct(product);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFF5E7C5B),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(11),
                      ),
                    ),
                    child: const Text(
                      'Edit Barang',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF737B87),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF30343B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dialogField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType =
        TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding:
            const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 11,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleProducts = filteredProducts;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F8),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  10,
                  8,
                  10,
                  20,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    _buildWarehouseSummary(),

                    const SizedBox(height: 9),

                    _buildFilters(),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daftar barang',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight:
                                FontWeight.w700,
                            color:
                                Color(0xFF30343B),
                          ),
                        ),
                        Text(
                          '${visibleProducts.length} dari ${products.length} barang',
                          style: const TextStyle(
                            fontSize: 8,
                            color:
                                Color(0xFF7D8590),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    if (visibleProducts.isEmpty)
                      _buildEmptyState()
                    else
                      ...visibleProducts.map(
                        _buildProductCard,
                      ),

                    const SizedBox(height: 5),

                    const Text(
                      'Stok menipis: jumlah unit di bawah batas minimum.',
                      style: TextStyle(
                        fontSize: 7,
                        color: Color(0xFF89919D),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            _buildAddButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF4F5F8),
      padding: const EdgeInsets.fromLTRB(
        14,
        12,
        14,
        7,
      ),
      child: Row(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.pop(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(3),
              child: Icon(
                Icons.arrow_back,
                size: 21,
                color: Color(0xFF30343B),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Data Barang',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Color(0xFF25282D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarehouseSummary() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        10,
        10,
        10,
        11,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.03,
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
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'WH-01 • Malang Jatim',
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF59636E),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F2E4),
                  borderRadius:
                      BorderRadius.circular(7),
                ),
                child: const Text(
                  'Data contoh',
                  style: TextStyle(
                    fontSize: 7,
                    color: Color(0xFF557252),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Expanded(
                child: _summaryItem(
                  value: '${products.length}',
                  label: 'Jenis barang',
                ),
              ),
              Container(
                width: 1,
                height: 31,
                color: const Color(0xFFE7E9EC),
              ),
              Expanded(
                child: _summaryItem(
                  value: _totalUnits.toString(),
                  label: 'Total unit',
                ),
              ),
              Container(
                width: 1,
                height: 31,
                color: const Color(0xFFE7E9EC),
              ),
              Expanded(
                child: _summaryItem(
                  value: _lowStockCount.toString(),
                  label: 'Stok menipis',
                  valueColor:
                      const Color(0xFFC84B18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  int get _totalUnits {
    return products.fold(
      0,
      (total, product) =>
          total + product.quantity,
    );
  }

  int get _lowStockCount {
    return products.where(
      (product) =>
          product.quantity <
          product.minimumStock,
    ).length;
  }

  Widget _summaryItem({
    required String value,
    required String label,
    Color valueColor =
        const Color(0xFF5E7C5B),
  }) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 10),
          child: Text(
            value,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ),
        const SizedBox(height: 1),
        Padding(
          padding:
              const EdgeInsets.only(left: 10),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 7,
              color: Color(0xFF7B838D),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Row(
      children: [
        Expanded(
          child: _dropdownFilter(
            value: selectedCategory,
            items: const [
              'Semua kategori',
              'Kabel',
              'Jaringan',
              'Aksesori HP',
              'Konektor',
              'Lainnya',
            ],
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
          ),
        ),
        const SizedBox(width: 7),
        Expanded(
          child: _dropdownFilter(
            value: selectedStatus,
            items: const [
              'Semua status stok',
              'Normal',
              'Menipis',
            ],
            onChanged: (value) {
              setState(() {
                selectedStatus = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _dropdownFilter({
    required String value,
    required List<String> items,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      height: 34,
      padding:
          const EdgeInsets.symmetric(horizontal: 9),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(7),
        border: Border.all(
          color: const Color(0xFFE5E8EC),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 14,
            color: Color(0xFF59636E),
          ),
          style: const TextStyle(
            fontSize: 8,
            color: Color(0xFF59636E),
          ),
          items: items.map(
            (item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ).toList(),
          onChanged: (newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
        ),
      ),
    );
  }

  Widget _buildProductCard(
    ProductData product,
  ) {
    final isLow =
        product.quantity <
        product.minimumStock;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: 7,
      ),
      padding: const EdgeInsets.fromLTRB(
        9,
        9,
        9,
        7,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(
              alpha: 0.025,
            ),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color:
                            Color(0xFF30343B),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${product.sku} · ${product.category} · Satuan: ${product.unit}',
                      style: const TextStyle(
                        fontSize: 7.5,
                        color:
                            Color(0xFF75808C),
                      ),
                    ),
                  ],
                ),
              ),
              _statusBadge(product.status),
            ],
          ),
          const SizedBox(height: 7),
          Row(
            children: [
              Text(
                '${product.quantity} ${product.unit}',
                style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: isLow
                      ? const Color(0xFFC84B18)
                      : const Color(0xFF30343B),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '· Min. ${product.minimumStock} ${product.unit}',
                style: const TextStyle(
                  fontSize: 7,
                  color: Color(0xFF818994),
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.location_on_outlined,
                size: 11,
                color: Color(0xFF5E7C5B),
              ),
              const SizedBox(width: 2),
              Text(
                product.rack,
                style: const TextStyle(
                  fontSize: 7,
                  color: Color(0xFF59636E),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Container(
            height: 1,
            color: const Color(0xFFE8EAED),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _editProduct(product);
                  },
                  child: const Text(
                    'Edit barang',
                    style: TextStyle(
                      fontSize: 7.5,
                      color: Color(0xFF587354),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _showDetail(product);
                },
                child: const Row(
                  children: [
                    Text(
                      'Lihat detail',
                      style: TextStyle(
                        fontSize: 7.5,
                        color: Color(0xFF587354),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(
                      Icons.chevron_right,
                      size: 13,
                      color: Color(0xFF587354),
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

  Widget _statusBadge(String status) {
    final isLow = status == 'Menipis';

    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: isLow
            ? const Color(0xFFFFEFE7)
            : const Color(0xFFE8F2E4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 7,
          fontWeight: FontWeight.w500,
          color: isLow
              ? const Color(0xFFC84B18)
              : const Color(0xFF557252),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 35,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 38,
            color: Color(0xFF9AA3AE),
          ),
          SizedBox(height: 10),
          Text(
            'Barang tidak ditemukan',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF4A515A),
            ),
          ),
          SizedBox(height: 3),
          Text(
            'Coba ubah kata pencarian atau filter.',
            style: TextStyle(
              fontSize: 8,
              color: Color(0xFF89919D),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return Container(
      color: const Color(0xFFF4F5F8),
      padding: const EdgeInsets.fromLTRB(
        10,
        6,
        10,
        18,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 36,
        child: ElevatedButton.icon(
          onPressed: _addProduct,
          icon: const Icon(
            Icons.add,
            size: 17,
          ),
          label: const Text(
            'Tambah Barang',
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor:
                const Color(0xFF5E7C5B),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(9),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductData {
  String name;
  String sku;
  String category;
  String unit;
  int quantity;
  int minimumStock;
  String rack;
  String status;

  ProductData({
    required this.name,
    required this.sku,
    required this.category,
    required this.unit,
    required this.quantity,
    required this.minimumStock,
    required this.rack,
    required this.status,
  });
}