import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../scanner/scanner_screen.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';



class CategoryCustomScreen extends StatefulWidget {

  const CategoryCustomScreen({super.key});



  @override

  State<CategoryCustomScreen> createState() =>

      _CategoryCustomScreenState();

}



class _CategoryCustomScreenState

    extends State<CategoryCustomScreen> {

  final TextEditingController searchController =

      TextEditingController();



  final List<CategoryData> categories = [

    CategoryData(

      name: 'Aksesori HP',

      itemCount: 18,

      description: 'Casing, tempered glass, holder',

      icon: Icons.phone_android_outlined,

    ),

    CategoryData(

      name: 'Kabel & Konektor',

      itemCount: 14,

      description: 'Kabel UTP, USB, konektor RJ45',

      icon: Icons.cable_outlined,

    ),

    CategoryData(

      name: 'Perangkat Jaringan',

      itemCount: 9,

      description: 'Router, switch, access point',

      icon: Icons.router_outlined,

    ),

    CategoryData(

      name: 'Audio',

      itemCount: 8,

      description: 'Earphone, headset, speaker',

      icon: Icons.headphones_outlined,

    ),

    CategoryData(

      name: 'Pengisi Daya',

      itemCount: 11,

      description: 'Adaptor, charger, power bank',

      icon: Icons.power_outlined,

    ),

  ];



  @override

  void dispose() {

    searchController.dispose();

    super.dispose();

  }



  // =========================================================

  // FILTER KATEGORI

  // =========================================================



  List<CategoryData> get filteredCategories {

    final query =

        searchController.text.trim().toLowerCase();



    if (query.isEmpty) {

      return categories;

    }



    return categories.where((category) {

      return category.name

              .toLowerCase()

              .contains(query) ||

          category.description

              .toLowerCase()

              .contains(query);

    }).toList();

  }



  // =========================================================

  // TAMBAH KATEGORI

  // =========================================================



  void showAddCategoryDialog() {

    final nameController =

        TextEditingController();



    final descriptionController =

        TextEditingController();



    showDialog(

      context: context,

      builder: (dialogContext) {

        return AlertDialog(

          backgroundColor: Colors.white,

          shape: RoundedRectangleBorder(

            borderRadius:

                BorderRadius.circular(16),

          ),

          title: const Text(

            'Tambah Kategori',

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

                  label: 'Nama Kategori',

                  hint: 'Contoh: Smart Home',

                ),

                const SizedBox(height: 12),

                _dialogField(

                  controller:

                      descriptionController,

                  label: 'Deskripsi',

                  hint:

                      'Contoh: Produk smart home',

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



                final description =

                    descriptionController

                        .text

                        .trim();



                if (name.isEmpty) {

                  ScaffoldMessenger.of(context)

                      .showSnackBar(

                    const SnackBar(

                      content: Text(

                        'Nama kategori wajib diisi.',

                      ),

                    ),

                  );

                  return;

                }



                setState(() {

                  categories.add(

                    CategoryData(

                      name: name,

                      itemCount: 0,

                      description:

                          description.isEmpty

                              ? 'Belum ada deskripsi'

                              : description,

                      icon:

                          Icons.category_outlined,

                    ),

                  );

                });



                Navigator.pop(dialogContext);



                ScaffoldMessenger.of(context)

                    .showSnackBar(

                  const SnackBar(

                    content: Text(

                      'Kategori berhasil ditambahkan.',

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

  // EDIT KATEGORI

  // =========================================================



  void showEditCategoryDialog(

      CategoryData category) {

    final nameController =

        TextEditingController(

      text: category.name,

    );



    final descriptionController =

        TextEditingController(

      text: category.description,

    );



    showDialog(

      context: context,

      builder: (dialogContext) {

        return AlertDialog(

          backgroundColor: Colors.white,

          shape: RoundedRectangleBorder(

            borderRadius:

                BorderRadius.circular(16),

          ),

          title: const Text(

            'Edit Kategori',

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

                  label: 'Nama Kategori',

                  hint: 'Nama kategori',

                ),

                const SizedBox(height: 12),

                _dialogField(

                  controller:

                      descriptionController,

                  label: 'Deskripsi',

                  hint: 'Deskripsi kategori',

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



                final description =

                    descriptionController

                        .text

                        .trim();



                if (name.isEmpty) {

                  ScaffoldMessenger.of(context)

                      .showSnackBar(

                    const SnackBar(

                      content: Text(

                        'Nama kategori wajib diisi.',

                      ),

                    ),

                  );

                  return;

                }



                setState(() {

                  category.name = name;

                  category.description =

                      description.isEmpty

                          ? 'Belum ada deskripsi'

                          : description;

                });



                Navigator.pop(dialogContext);



                ScaffoldMessenger.of(context)

                    .showSnackBar(

                  const SnackBar(

                    content: Text(

                      'Kategori berhasil diperbarui.',

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

    final filtered = filteredCategories;



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

                    'Kategori Kustom',

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

                      'Barang lebih rapi, mudah dicari',

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

                      'Kelompokkan 60 jenis barang sesuai kebutuhan toko.',

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

                              'Cari kategori...',

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

                          'Daftar Kategori',

                          style: TextStyle(

                            fontSize: 10,

                            fontWeight:

                                FontWeight.w700,

                            color:

                                Color(0xFF30343B),

                          ),

                        ),

                        Text(

                          '${categories.length} kategori',

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

                    // LIST KATEGORI

                    // =================================================



                    if (filtered.isEmpty)

                      _buildEmptyState()

                    else

                      ...filtered.map(

                        (category) =>

                            _buildCategoryCard(

                          category,

                        ),

                      ),



                    const SizedBox(height: 4),



                    // =================================================

                    // TAMBAH KATEGORI

                    // =================================================



                    SizedBox(

                      width: double.infinity,

                      height: 36,

                      child: ElevatedButton(

                        onPressed:

                            showAddCategoryDialog,

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

                              'Tambah Kategori',

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

                              'Ketuk ikon pensil untuk mengubah nama atau mengelola kategori.',

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

  // CATEGORY CARD

  // =========================================================



  Widget _buildCategoryCard(

      CategoryData category) {

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

          // ICON

          // =================================================



          Container(

            width: 34,

            height: 34,

            decoration:

                BoxDecoration(

              color:

                  const Color(0xFFF3ECFF),

              borderRadius:

                  BorderRadius.circular(

                7,

              ),

            ),

            child: Icon(

              category.icon,

              size: 18,

              color:

                  const Color(0xFF8D4DE8),

            ),

          ),



          const SizedBox(width: 8),



          // =================================================

          // INFORMATION

          // =================================================



          Expanded(

            child: Column(

              crossAxisAlignment:

                  CrossAxisAlignment

                      .start,

              children: [

                Text(

                  category.name,

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

                const SizedBox(height: 2),

                Text(

                  '${category.itemCount} jenis barang',

                  style:

                      const TextStyle(

                    fontSize: 8,

                    color:

                        Color(0xFF587B55),

                    fontWeight:

                        FontWeight.w500,

                  ),

                ),

                const SizedBox(height: 1),

                Text(

                  category.description,

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

              showEditCategoryDialog(

                category,

              );

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

                  Color(0xFFF3ECFF),

              shape: BoxShape.circle,

            ),

            child: const Icon(

              Icons.category_outlined,

              color:

                  Color(0xFF8D4DE8),

              size: 25,

            ),

          ),

          const SizedBox(height: 12),

          const Text(

            'Belum ada kategori',

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

            'Tambahkan kategori untuk mengelompokkan barang.',

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
                  builder: (_) => HomeScreen(),
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
                  builder: (_) => ScannerScreen(),
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
                  builder: (_) => HistoryScreen(),
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
                  builder: (_) => ProfileScreen(),
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

// =========================================================

// MODEL KATEGORI

// =========================================================



class CategoryData {

  String name;

  int itemCount;

  String description;

  IconData icon;



  CategoryData({

    required this.name,

    required this.itemCount,

    required this.description,

    required this.icon,

  });
}