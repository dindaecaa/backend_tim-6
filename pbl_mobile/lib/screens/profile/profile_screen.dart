import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import '../scanner/scanner_screen.dart';
import '../history/history_screen.dart';
import '../../models/user_data.dart';

class ProfileScreen extends StatefulWidget {
  final UserData? user;

  const ProfileScreen({
    super.key,
    this.user,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationEnabled = true;
  bool biometricEnabled = true;

  // =========================================================
  // USER DATA
  // =========================================================

  String get userName {
    final name = widget.user?.name.trim();

    if (name != null && name.isNotEmpty) {
      return name;
    }

    return 'Pengguna';
  }

  String get userEmail {
    final email = widget.user?.email.trim();

    if (email != null && email.isNotEmpty) {
      return email;
    }

    return 'Belum ada email';
  }

  String get userInitials {
    final name = userName.trim();

    if (name.isEmpty) {
      return 'P';
    }

    final parts = name
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();

    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }

    return parts[0][0].toUpperCase();
  }

  // =========================================================
  // NAVIGATION
  // =========================================================

  void goHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          user: widget.user,
        ),
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  12,
                  4,
                  12,
                  20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // HEADER
                    // =================================================

                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Profil',
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF202124),
                            ),
                          ),
                        ),

                        Container(
                          width: 27,
                          height: 27,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: _showSettings,
                            icon: const Icon(
                              Icons.settings_outlined,
                              size: 15,
                              color: Color(0xFF737B87),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 13),

                    // =================================================
                    // PROFILE CARD
                    // =================================================

                    _profileCard(),

                    const SizedBox(height: 10),

                    // =================================================
                    // PRO BANNER
                    // =================================================

                    _proBanner(),

                    const SizedBox(height: 12),

                    // =================================================
                    // AKUN
                    // =================================================

                    _sectionTitle('AKUN'),

                    const SizedBox(height: 5),

                    _menuContainer(
                      children: [
                        _menuItem(
                          icon: Icons.person_outline,
                          iconBackground:
                              const Color(0xFFF0F2F5),
                          title: 'Ubah Profil',
                          subtitle:
                              'Edit nama, email, dan foto profil',
                          onTap: () {
                            _showMessage(
                              'Halaman Ubah Profil akan dibuat selanjutnya.',
                            );
                          },
                        ),

                        _divider(),

                        _menuItem(
                          icon: Icons.lock_outline,
                          iconBackground:
                              const Color(0xFFF0F2F5),
                          title: 'Ubah Kata Sandi',
                          subtitle:
                              'Perbarui keamanan akun Anda',
                          onTap: () {
                            _showMessage(
                              'Halaman Ubah Kata Sandi akan dibuat selanjutnya.',
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 7),

                    // TAMBAH AKUN

                    Align(
                      alignment: Alignment.centerLeft,
                      child: SizedBox(
                        height: 22,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            _showMessage(
                              'Tambah akun akan dibuat selanjutnya.',
                            );
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 11,
                          ),
                          label: const Text(
                            'Tambah',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color(0xFF5F7D5D),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // =================================================
                    // BISNIS & TIM
                    // =================================================

                    _sectionTitle('BISNIS & TIM'),

                    const SizedBox(height: 5),

                    _menuContainer(
                      children: [
                        _menuItem(
                          icon: Icons.store_outlined,
                          iconBackground:
                              const Color(0xFFE9F0FF),
                          title: 'Kelola Cabang',
                          subtitle:
                              'Tambah, edit, atau hapus cabang',
                          onTap: () {
                            _showMessage(
                              'Kelola Cabang akan dibuat selanjutnya.',
                            );
                          },
                        ),

                        _divider(),

                        _menuItem(
                          icon: Icons.people_outline,
                          iconBackground:
                              const Color(0xFFE9F0FF),
                          title: 'Anggota Tim',
                          subtitle:
                              'Atur anggota dan hak akses',
                          onTap: () {
                            _showMessage(
                              'Anggota Tim akan dibuat selanjutnya.',
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // =================================================
                    // PREFERENSI
                    // =================================================

                    _sectionTitle('PREFERENSI'),

                    const SizedBox(height: 5),

                    _menuContainer(
                      children: [
                        _switchMenuItem(
                          icon: Icons.notifications_none,
                          title: 'Notifikasi',
                          subtitle:
                              'Pemberitahuan stok dan aktivitas',
                          value: notificationEnabled,
                          onChanged: (value) {
                            setState(() {
                              notificationEnabled = value;
                            });
                          },
                        ),

                        _divider(),

                        _switchMenuItem(
                          icon: Icons.fingerprint,
                          title: 'Otentikasi Biometrik',
                          subtitle:
                              'Masuk dengan sidik jari atau wajah',
                          value: biometricEnabled,
                          onChanged: (value) {
                            setState(() {
                              biometricEnabled = value;
                            });
                          },
                        ),

                        _divider(),

                        _menuItem(
                          icon: Icons.language,
                          iconBackground:
                              const Color(0xFFF0F2F5),
                          title: 'Bahasa',
                          subtitle: 'Indonesia',
                          showChevron: true,
                          onTap: _showLanguage,
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // =================================================
                    // DUKUNGAN
                    // =================================================

                    _sectionTitle('DUKUNGAN'),

                    const SizedBox(height: 5),

                    _menuContainer(
                      children: [
                        _menuItem(
                          icon: Icons.lightbulb_outline,
                          iconBackground:
                              const Color(0xFFFFF1E5),
                          title: 'Kirim Kritik dan Saran',
                          subtitle:
                              'Bantu kami meningkatkan aplikasi',
                          onTap: () {
                            _showMessage(
                              'Form Kritik dan Saran akan dibuat selanjutnya.',
                            );
                          },
                        ),

                        _divider(),

                        _menuItem(
                          icon: Icons.help_outline,
                          iconBackground:
                              const Color(0xFFF0F2F5),
                          title: 'Pusat Bantuan',
                          subtitle:
                              'Panduan dan dukungan penggunaan',
                          onTap: () {
                            _showMessage(
                              'Pusat Bantuan akan dibuat selanjutnya.',
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // =================================================
                    // IKUTI KAMI
                    // =================================================

                    _sectionTitle('IKUTI KAMI'),

                    const SizedBox(height: 5),

                    _menuContainer(
                      children: [
                        _menuItem(
                          icon: Icons.camera_alt_outlined,
                          iconBackground:
                              const Color(0xFFFFEDE5),
                          title: 'Instagram',
                          subtitle: '@stock.co.id',
                          trailingText: '@stock.co.id',
                          onTap: () {
                            _showMessage(
                              'Instagram akan dibuka selanjutnya.',
                            );
                          },
                        ),

                        _divider(),

                        _menuItem(
                          icon: Icons.language,
                          iconBackground:
                              const Color(0xFFE7F0FF),
                          title: 'Website',
                          subtitle: 'stock.co.id',
                          trailingText: 'stock.co.id',
                          onTap: () {
                            _showMessage(
                              'Website akan dibuka selanjutnya.',
                            );
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 13),

                    // =================================================
                    // VERSION
                    // =================================================

                    const Center(
                      child: Text(
                        'Stock.co v2.4.0',
                        style: TextStyle(
                          fontSize: 7,
                          color: Color(0xFF9AA1AC),
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

      // =========================================================
      // BOTTOM NAVIGATION
      // =========================================================

      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  // =========================================================
  // PROFILE CARD
  // =========================================================

  Widget _profileCard() {
    return Container(
      height: 45,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(
              color: Color(0xFF667085),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                userInitials,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF30343B),
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  userEmail,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 7,
                    color: Color(0xFF9AA1AC),
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.chevron_right,
            size: 15,
            color: Color(0xFF7B8490),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // PRO BANNER
  // =========================================================

  Widget _proBanner() {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(
        horizontal: 7,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF20C769),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 25,
            height: 25,
            decoration: const BoxDecoration(
              color: Color(0xFFFF9D2E),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.workspace_premium_outlined,
              color: Colors.white,
              size: 14,
            ),
          ),

          const SizedBox(width: 7),

          const Expanded(
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Upgrade ke Pro',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Buka laporan lengkap dan fitur tambahan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 6,
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Lihat Pro',
              style: TextStyle(
                fontSize: 7,
                color: Color(0xFF2388E8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // SECTION TITLE
  // =========================================================

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 6,
        fontWeight: FontWeight.w600,
        color: Color(0xFF7A828D),
      ),
    );
  }

  // =========================================================
  // MENU CONTAINER
  // =========================================================

  Widget _menuContainer({
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // =========================================================
  // MENU ITEM
  // =========================================================

  Widget _menuItem({
    required IconData icon,
    required Color iconBackground,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    String? trailingText,
    bool showChevron = true,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(9),
      child: SizedBox(
        height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 7,
          ),
          child: Row(
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: iconBackground,
                  borderRadius:
                      BorderRadius.circular(6),
                ),
                child: Icon(
                  icon,
                  size: 14,
                  color: const Color(0xFF667085),
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3D4249),
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 6,
                        color: Color(0xFF9AA1AC),
                      ),
                    ),
                  ],
                ),
              ),

              if (trailingText != null)
                Text(
                  trailingText,
                  style: const TextStyle(
                    fontSize: 6,
                    color: Color(0xFF8B93A1),
                  ),
                ),

              if (showChevron)
                const SizedBox(width: 5),

              if (showChevron)
                const Icon(
                  Icons.chevron_right,
                  size: 14,
                  color: Color(0xFF8B93A1),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // SWITCH MENU ITEM
  // =========================================================

  Widget _switchMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SizedBox(
      height: 40,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 7,
        ),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: const Color(0xFFF0F2F5),
                borderRadius:
                    BorderRadius.circular(6),
              ),
              child: Icon(
                icon,
                size: 14,
                color: const Color(0xFF667085),
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF3D4249),
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 6,
                      color: Color(0xFF9AA1AC),
                    ),
                  ),
                ],
              ),
            ),

            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor:
                  const Color(0xFF20C769),
              inactiveThumbColor: Colors.white,
              inactiveTrackColor:
                  const Color(0xFFD4D8DD),
              materialTapTargetSize:
                  MaterialTapTargetSize.shrinkWrap,
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // DIVIDER
  // =========================================================

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.only(left: 40),
      child: Divider(
        height: 1,
        thickness: 0.5,
        color: Color(0xFFF0F1F3),
      ),
    );
  }

  // =========================================================
  // BOTTOM NAVIGATION
  // =========================================================

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
        mainAxisAlignment:
            MainAxisAlignment.spaceAround,
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
            selected: true,
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
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 62,
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration:
                  const Duration(milliseconds: 200),
              width: selected ? 41 : 30,
              height: selected ? 41 : 30,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF6F8F6A)
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: selected
                    ? Border.all(
                        color:
                            const Color(0xFFA7BE9F),
                        width: 3,
                      )
                    : null,
              ),
              child: Icon(
                icon,
                size: selected ? 19 : 18,
                color: selected
                    ? Colors.white
                    : const Color(0xFF718096),
              ),
            ),

            const SizedBox(height: 2),

            Text(
              label,
              style: TextStyle(
                fontSize: 8,
                fontWeight: selected
                    ? FontWeight.w600
                    : FontWeight.w400,
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

  // =========================================================
  // SETTINGS
  // =========================================================

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pengaturan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                ListTile(
                  leading: const Icon(
                    Icons.logout,
                  ),
                  title: const Text(
                    'Keluar',
                  ),
                  onTap: () {
                    Navigator.pop(context);

                    _showMessage(
                      'Logout akan dihubungkan dengan autentikasi selanjutnya.',
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

  // =========================================================
  // LANGUAGE
  // =========================================================

  void _showLanguage() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(18),
                child: Text(
                  'Pilih Bahasa',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ListTile(
                title: const Text(
                  'Indonesia',
                ),
                trailing: const Icon(
                  Icons.check,
                  color: Color(0xFF587B55),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: const Text(
                  'English',
                ),
                onTap: () {
                  Navigator.pop(context);

                  _showMessage(
                    'Bahasa English akan diaktifkan selanjutnya.',
                  );
                },
              ),

              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // =========================================================
  // MESSAGE
  // =========================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}