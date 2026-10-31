import 'package:flutter/material.dart';

class AddSkuScreen extends StatefulWidget {
  const AddSkuScreen({super.key});

  @override
  State<AddSkuScreen> createState() => _AddSkuScreenState();
}

class _AddSkuScreenState extends State<AddSkuScreen> {
  final TextEditingController skuController =
      TextEditingController();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController locationController =
      TextEditingController();

  final TextEditingController noteController =
      TextEditingController();

  bool showSkuError = false;
  bool isSaved = false;

  String? selectedCategory;
  String? selectedUnit;

  // =========================================================
  // DATA KATEGORI
  // =========================================================

  final List<String> categories = [
    'Aksesori HP',
    'Kabel & Konektor',
    'Perangkat Jaringan',
    'Audio',
    'Pengisi Daya',
  ];

  // =========================================================
  // DATA SATUAN
  // =========================================================

  final List<String> units = [
    'Pcs',
    'Unit',
    'Box',
    'Pack',
    'Meter',
    'Roll',
  ];

  @override
  void dispose() {
    skuController.dispose();
    nameController.dispose();
    locationController.dispose();
    noteController.dispose();
    super.dispose();
  }

  // =========================================================
  // SIMPAN SKU
  // =========================================================

  void saveSku() {
    final sku = skuController.text.trim();

    if (sku.isEmpty) {
      setState(() {
        showSkuError = true;
        isSaved = false;
      });

      return;
    }

    setState(() {
      showSkuError = false;
      isSaved = true;
    });

    Future.delayed(
      const Duration(milliseconds: 700),
      () {
        if (!mounted) return;

        Navigator.pop(
          context,
          nameController.text.trim().isEmpty
              ? sku
              : nameController.text.trim(),
        );
      },
    );
  }

  // =========================================================
  // PILIH KATEGORI
  // =========================================================

  void showCategoryPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9DDE3),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                const Text(
                  'Pilih Kategori',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202124),
                  ),
                ),
                const SizedBox(height: 12),
                ...categories.map(
                  (category) {
                    final bool selected =
                        selectedCategory == category;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });

                        Navigator.pop(sheetContext);
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          bottom: 7,
                        ),
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFFEAF3E7)
                              : const Color(0xFFF7F8FA),
                          borderRadius:
                              BorderRadius.circular(9),
                          border: Border.all(
                            color: selected
                                ? const Color(0xFF587B55)
                                : const Color(0xFFE5E7EB),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration:
                                  const BoxDecoration(
                                color: Color(0xFFF3ECFF),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.category_outlined,
                                size: 16,
                                color: Color(0xFF8D4DE8),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                category,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight.w600,
                                  color:
                                      Color(0xFF30343B),
                                ),
                              ),
                            ),
                            if (selected)
                              const Icon(
                                Icons.check_circle,
                                size: 18,
                                color:
                                    Color(0xFF587B55),
                              )
                            else
                              const Icon(
                                Icons.chevron_right,
                                size: 17,
                                color:
                                    Color(0xFF9AA3B2),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                  },
                  child: const Text(
                    'Batal',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF718096),
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

  // =========================================================
  // PILIH SATUAN
  // =========================================================

  void showUnitPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(18),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              20,
              18,
              20,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 38,
                    height: 4,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9DDE3),
                      borderRadius:
                          BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 17),
                const Text(
                  'Pilih Satuan',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF202124),
                  ),
                ),
                const SizedBox(height: 12),
                ...units.map(
                  (unit) {
                    final bool selected =
                        selectedUnit == unit;

                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedUnit = unit;
                        });

                        Navigator.pop(sheetContext);
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                          bottom: 7,
                        ),
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 11,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFFEAF3E7)
                              : const Color(0xFFF7F8FA),
                          borderRadius:
                              BorderRadius.circular(9),
                          border: Border.all(
                            color: selected
                                ? const Color(0xFF587B55)
                                : const Color(0xFFE5E7EB),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration:
                                  const BoxDecoration(
                                color: Color(0xFFF1F4FF),
                                shape: BoxShape.circle,
                              ),
                              alignment:
                                  Alignment.center,
                              child: Text(
                                unit.toLowerCase() ==
                                        'meter'
                                    ? 'm'
                                    : unit
                                        .substring(
                                          0,
                                          unit.length > 4
                                              ? 4
                                              : unit.length,
                                        )
                                        .toLowerCase(),
                                style:
                                    const TextStyle(
                                  fontSize: 7,
                                  fontWeight:
                                      FontWeight.w700,
                                  color:
                                      Color(0xFF4169E1),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                unit,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight:
                                      FontWeight.w600,
                                  color:
                                      Color(0xFF30343B),
                                ),
                              ),
                            ),
                            if (selected)
                              const Icon(
                                Icons.check_circle,
                                size: 18,
                                color:
                                    Color(0xFF587B55),
                              )
                            else
                              const Icon(
                                Icons.chevron_right,
                                size: 17,
                                color:
                                    Color(0xFF9AA3B2),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {
                    Navigator.pop(sheetContext);
                  },
                  child: const Text(
                    'Batal',
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFF718096),
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

  // =========================================================
  // BUILD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F8),

      body: SafeArea(
        child: Column(
          children: [
            // =================================================
            // HEADER
            // =================================================

            Container(
              color: Colors.white,
              width: double.infinity,
              height: 51,
              padding:
                  const EdgeInsets.symmetric(
                horizontal: 11,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration:
                          const BoxDecoration(
                        color: Color(0xFFF1F5F9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 12,
                        color: Color(0xFF5D8BE8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Tambah SKU',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF202124),
                    ),
                  ),
                ],
              ),
            ),

            // =================================================
            // FORM
            // =================================================

            Expanded(
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.fromLTRB(
                  11,
                  7,
                  11,
                  20,
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // KODE SKU
                    // =================================================

                    _fieldLabel('Kode SKU'),

                    const SizedBox(height: 5),

                    _textField(
                      controller: skuController,
                      hintText: 'Contoh: ELC-001',
                      hasError: showSkuError,
                      onChanged: (value) {
                        if (value.trim().isNotEmpty) {
                          setState(() {
                            showSkuError = false;
                          });
                        }
                      },
                    ),

                    if (showSkuError)
                      Padding(
                        padding:
                            const EdgeInsets.only(
                          top: 6,
                          left: 3,
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 13,
                              color:
                                  Color(0xFFFF5964),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Kode SKU Wajib diisi',
                              style: TextStyle(
                                fontSize: 9,
                                color:
                                    Color(0xFFFF5964),
                              ),
                            ),
                          ],
                        ),
                      ),

                    const SizedBox(height: 9),

                    // =================================================
                    // NAMA BARANG
                    // =================================================

                    _fieldLabel('Nama Barang'),

                    const SizedBox(height: 5),

                    _textField(
                      controller: nameController,
                      hintText:
                          'Contoh: Laptop Asus',
                    ),

                    const SizedBox(height: 9),

                    // =================================================
                    // KATEGORI
                    // =================================================

                    _fieldLabel('Kategori'),

                    const SizedBox(height: 5),

                    _selectionField(
                      value: selectedCategory,
                      hintText: 'Pilih kategori',
                      icon:
                          Icons.category_outlined,
                      iconColor:
                          const Color(0xFF8D4DE8),
                      onTap: showCategoryPicker,
                    ),

                    const SizedBox(height: 9),

                    // =================================================
                    // SATUAN
                    // =================================================

                    _fieldLabel('Satuan'),

                    const SizedBox(height: 5),

                    _selectionField(
                      value: selectedUnit,
                      hintText: 'Pilih satuan',
                      icon:
                          Icons.straighten_outlined,
                      iconColor:
                          const Color(0xFF4169E1),
                      onTap: showUnitPicker,
                    ),

                    const SizedBox(height: 9),

                    // =================================================
                    // LOKASI
                    // =================================================

                    _fieldLabel(
                      'Lokasi Penyimpanan',
                    ),

                    const SizedBox(height: 5),

                    _textField(
                      controller:
                          locationController,
                      hintText: 'Gedung Utama',
                    ),

                    const SizedBox(height: 9),

                    // =================================================
                    // CATATAN
                    // =================================================

                    _fieldLabel(
                      'Catatan (Opsional)',
                    ),

                    const SizedBox(height: 5),

                    _noteField(),

                    const SizedBox(height: 27),

                    // =================================================
                    // SUCCESS
                    // =================================================

                    if (isSaved)
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(
                          bottom: 9,
                        ),
                        padding:
                            const EdgeInsets
                                .symmetric(
                          horizontal: 10,
                          vertical: 9,
                        ),
                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                            0xFFE7F8EE,
                          ),
                          borderRadius:
                              BorderRadius.circular(
                            6,
                          ),
                          border: Border.all(
                            color:
                                const Color(
                              0xFF38C878,
                            ),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons
                                  .check_circle_outline,
                              size: 16,
                              color:
                                  Color(
                                0xFF20B968,
                              ),
                            ),
                            SizedBox(width: 7),
                            Text(
                              'SKU berhasil disimpan',
                              style: TextStyle(
                                fontSize: 9,
                                color:
                                    Color(
                                  0xFF179957,
                                ),
                                fontWeight:
                                    FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                    // =================================================
                    // SIMPAN
                    // =================================================

                    SizedBox(
                      width: double.infinity,
                      height: 35,
                      child: ElevatedButton(
                        onPressed: saveSku,
                        style:
                            ElevatedButton
                                .styleFrom(
                          backgroundColor:
                              const Color(
                            0xFF587B55,
                          ),
                          foregroundColor:
                              Colors.white,
                          elevation: 0,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                              7,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Simpan SKU',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar:
          _buildBottomNavigation(),
    );
  }

  // =========================================================
  // LABEL
  // =========================================================

  Widget _fieldLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w600,
        color: Color(0xFF30343B),
      ),
    );
  }

  // =========================================================
  // TEXT FIELD
  // =========================================================

  Widget _textField({
    required TextEditingController controller,
    required String hintText,
    bool hasError = false,
    ValueChanged<String>? onChanged,
  }) {
    return SizedBox(
      height: 36,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 9,
          color: Color(0xFF30343B),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 9,
            color: Color(0xFFB4BBC5),
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 8,
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(7),
            borderSide: BorderSide(
              color: hasError
                  ? const Color(0xFFFF5964)
                  : const Color(0xFFE3E7ED),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(7),
            borderSide: BorderSide(
              color: hasError
                  ? const Color(0xFFFF5964)
                  : const Color(0xFFE3E7ED),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(7),
            borderSide: BorderSide(
              color: hasError
                  ? const Color(0xFFFF5964)
                  : const Color(0xFF587B55),
              width: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  // =========================================================
  // SELECTION FIELD
  // =========================================================

  Widget _selectionField({
    required String? value,
    required String hintText,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 36,
        padding:
            const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
              BorderRadius.circular(7),
          border: Border.all(
            color: const Color(0xFFE3E7ED),
          ),
        ),
        child: Row(
          children: [
            if (value != null)
              Icon(
                icon,
                size: 14,
                color: iconColor,
              ),
            if (value != null)
              const SizedBox(width: 7),
            Expanded(
              child: Text(
                value ?? hintText,
                style: TextStyle(
                  fontSize: 9,
                  color: value == null
                      ? const Color(0xFFB4BBC5)
                      : const Color(0xFF30343B),
                  fontWeight: value == null
                      ? FontWeight.w400
                      : FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 17,
              color: Color(0xFF718096),
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // NOTE FIELD
  // =========================================================

  Widget _noteField() {
    return Container(
      height: 91,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(7),
        border: Border.all(
          color: const Color(0xFFE3E7ED),
        ),
      ),
      child: TextField(
        controller: noteController,
        maxLines: 4,
        style: const TextStyle(
          fontSize: 9,
          color: Color(0xFF30343B),
        ),
        decoration:
            const InputDecoration(
          border: InputBorder.none,
          hintText:
              'Tulis catatan di sini...',
          hintStyle: TextStyle(
            fontSize: 9,
            color: Color(0xFFB4BBC5),
          ),
          contentPadding:
              EdgeInsets.all(10),
        ),
      ),
    );
  }

  // =========================================================
  // BOTTOM NAVIGATION
  // =========================================================

  Widget _buildBottomNavigation() {
    return Container(
      height: 68,
      decoration:
          const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
        children: [
          _bottomItem(
            icon: Icons.home_outlined,
            label: 'Home',
          ),
          _bottomItem(
            icon:
                Icons.qr_code_scanner,
            label: 'Scanner',
          ),
          _bottomItem(
            icon:
                Icons.receipt_long_outlined,
            label: 'Riwayat',
          ),
          _bottomItem(
            icon: Icons.person_outline,
            label: 'Profil',
          ),
        ],
      ),
    );
  }

  Widget _bottomItem({
    required IconData icon,
    required String label,
  }) {
    return SizedBox(
      width: 60,
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 19,
            color:
                const Color(0xFF718096),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              fontSize: 8,
              color:
                  Color(0xFF718096),
            ),
          ),
        ],
      ),
    );
  }
}