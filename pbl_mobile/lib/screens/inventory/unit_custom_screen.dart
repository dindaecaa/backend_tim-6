import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../scanner/scanner_screen.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';



class UnitCustomScreen extends StatefulWidget {

  const UnitCustomScreen({super.key});



  @override

  State<UnitCustomScreen> createState() => _UnitCustomScreenState();

}



class _UnitCustomScreenState extends State<UnitCustomScreen> {

  final TextEditingController searchController =

      TextEditingController();



  final List<UnitData> units = [

    UnitData(

      abbreviation: 'pcs',

      name: 'Pcs',

      description: 'Barang satuan: casing, konektor RJ45',

    ),

    UnitData(

      abbreviation: 'unit',

      name: 'Unit',

      description: 'Perangkat: router, switch, adaptor',

    ),

    UnitData(

      abbreviation: 'box',

      name: 'Box',

      description: 'Kemasan dus: kabel UTP, aksesori',

    ),

    UnitData(

      abbreviation: 'pack',

      name: 'Pack',

      description: 'Kemasan paket: konektor, cable tie',

    ),

    UnitData(

      abbreviation: 'm',

      name: 'Meter',

      description: 'Ukuran panjang: kabel potongan',

    ),

    UnitData(

      abbreviation: 'roll',

      name: 'Roll',

      description: 'Barang gulungan: kabel, selotip',

    ),

  ];



  @override

  void dispose() {

    searchController.dispose();

    super.dispose();

  }



  // =========================================================

  // FILTER SATUAN

  // =========================================================



  List<UnitData> get filteredUnits {

    final query =

        searchController.text.trim().toLowerCase();



    if (query.isEmpty) {

      return units;

    }



    return units.where((unit) {

      return unit.name.toLowerCase().contains(query) ||

          unit.abbreviation

              .toLowerCase()

              .contains(query) ||

          unit.description

              .toLowerCase()

              .contains(query);

    }).toList();

  }



  // =========================================================

  // TAMBAH SATUAN

  // =========================================================



  void showAddUnitDialog() {

    final nameController =

        TextEditingController();



    final abbreviationController =

        TextEditingController();



    final descriptionController =

        TextEditingController();



    showDialog(

      context: context,

      builder: (dialogContext) {

        return AlertDialog(

          backgroundColor: Colors.white,

          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(16),

          ),

          title: const Text(

            'Tambah Satuan',

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

                  label: 'Nama Satuan',

                  hint: 'Contoh: Meter',

                ),

                const SizedBox(height: 12),

                _dialogField(

                  controller: abbreviationController,

                  label: 'Singkatan',

                  hint: 'Contoh: m',

                ),

                const SizedBox(height: 12),

                _dialogField(

                  controller: descriptionController,

                  label: 'Keterangan',

                  hint: 'Contoh: Ukuran panjang kabel',

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

                final name =

                    nameController.text.trim();



                final abbreviation =

                    abbreviationController.text.trim();



                final description =

                    descriptionController.text.trim();



                if (name.isEmpty ||

                    abbreviation.isEmpty) {

                  ScaffoldMessenger.of(context)

                      .showSnackBar(

                    const SnackBar(

                      content: Text(

                        'Nama dan singkatan satuan wajib diisi.',

                      ),

                    ),

                  );

                  return;

                }



                setState(() {

                  units.add(

                    UnitData(

                      abbreviation: abbreviation,

                      name: name,

                      description: description.isEmpty

                          ? 'Belum ada keterangan'

                          : description,

                    ),

                  );

                });



                Navigator.pop(dialogContext);



                ScaffoldMessenger.of(context)

                    .showSnackBar(

                  const SnackBar(

                    content: Text(

                      'Satuan berhasil ditambahkan.',

                    ),

                  ),

                );

              },

              style: ElevatedButton.styleFrom(

                backgroundColor:

                    const Color(0xFF587B55),

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



  // =========================================================

  // EDIT SATUAN

  // =========================================================



  void showEditUnitDialog(UnitData unit) {

    final nameController =

        TextEditingController(

      text: unit.name,

    );



    final abbreviationController =

        TextEditingController(

      text: unit.abbreviation,

    );



    final descriptionController =

        TextEditingController(

      text: unit.description,

    );



    showDialog(

      context: context,

      builder: (dialogContext) {

        return AlertDialog(

          backgroundColor: Colors.white,

          shape: RoundedRectangleBorder(

            borderRadius: BorderRadius.circular(16),

          ),

          title: const Text(

            'Edit Satuan',

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

                  label: 'Nama Satuan',

                  hint: 'Nama satuan',

                ),

                const SizedBox(height: 12),

                _dialogField(

                  controller: abbreviationController,

                  label: 'Singkatan',

                  hint: 'Singkatan satuan',

                ),

                const SizedBox(height: 12),

                _dialogField(

                  controller: descriptionController,

                  label: 'Keterangan',

                  hint: 'Keterangan satuan',

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

                final name =

                    nameController.text.trim();



                final abbreviation =

                    abbreviationController.text.trim();



                final description =

                    descriptionController.text.trim();



                if (name.isEmpty ||

                    abbreviation.isEmpty) {

                  ScaffoldMessenger.of(context)

                      .showSnackBar(

                    const SnackBar(

                      content: Text(

                        'Nama dan singkatan satuan wajib diisi.',

                      ),

                    ),

                  );

                  return;

                }



                setState(() {

                  unit.name = name;

                  unit.abbreviation = abbreviation;

                  unit.description = description.isEmpty

                      ? 'Belum ada keterangan'

                      : description;

                });



                Navigator.pop(dialogContext);



                ScaffoldMessenger.of(context)

                    .showSnackBar(

                  const SnackBar(

                    content: Text(

                      'Satuan berhasil diperbarui.',

                    ),

                  ),

                );

              },

              style: ElevatedButton.styleFrom(

                backgroundColor:

                    const Color(0xFF587B55),

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



  // =========================================================

  // DIALOG FIELD

  // =========================================================



  Widget _dialogField({

    required TextEditingController controller,

    required String label,

    required String hint,

  }) {

    return Column(

      crossAxisAlignment:

          CrossAxisAlignment.start,

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

          decoration: InputDecoration(

            hintText: hint,

            hintStyle: const TextStyle(

              fontSize: 11,

              color: Color(0xFFB4BBC5),

            ),

            filled: true,

            fillColor:

                const Color(0xFFF7F8FA),

            contentPadding:

                const EdgeInsets.symmetric(

              horizontal: 12,

              vertical: 11,

            ),

            border: OutlineInputBorder(

              borderRadius:

                  BorderRadius.circular(8),

              borderSide: BorderSide.none,

            ),

          ),

        ),

      ],

    );

  }



  // =========================================================

  // BUILD

  // =========================================================



  @override

  Widget build(BuildContext context) {

    final filtered = filteredUnits;



    return Scaffold(

      backgroundColor:

          const Color(0xFFF4F5F8),



      body: SafeArea(

        child: Column(

          children: [

            // =================================================

            // HEADER

            // =================================================



            Container(

              width: double.infinity,

              height: 52,

              color: Colors.white,

              padding:

                  const EdgeInsets.symmetric(

                horizontal: 12,

              ),

              child: Row(

                children: [

                  GestureDetector(

                    onTap: () {

                      Navigator.pop(context);

                    },

                    child: Container(

                      width: 28,

                      height: 28,

                      decoration:

                          const BoxDecoration(

                        color: Color(0xFFF1F5FF),

                        shape: BoxShape.circle,

                      ),

                      child: const Icon(

                        Icons.arrow_back_ios_new,

                        size: 12,

                        color:

                            Color(0xFF4E7DEB),

                      ),

                    ),

                  ),

                  const SizedBox(width: 9),

                  const Text(

                    'Satuan Kustom',

                    style: TextStyle(

                      fontSize: 15,

                      fontWeight:

                          FontWeight.w700,

                      color:

                          Color(0xFF202124),

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

                padding:

                    const EdgeInsets.fromLTRB(

                  12,

                  11,

                  12,

                  18,

                ),

                child: Column(

                  crossAxisAlignment:

                      CrossAxisAlignment.start,

                  children: [

                    // =================================================

                    // INTRO

                    // =================================================



                    const Text(

                      'Satuan yang pas untuk setiap barang',

                      style: TextStyle(

                        fontSize: 11,

                        fontWeight:

                            FontWeight.w700,

                        color:

                            Color(0xFF30343B),

                      ),

                    ),



                    const SizedBox(height: 3),



                    const Text(

                      'Kelola nama dan singkatan satuan inventaris.',

                      style: TextStyle(

                        fontSize: 8.5,

                        color:

                            Color(0xFF718096),

                      ),

                    ),



                    const SizedBox(height: 9),



                    // =================================================

                    // SEARCH

                    // =================================================



                    Container(

                      height: 35,

                      decoration:

                          BoxDecoration(

                        color: Colors.white,

                        borderRadius:

                            BorderRadius.circular(

                          8,

                        ),

                        border: Border.all(

                          color:

                              const Color(

                            0xFFE1E5EB,

                          ),

                        ),

                      ),

                      child: TextField(

                        controller:

                            searchController,

                        onChanged: (_) {

                          setState(() {});

                        },

                        style:

                            const TextStyle(

                          fontSize: 9,

                          color:

                              Color(0xFF30343B),

                        ),

                        decoration:

                            const InputDecoration(

                          border:

                              InputBorder.none,

                          prefixIcon: Icon(

                            Icons.search,

                            size: 16,

                            color:

                                Color(0xFF718096),

                          ),

                          hintText:

                              'Cari nama atau singkatan satuan...',

                          hintStyle:

                              TextStyle(

                            fontSize: 9,

                            color:

                                Color(0xFF9AA3B2),

                          ),

                          contentPadding:

                              EdgeInsets.only(

                            right: 8,

                            bottom: 7,

                          ),

                        ),

                      ),

                    ),



                    const SizedBox(height: 9),



                    // =================================================

                    // HEADER DAFTAR

                    // =================================================



                    Row(

                      mainAxisAlignment:

                          MainAxisAlignment

                              .spaceBetween,

                      children: [

                        const Text(

                          'Daftar Satuan',

                          style: TextStyle(

                            fontSize: 10,

                            fontWeight:

                                FontWeight.w700,

                            color:

                                Color(0xFF30343B),

                          ),

                        ),

                        Text(

                          '${units.length} satuan',

                          style:

                              const TextStyle(

                            fontSize: 8,

                            color:

                                Color(0xFF718096),

                          ),

                        ),

                      ],

                    ),



                    const SizedBox(height: 7),



                    // =================================================

                    // LIST SATUAN

                    // =================================================



                    if (filtered.isEmpty)

                      _buildEmptyState()

                    else

                      ...filtered.map(

                        (unit) =>

                            _buildUnitCard(unit),

                      ),



                    const SizedBox(height: 4),



                    // =================================================

                    // TAMBAH SATUAN

                    // =================================================



                    SizedBox(

                      width: double.infinity,

                      height: 36,

                      child: ElevatedButton(

                        onPressed:

                            showAddUnitDialog,

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

                              7,

                            ),

                          ),

                        ),

                        child: const Row(

                          mainAxisAlignment:

                              MainAxisAlignment

                                  .center,

                          children: [

                            Icon(

                              Icons.add,

                              size: 15,

                            ),

                            SizedBox(width: 5),

                            Text(

                              'Tambah Satuan',

                              style: TextStyle(

                                fontSize: 10,

                                fontWeight:

                                    FontWeight

                                        .w600,

                              ),

                            ),

                          ],

                        ),

                      ),

                    ),



                    const SizedBox(height: 9),



                    // =================================================

                    // INFORMATION

                    // =================================================



                    Container(

                      width: double.infinity,

                      padding:

                          const EdgeInsets

                              .symmetric(

                        horizontal: 9,

                        vertical: 9,

                      ),

                      decoration:

                          BoxDecoration(

                        color:

                            const Color(

                          0xFFEAF3E7,

                        ),

                        borderRadius:

                            BorderRadius.circular(

                          7,

                        ),

                      ),

                      child: const Row(

                        crossAxisAlignment:

                            CrossAxisAlignment

                                .start,

                        children: [

                          Icon(

                            Icons

                                .info_outline,

                            size: 13,

                            color:

                                Color(

                              0xFF587B55,

                            ),

                          ),

                          SizedBox(width: 6),

                          Expanded(

                            child: Text(

                              'Satuan adalah label ukur barang. Tidak ada konversi otomatis antar satuan.',

                              style:

                                  TextStyle(

                                fontSize: 8,

                                height: 1.35,

                                color:

                                    Color(

                                  0xFF587B55,

                                ),

                              ),

                            ),

                          ),

                        ],

                      ),

                    ),

                  ],

                ),

              ),

            ),

          ],

        ),

      ),



      // =================================================

      // BOTTOM NAVIGATION

      // =================================================



      bottomNavigationBar:

          _buildBottomNavigation(),

    );

  }



  // =========================================================

  // UNIT CARD

  // =========================================================



  Widget _buildUnitCard(UnitData unit) {

    return Container(

      width: double.infinity,

      margin:

          const EdgeInsets.only(bottom: 6),

      padding:

          const EdgeInsets.fromLTRB(

        8,

        7,

        8,

        7,

      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:

            BorderRadius.circular(8),

        boxShadow: [

          BoxShadow(

            color: Colors.black

                .withValues(alpha: 0.025),

            blurRadius: 4,

            offset:

                const Offset(0, 2),

          ),

        ],

      ),

      child: Row(

        children: [

          // =================================================

          // SINGKATAN

          // =================================================



          Container(

            width: 34,

            height: 34,

            decoration:

                BoxDecoration(

              color:

                  const Color(0xFFF1F4FF),

              borderRadius:

                  BorderRadius.circular(

                7,

              ),

            ),

            alignment:

                Alignment.center,

            child: Text(

              unit.abbreviation,

              maxLines: 1,

              overflow:

                  TextOverflow.ellipsis,

              style:

                  const TextStyle(

                fontSize: 8,

                fontWeight:

                    FontWeight.w700,

                color:

                    Color(0xFF4169E1),

              ),

            ),

          ),



          const SizedBox(width: 8),



          // =================================================

          // INFORMATION

          // =================================================



          Expanded(

            child: Column(

              crossAxisAlignment:

                  CrossAxisAlignment.start,

              children: [

                Text(

                  unit.name,

                  maxLines: 1,

                  overflow:

                      TextOverflow.ellipsis,

                  style:

                      const TextStyle(

                    fontSize: 9.5,

                    fontWeight:

                        FontWeight.w700,

                    color:

                        Color(0xFF30343B),

                  ),

                ),

                const SizedBox(height: 3),

                Text(

                  unit.description,

                  maxLines: 1,

                  overflow:

                      TextOverflow.ellipsis,

                  style:

                      const TextStyle(

                    fontSize: 7.5,

                    color:

                        Color(0xFF718096),

                  ),

                ),

              ],

            ),

          ),



          const SizedBox(width: 5),



          // =================================================

          // EDIT BUTTON

          // =================================================



          GestureDetector(

            onTap: () {

              showEditUnitDialog(unit);

            },

            child: Container(

              width: 29,

              height: 29,

              decoration:

                  BoxDecoration(

                color:

                    const Color(0xFFF5F6F8),

                borderRadius:

                    BorderRadius.circular(

                  7,

                ),

              ),

              child: const Icon(

                Icons.edit_outlined,

                size: 15,

                color:

                    Color(0xFF718096),

              ),

            ),

          ),

        ],

      ),

    );

  }



  // =========================================================

  // EMPTY STATE

  // =========================================================



  Widget _buildEmptyState() {

    return Container(

      width: double.infinity,

      margin:

          const EdgeInsets.only(

        top: 20,

        bottom: 8,

      ),

      padding:

          const EdgeInsets.symmetric(

        horizontal: 20,

        vertical: 25,

      ),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:

            BorderRadius.circular(10),

      ),

      child: Column(

        children: [

          Container(

            width: 48,

            height: 48,

            decoration:

                const BoxDecoration(

              color:

                  Color(0xFFF1F4FF),

              shape: BoxShape.circle,

            ),

            child: const Icon(

              Icons.straighten_outlined,

              color:

                  Color(0xFF4169E1),

              size: 25,

            ),

          ),

          const SizedBox(height: 12),

          const Text(

            'Belum ada satuan',

            style: TextStyle(

              fontSize: 12,

              fontWeight:

                  FontWeight.w700,

              color:

                  Color(0xFF30343B),

            ),

          ),

          const SizedBox(height: 5),

          const Text(

            'Tambahkan satuan untuk membantu mengelola ukuran barang.',

            textAlign:

                TextAlign.center,

            style: TextStyle(

              fontSize: 8.5,

              color:

                  Color(0xFF718096),

            ),

          ),

        ],

      ),

    );

  }



  // =========================================================

  // BOTTOM NAVIGATION

  // =========================================================



  Widget _buildBottomNavigation() {
    return Container(
      height: 75,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _bottomItem(
            icon: Icons.home_outlined,
            label: 'Home',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
          ),
          _bottomItem(
            icon: Icons.qr_code_scanner,
            label: 'Scanner',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ScannerScreen(),
                ),
              );
            },
          ),
          _bottomItem(
            icon: Icons.receipt_long_outlined,
            label: 'Riwayat',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(),
                ),
              );
            },
          ),
          _bottomItem(
            icon: Icons.person_outline,
            label: 'Profil',
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _bottomItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 19,
              color: const Color(0xFF667085),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 8,
                color: Color(0xFF667085),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// MODEL SATUAN


// =========================================================



class UnitData {

  String abbreviation;

  String name;

  String description;



  UnitData({

    required this.abbreviation,

    required this.name,

    required this.description,

  });
}