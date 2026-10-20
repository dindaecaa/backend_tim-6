import 'package:flutter/material.dart';

import '../auth/signup_screen.dart';
import '../auth/login_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _openSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  void _openLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void _showSocialMessage(
    BuildContext context,
    String platform,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$platform login belum tersedia',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF294A40),
      body: SafeArea(
        child: Stack(
          children: [
            // =====================================================
            // BACKGROUND IMAGE
            // =====================================================

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height:
                  MediaQuery.of(context).size.height * 0.68,
              child: Image.asset(
                'assets/images/stock_welcome.jpg',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),

            // =====================================================
            // GRADIENT OVERLAY
            // =====================================================

            Positioned(
              top:
                  MediaQuery.of(context).size.height * 0.42,
              left: 0,
              right: 0,
              height:
                  MediaQuery.of(context).size.height * 0.30,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xFF294A40),
                    ],
                  ),
                ),
              ),
            ),

            // =====================================================
            // CONTENT
            // =====================================================

            Positioned.fill(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Spacer(),

                  // =================================================
                  // WELCOME TEXT
                  // =================================================

                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            color: Color(0xFF101A38),
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            height: 1.05,
                          ),
                        ),
                        Text(
                          'stock.co',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            height: 1.05,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 34),

                  // =================================================
                  // START WITH EMAIL
                  // =================================================

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () =>
                            _openSignup(context),
                        style:
                            ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF101A38),
                          foregroundColor:
                              Colors.white,
                          elevation: 0,
                          shape:
                              RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(24),
                          ),
                        ),
                        child: const Text(
                          'Start with email',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight:
                                FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =================================================
                  // SIGN IN WITH DIVIDER
                  // =================================================

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 53,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.2,
                            color: Colors.white54,
                          ),
                        ),
                        const Padding(
                          padding:
                              EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Text(
                            'Sign in with',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 1.2,
                            color: Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =================================================
                  // FACEBOOK
                  // =================================================

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 36,
                    ),
                    child: _socialButton(
                      icon: const _FacebookIcon(),
                      text:
                          'Continue with Facebook',
                      onPressed: () {
                        _showSocialMessage(
                          context,
                          'Facebook',
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =================================================
                  // GOOGLE
                  // =================================================

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 36,
                    ),
                    child: _socialButton(
                      icon: const _GoogleIcon(),
                      text:
                          'Continue with Google',
                      onPressed: () {
                        _showSocialMessage(
                          context,
                          'Google',
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 13),

                  // =================================================
                  // SIGN IN
                  // =================================================

                  Center(
                    child: Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                        GestureDetector(
                          onTap: () =>
                              _openLogin(context),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                              color:
                                  Color(0xFFFF4B4B),
                              fontSize: 10,
                              fontWeight:
                                  FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // SOCIAL BUTTON
  // =====================================================

  Widget _socialButton({
    required Widget icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 34,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(22),
          ),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================
// FACEBOOK ICON
// =====================================================

class _FacebookIcon extends StatelessWidget {
  const _FacebookIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: const BoxDecoration(
        color: Color(0xFF1877F2),
        shape: BoxShape.circle,
      ),
      child: const Center(
        child: Text(
          'f',
          style: TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// =====================================================
// GOOGLE ICON
// =====================================================

class _GoogleIcon extends StatelessWidget {
  const _GoogleIcon();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'G',
      style: TextStyle(
        color: Color(0xFF4285F4),
        fontSize: 22,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}