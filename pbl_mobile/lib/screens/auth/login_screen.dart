import 'package:flutter/material.dart';

import '../../models/user_data.dart';
import 'signup_screen.dart';
import '../home/home_screen.dart';
import 'reset_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter your email and password',
          ),
        ),
      );
      return;
    }

    // ============================================================
    // MEMBUAT DATA USER DARI EMAIL LOGIN
    // Contoh:
    // annisa.intan@gmail.com -> Annisa Intan
    // zefanya@gmail.com      -> Zefanya
    // ============================================================

    final rawName = email.split('@').first.trim();

    final userName = rawName
        .replaceAll('.', ' ')
        .replaceAll('_', ' ')
        .replaceAll('-', ' ')
        .split(' ')
        .where((part) => part.isNotEmpty)
        .map(
          (part) =>
              part[0].toUpperCase() +
              part.substring(1).toLowerCase(),
        )
        .join(' ');

    final user = UserData(
      name: userName.isEmpty ? 'User' : userName,
      email: email,
    );

    // ============================================================
    // MASUK KE HOME DENGAN DATA USER
    // ============================================================

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          user: user,
        ),
      ),
    );
  }

  void openResetPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const ResetPasswordScreen(),
      ),
    );
  }

  void openSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(
              maxWidth: 430,
            ),
            color: Colors.white,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 28,
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          // =========================
                          // LOGO
                          // =========================

                          const Center(
                            child: StockLogo(),
                          ),

                          const SizedBox(
                            height: 76,
                          ),

                          // =========================
                          // TITLE
                          // =========================

                          const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              height: 1.1,
                            ),
                          ),

                          const SizedBox(
                            height: 18,
                          ),

                          // =========================
                          // EMAIL
                          // =========================

                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          _inputField(
                            controller: emailController,
                            hintText: '',
                            keyboardType:
                                TextInputType.emailAddress,
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          // =========================
                          // PASSWORD
                          // =========================

                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(
                            height: 8,
                          ),

                          _passwordField(),

                          // =========================
                          // FORGOT PASSWORD
                          // =========================

                          Align(
                            alignment:
                                Alignment.centerRight,
                            child: TextButton(
                              onPressed:
                                  openResetPassword,
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets
                                        .symmetric(
                                  vertical: 10,
                                  horizontal: 0,
                                ),
                              ),
                              child: const Text(
                                'Forget password?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color:
                                      Color(0xFF9AAA82),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 43,
                          ),

                          // =========================
                          // LOGIN BUTTON
                          // =========================

                          SizedBox(
                            width: double.infinity,
                            height: 38,
                            child: ElevatedButton(
                              onPressed: login,
                              style:
                                  ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color(
                                  0xFF587B55,
                                ),
                                foregroundColor:
                                    Colors.white,
                                elevation: 0,
                                padding:
                                    EdgeInsets.zero,
                                shape:
                                    RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius
                                          .circular(
                                    22,
                                  ),
                                ),
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight:
                                      FontWeight.w400,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          // =========================
                          // SIGN UP LINK
                          // =========================

                          Center(
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: openSignup,
                                  child: const Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight:
                                          FontWeight.w700,
                                      color:
                                          Color(0xFF587B55),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          // =========================
                          // FACEBOOK
                          // =========================

                          _socialButton(
                            type: SocialType.facebook,
                            text:
                                'Continue with Facebook',
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          // =========================
                          // GOOGLE
                          // =========================

                          _socialButton(
                            type: SocialType.google,
                            text:
                                'Continue with Google',
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // INPUT EMAIL
  // ============================================================

  Widget _inputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      height: 41,
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // PASSWORD FIELD
  // ============================================================

  Widget _passwordField() {
    return SizedBox(
      height: 41,
      child: TextField(
        controller: passwordController,
        obscureText: obscurePassword,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscurePassword =
                    !obscurePassword;
              });
            },
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 19,
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SOCIAL BUTTON
  // ============================================================

  Widget _socialButton({
    required SocialType type,
    required String text,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          side: const BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            _socialIcon(type),
            const SizedBox(width: 18),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SOCIAL ICON
  // ============================================================

  Widget _socialIcon(SocialType type) {
    if (type == SocialType.facebook) {
      return Container(
        width: 27,
        height: 27,
        decoration: const BoxDecoration(
          color: Color(0xFF1877F2),
          shape: BoxShape.circle,
        ),
        child: const Center(
          child: Text(
            'f',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return const Text(
      'G',
      style: TextStyle(
        fontSize: 23,
        fontWeight: FontWeight.w600,
        color: Color(0xFF4285F4),
      ),
    );
  }
}

// =====================================================
// STOCK.CO LOGO
// =====================================================

class StockLogo extends StatelessWidget {
  const StockLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 23,
          height: 23,
          decoration: BoxDecoration(
            color: const Color(0xFF101914),
            borderRadius:
                BorderRadius.circular(3),
          ),
          child: const Icon(
            Icons.view_in_ar,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(width: 4),
        const Text(
          'stock.co',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w800,
            color: Colors.black,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}

enum SocialType {
  facebook,
  google,
}