import 'package:flutter/material.dart';

import '../../models/user_data.dart';

import '../home/home_screen.dart';

import '../scanner/scanner_screen.dart';

import '../history/history_screen.dart';

import '../profile/profile_screen.dart';

import 'add_sku_screen.dart';



class StockInScreen extends StatefulWidget {
  final UserData user;

  StockInScreen({
    super.key,
    UserData? user,
  }) : user = user ??
            UserData(
              name: 'Zefanya',
              email: '',
            );



  @override

  State<StockInScreen> createState() =>

      _StockInScreenState();

}



class _StockInScreenState

    extends State<StockInScreen> {

  String? selectedProduct;

  String? selectedSupplier;



  DateTime selectedDate =

      DateTime.now();



  final TextEditingController

      noteController =

      TextEditingController();



  bool showError = false;

  bool isSaved = false;



  final List<String> products = [

    'Kabel UTP Cat 6',

    'Switch 8 Port',

    'Router WiFi AC1200',

    'Konektor RJ45',

    'Patch Panel 24P',

  ];



  final List<String> suppliers = [

    'PT Sumber Teknologi',

    'CV Digital Nusantara',

    'PT Jaringan Indonesia',

    'UD Maju Bersama',

  ];



  @override

  void dispose() {

    noteController.dispose();

    super.dispose();

  }



  // =================================================

  // TAMBAH SKU

  // =================================================



  Future<void> addNewSku() async {

    final result =

        await Navigator.push<String>(

      context,

      MaterialPageRoute(

        builder: (context) =>

            const AddSkuScreen(),

      ),

    );



    if (result != null &&

        result.trim().isNotEmpty) {

      setState(() {

        selectedProduct = result;

        showError = false;

        isSaved = false;

      });

    }

  }



  // =================================================

  // SIMPAN STOK MASUK

  // =================================================



  void saveStockIn() {

    if (selectedProduct == null) {

      setState(() {

        showError = true;

        isSaved = false;

      });



      return;

    }



    setState(() {

      showError = false;

      isSaved = true;

    });



    ScaffoldMessenger.of(context)

        .showSnackBar(

      const SnackBar(

        content: Text(

          'Stok masuk berhasil disimpan',

        ),

        backgroundColor:

            Color(0xFF20C769),

      ),

    );

  }



  // =================================================

  // PILIH BARANG

  // =================================================



  void showProductPicker() {

    showModalBottomSheet(

      context: context,

      backgroundColor: Colors.white,

      shape:

          const RoundedRectangleBorder(

        borderRadius:

            BorderRadius.vertical(

          top: Radius.circular(18),

        ),

      ),

      builder: (context) {

        return SafeArea(

          child: Padding(

            padding:

                const EdgeInsets.fromLTRB(

              20,

              18,

              20,

              20,

            ),

            child: Column(

              mainAxisSize:

                  MainAxisSize.min,

              crossAxisAlignment:

                  CrossAxisAlignment.start,

              children: [

                const Text(

                  'Pilih Barang',

                  style: TextStyle(

                    fontSize: 18,

                    fontWeight:

                        FontWeight.w700,

                  ),

                ),



                const SizedBox(

                  height: 12,

                ),



                ...products.map(

                  (product) {

                    return ListTile(

                      contentPadding:

                          EdgeInsets.zero,

                      leading:

                          Container(

                        width: 38,

                        height: 38,

                        decoration:

                            BoxDecoration(

                          color:

                              const Color(

                            0xFFEAF0E7,

                          ),

                          borderRadius:

                              BorderRadius

                                  .circular(

                            9,

                          ),

                        ),

                        child:

                            const Icon(

                          Icons

                              .inventory_2_outlined,

                          size: 19,

                          color:

                              Color(

                            0xFF587B55,

                          ),

                        ),

                      ),

                      title: Text(

                        product,

                        style:

                            const TextStyle(

                          fontSize: 13,

                          fontWeight:

                              FontWeight

                                  .w500,

                        ),

                      ),

                      trailing:

                          selectedProduct ==

                                  product

                              ? const Icon(

                                  Icons

                                      .check_circle,

                                  color:

                                      Color(

                                    0xFF587B55,

                                  ),

                                )

                              : const Icon(

                                  Icons

                                      .chevron_right,

                                  size: 18,

                                ),

                      onTap: () {

                        setState(() {

                          selectedProduct =

                              product;

                          showError = false;

                          isSaved = false;

                        });



                        Navigator.pop(

                          context,

                        );

                      },

                    );

                  },

                ),

              ],

            ),

          ),

        );

      },

    );

  }



  // =================================================

  // PILIH PEMASOK

  // =================================================



  void showSupplierPicker() {

    showModalBottomSheet(

      context: context,

      backgroundColor: Colors.white,

      shape:

          const RoundedRectangleBorder(

        borderRadius:

            BorderRadius.vertical(

          top: Radius.circular(18),

        ),

      ),

      builder: (context) {

        return SafeArea(

          child: Padding(

            padding:

                const EdgeInsets.fromLTRB(

              20,

              18,

              20,

              20,

            ),

            child: Column(

              mainAxisSize:

                  MainAxisSize.min,

              crossAxisAlignment:

                  CrossAxisAlignment.start,

              children: [

                const Text(

                  'Pilih Pemasok',

                  style: TextStyle(

                    fontSize: 18,

                    fontWeight:

                        FontWeight.w700,

                  ),

                ),



                const SizedBox(

                  height: 12,

                ),



                ...suppliers.map(

                  (supplier) {

                    return ListTile(

                      contentPadding:

                          EdgeInsets.zero,

                      leading:

                          Container(

                        width: 38,

                        height: 38,

                        decoration:

                            BoxDecoration(

                          color:

                              const Color(

                            0xFFEAF0E7,

                          ),

                          borderRadius:

                              BorderRadius

                                  .circular(

                            9,

                          ),

                        ),

                        child:

                            const Icon(

                          Icons

                              .business_outlined,

                          size: 19,

                          color:

                              Color(

                            0xFF587B55,

                          ),

                        ),

                      ),

                      title: Text(

                        supplier,

                        style:

                            const TextStyle(

                          fontSize: 13,

                        ),

                      ),

                      trailing:

                          selectedSupplier ==

                                  supplier

                              ? const Icon(

                                  Icons

                                      .check_circle,

                                  color:

                                      Color(

                                    0xFF587B55,

                                  ),

                                )

                              : const Icon(

                                  Icons

                                      .chevron_right,

                                  size: 18,

                                ),

                      onTap: () {

                        setState(() {

                          selectedSupplier =

                              supplier;

                        });



                        Navigator.pop(

                          context,

                        );

                      },

                    );

                  },

                ),

              ],

            ),

          ),

        );

      },

    );

  }



  // =================================================

  // TANGGAL

  // =================================================



  Future<void> selectDate() async {

    final DateTime? picked =

        await showDatePicker(

      context: context,

      initialDate: selectedDate,

      firstDate:

          DateTime(2020),

      lastDate:

          DateTime(2100),

    );



    if (picked != null) {

      setState(() {

        selectedDate = picked;

        isSaved = false;

      });

    }

  }



  String formatDate(

    DateTime date,

  ) {

    const months = [

      'Januari',

      'Februari',

      'Maret',

      'April',

      'Mei',

      'Juni',

      'Juli',

      'Agustus',

      'September',

      'Oktober',

      'November',

      'Desember',

    ];



    final hour =

        TimeOfDay.now()

            .hour

            .toString()

            .padLeft(

              2,

              '0',

            );



    final minute =

        TimeOfDay.now()

            .minute

            .toString()

            .padLeft(

              2,

              '0',

            );



    return '${date.day} '

        '${months[date.month - 1]} '

        '${date.year} '

        '$hour:$minute';

  }



  // =================================================

  // BOTTOM NAVIGATION

  // =================================================



  void navigateBottom(

    int index,

  ) {

    if (index == 0) {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) =>

              HomeScreen(),

        ),

      );

    }



    if (index == 1) {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) =>

              const ScannerScreen(),

        ),

      );

    }



    if (index == 2) {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) =>

              const HistoryScreen(),

        ),

      );

    }



    if (index == 3) {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) =>

              ProfileScreen(),

        ),

      );

    }

  }



  @override

  Widget build(

    BuildContext context,

  ) {

    return Scaffold(

      backgroundColor:

          const Color(0xFFF4F5F8),



      body: SafeArea(

        child: Column(

          children: [

            // =========================================

            // HEADER

            // =========================================



            Container(

              height: 52,

              color: Colors.white,

              padding:

                  const EdgeInsets

                      .symmetric(

                horizontal: 12,

              ),

              child: Row(

                children: [

                  IconButton(

                    onPressed: () {

                      Navigator.pop(

                        context,

                      );

                    },

                    padding:

                        EdgeInsets.zero,

                    constraints:

                        const BoxConstraints(

                      minWidth: 34,

                      minHeight: 34,

                    ),

                    icon:

                        const Icon(

                      Icons.arrow_back,

                      size: 20,

                      color:

                          Color(0xFF2F3742),

                    ),

                  ),



                  const SizedBox(

                    width: 2,

                  ),



                  const Text(

                    'Stok Masuk',

                    style:

                        TextStyle(

                      fontSize: 14,

                      fontWeight:

                          FontWeight.w700,

                      color:

                          Color(0xFF202124),

                    ),

                  ),

                ],

              ),

            ),



            // =========================================

            // CONTENT

            // =========================================



            Expanded(

              child:

                  SingleChildScrollView(

                padding:

                    const EdgeInsets

                        .fromLTRB(

                  7,

                  10,

                  7,

                  20,

                ),

                child: _buildForm(),

              ),

            ),

          ],

        ),

      ),



      bottomNavigationBar:

          _buildBottomNavigation(),

    );

  }



  // =================================================

  // FORM

  // =================================================



  Widget _buildForm() {

    return Container(

      width: double.infinity,

      padding:

          const EdgeInsets

              .fromLTRB(

        7,

        9,

        7,

        11,

      ),

      decoration:

          BoxDecoration(

        color: Colors.white,

        borderRadius:

            BorderRadius.circular(

          5,

        ),

      ),

      child: Column(

        children: [

          // =========================================

          // BARANG

          // =========================================



          Container(

            decoration:

                BoxDecoration(

              color: showError

                  ? const Color(

                      0xFFFFEEEE,

                    )

                  : Colors.white,

              border:

                  Border.all(

                color: showError

                    ? const Color(

                        0xFFFF5B62,

                      )

                    : const Color(

                        0xFFE7E9ED,

                      ),

              ),

              borderRadius:

                  BorderRadius.circular(

                6,

              ),

            ),

            child:

                Column(

              children: [

                SizedBox(

                  height: 37,

                  child:

                      Padding(

                    padding:

                        const EdgeInsets

                            .symmetric(

                      horizontal: 8,

                    ),

                    child:

                        Row(

                      children: [

                        const Icon(

                          Icons

                              .inventory_2_outlined,

                          size: 14,

                          color:

                              Color(

                            0xFF59677A,

                          ),

                        ),



                        const SizedBox(

                          width: 6,

                        ),



                        const Text(

                          'Barang',

                          style:

                              TextStyle(

                            fontSize: 10,

                            fontWeight:

                                FontWeight

                                    .w600,

                            color:

                                Color(

                              0xFF30343B,

                            ),

                          ),

                        ),



                        const Spacer(),



                        SizedBox(

                          height: 24,

                          child:

                              ElevatedButton

                                  .icon(

                            onPressed:

                                addNewSku,

                            icon:

                                const Icon(

                              Icons.add,

                              size: 11,

                            ),

                            label:

                                const Text(

                              'Tambah',

                              style:

                                  TextStyle(

                                fontSize: 8,

                              ),

                            ),

                            style:

                                ElevatedButton

                                    .styleFrom(

                              backgroundColor:

                                  const Color(

                                0xFF587B55,

                              ),

                              foregroundColor:

                                  Colors.white,

                              elevation:

                                  0,

                              padding:

                                  const EdgeInsets

                                      .symmetric(

                                horizontal:

                                    9,

                              ),

                              shape:

                                  RoundedRectangleBorder(

                                borderRadius:

                                    BorderRadius

                                        .circular(

                                  5,

                                ),

                              ),

                            ),

                          ),

                        ),

                      ],

                    ),

                  ),

                ),



                const Divider(

                  height: 1,

                  color:

                      Color(0xFFE5E7EB),

                ),



                InkWell(

                  onTap:

                      showProductPicker,

                  child:

                      SizedBox(

                    height: 43,

                    child:

                        Center(

                      child:

                          Text(

                        selectedProduct ??

                            'Tidak ada barang yang dipilih',

                        style:

                            TextStyle(

                          fontSize: 9,

                          color:

                              selectedProduct ==

                                      null

                                  ? const Color(

                                      0xFFB6BBC3,

                                    )

                                  : const Color(

                                      0xFF30343B,

                                    ),

                        ),

                      ),

                    ),

                  ),

                ),

              ],

            ),

          ),



          // =========================================

          // ERROR

          // =========================================



          if (showError)

            Container(

              height: 28,

              alignment:

                  Alignment

                      .centerLeft,

              padding:

                  const EdgeInsets

                      .symmetric(

                horizontal: 10,

              ),

              child:

                  const Row(

                children: [

                  Icon(

                    Icons

                        .error_outline,

                    size: 13,

                    color:

                        Color(

                      0xFFFF5964,

                    ),

                  ),

                  SizedBox(

                    width: 7,

                  ),

                  Text(

                    'Pilih Barang terlebih dahulu',

                    style:

                        TextStyle(

                      fontSize: 9,

                      color:

                          Color(

                        0xFFFF5964,

                      ),

                    ),

                  ),

                ],

              ),

            ),



          const SizedBox(

            height: 8,

          ),



          // =========================================

          // PEMASOK

          // =========================================



          _formRow(

            icon:

                Icons.person_outline,

            title:

                selectedSupplier ??

                    'Pilih Pemasok',

            onTap:

                showSupplierPicker,

          ),



          const SizedBox(

            height: 8,

          ),



          // =========================================

          // TANGGAL

          // =========================================



          _dateField(),



          const SizedBox(

            height: 8,

          ),



          // =========================================

          // CATATAN

          // =========================================



          _noteField(),



          const SizedBox(

            height: 17,

          ),



          // =========================================

          // SUCCESS

          // =========================================



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

                border:

                    Border.all(

                  color:

                      const Color(

                    0xFF38C878,

                  ),

                ),

              ),

              child:

                  const Row(

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

                  SizedBox(

                    width: 7,

                  ),

                  Expanded(

                    child:

                        Text(

                      'Stok masuk berhasil disimpan',

                      style:

                          TextStyle(

                        fontSize: 9,

                        color:

                            Color(

                          0xFF179957,

                        ),

                      ),

                    ),

                  ),

                ],

              ),

            ),



          // =========================================

          // SIMPAN

          // =========================================



          SizedBox(

            width: double.infinity,

            height: 34,

            child:

                ElevatedButton(

              onPressed:

                  saveStockIn,

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

                      BorderRadius

                          .circular(

                    5,

                  ),

                ),

              ),

              child:

                  const Text(

                'Simpan Stok Masuk',

                style:

                    TextStyle(

                  fontSize: 10,

                  fontWeight:

                      FontWeight.w600,

                ),

              ),

            ),

          ),

        ],

      ),

    );

  }



  // =================================================

  // FORM ROW

  // =================================================



  Widget _formRow({

    required IconData icon,

    required String title,

    required VoidCallback onTap,

  }) {

    return InkWell(

      onTap: onTap,

      child:

          Container(

        height: 35,

        padding:

            const EdgeInsets

                .symmetric(

          horizontal: 9,

        ),

        decoration:

            BoxDecoration(

          color: Colors.white,

          border:

              Border.all(

            color:

                const Color(

              0xFFE4E7EC,

            ),

          ),

          borderRadius:

              BorderRadius.circular(

            6,

          ),

        ),

        child:

            Row(

          children: [

            Icon(

              icon,

              size: 14,

              color:

                  const Color(

                0xFF657286,

              ),

            ),



            const SizedBox(

              width: 7,

            ),



            Expanded(

              child:

                  Text(

                title,

                style:

                    const TextStyle(

                  fontSize: 9,

                  color:

                      Color(

                    0xFF30343B,

                  ),

                ),

              ),

            ),



            const Icon(

              Icons.chevron_right,

              size: 15,

              color:

                  Color(0xFF788392),

            ),

          ],

        ),

      ),

    );

  }



  // =================================================

  // DATE FIELD

  // =================================================



  Widget _dateField() {

    return InkWell(

      onTap:

          selectDate,

      child:

          Container(

        decoration:

            BoxDecoration(

          color: Colors.white,

          border:

              Border.all(

            color:

                const Color(

              0xFFE4E7EC,

            ),

          ),

          borderRadius:

              BorderRadius.circular(

            6,

          ),

        ),

        child:

            Column(

          children: [

            SizedBox(

              height: 35,

              child:

                  Padding(

                padding:

                    const EdgeInsets

                        .symmetric(

                  horizontal: 9,

                ),

                child:

                    Row(

                  children: [

                    const Icon(

                      Icons

                          .calendar_today_outlined,

                      size: 13,

                      color:

                          Color(

                        0xFF657286,

                      ),

                    ),



                    const SizedBox(

                      width: 7,

                    ),



                    const Text(

                      'Tanggal Transaksi',

                      style:

                          TextStyle(

                        fontSize: 9,

                        color:

                            Color(

                          0xFF30343B,

                        ),

                      ),

                    ),



                    const Spacer(),



                    const Icon(

                      Icons

                          .access_time_outlined,

                      size: 14,

                      color:

                          Color(

                        0xFF657286,

                      ),

                    ),

                  ],

                ),

              ),

            ),



            const Divider(

              height: 1,

              color:

                  Color(0xFFF0F1F3),

            ),



            SizedBox(

              height: 29,

              child:

                  Align(

                alignment:

                    Alignment

                        .centerLeft,

                child:

                    Padding(

                  padding:

                      const EdgeInsets

                          .symmetric(

                    horizontal: 9,

                  ),

                  child:

                      Text(

                    formatDate(

                      selectedDate,

                    ),

                    style:

                        const TextStyle(

                      fontSize: 8,

                      color:

                          Color(

                        0xFF58606B,

                      ),

                    ),

                  ),

                ),

              ),

            ),

          ],

        ),

      ),

    );

  }



  // =================================================

  // NOTE

  // =================================================



  Widget _noteField() {

    return Container(

      height: 86,

      decoration:

          BoxDecoration(

        color: Colors.white,

        border:

            Border.all(

          color:

              const Color(

            0xFFE4E7EC,

          ),

        ),

        borderRadius:

            BorderRadius.circular(

          6,

        ),

      ),

      child:

          Column(

        children: [

          SizedBox(

            height: 29,

            child:

                Padding(

              padding:

                  const EdgeInsets

                      .symmetric(

                horizontal: 9,

              ),

              child:

                  Row(

                children: [

                  const Icon(

                    Icons

                        .description_outlined,

                    size: 13,

                    color:

                        Color(

                      0xFF657286,

                    ),

                  ),



                  const SizedBox(

                    width: 7,

                  ),



                  const Text(

                    'Catatan',

                    style:

                        TextStyle(

                      fontSize: 9,

                      color:

                          Color(

                        0xFF30343B,

                      ),

                    ),

                  ),

                ],

              ),

            ),

          ),



          const Divider(

            height: 1,

            color:

                Color(0xFFF0F1F3),

          ),



          Expanded(

            child:

                TextField(

              controller:

                  noteController,

              maxLines: 3,

              style:

                  const TextStyle(

                fontSize: 8,

              ),

              decoration:

                  const InputDecoration(

                hintText:

                    'Tulis catatan di sini...',

                hintStyle:

                    TextStyle(

                  fontSize: 8,

                  color:

                      Color(

                    0xFFB6BBC3,

                  ),

                ),

                border:

                    InputBorder.none,

                contentPadding:

                    EdgeInsets

                        .symmetric(

                  horizontal: 9,

                  vertical: 7,

                ),

              ),

            ),

          ),

        ],

      ),

    );

  }



  // =================================================

  // BOTTOM NAVIGATION

  // =================================================



  Widget _buildBottomNavigation() {

    return Container(

      height: 67,

      decoration:

          const BoxDecoration(

        color: Colors.white,

      ),

      child:

          Row(

        mainAxisAlignment:

            MainAxisAlignment

                .spaceAround,

        children: [

          _bottomItem(

            Icons.home_outlined,

            'Home',

            0,

          ),

          _bottomItem(

            Icons.qr_code_scanner,

            'Scanner',

            1,

          ),

          _bottomItem(

            Icons.receipt_long_outlined,

            'Riwayat',

            2,

          ),

          _bottomItem(

            Icons.person_outline,

            'Profil',

            3,

          ),

        ],

      ),

    );

  }



  Widget _bottomItem(

    IconData icon,

    String label,

    int index,

  ) {

    return GestureDetector(

      onTap: () =>

          navigateBottom(index),

      child:

          SizedBox(

        width: 60,

        child:

            Column(

          mainAxisAlignment:

              MainAxisAlignment

                  .center,

          children: [

            Icon(

              icon,

              size: 19,

              color:

                  const Color(

                0xFF718096,

              ),

            ),

            const SizedBox(

              height: 3,

            ),

            Text(

              label,

              style:

                  const TextStyle(

                fontSize: 8,

                color:

                    Color(

                  0xFF718096,

                ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}