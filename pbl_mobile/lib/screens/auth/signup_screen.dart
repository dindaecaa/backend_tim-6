import 'package:flutter/material.dart';

import '../home/home_screen.dart';
import 'reset_password_screen.dart';
import 'login_screen.dart';
import '../../models/user_data.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void signup() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all fields'),
        ),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Konfirmasi password tidak sama dengan password.'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(
          user: UserData(
            name: name,
            email: email,
          ),
        ),
      ),
    );
  }

  void openResetPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      ),
    );
  }

  void openLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
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
                        horizontal: 43,
                        vertical: 28,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: StockLogo(),
                          ),

                          const SizedBox(height: 53),

                          const Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              height: 1.1,
                            ),
                          ),

                          const SizedBox(height: 18),

                          const Text(
                            'Name',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 8),

                          _inputField(
                            controller: nameController,
                          ),

                          const SizedBox(height: 18),

                          const Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 8),

                          _inputField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: true,
                          ),

                          const SizedBox(height: 18),

                          const Text(
                            'Password',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 8),

                          _passwordField(),

                          const SizedBox(height: 18),

                          const Text(
                            'Konfirmasi Password',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 8),

                          _confirmPasswordField(),

                          const SizedBox(height: 8),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: openResetPassword,
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 0,
                                ),
                              ),
                              child: const Text(
                                'Forget password?',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF9AAA82),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          SizedBox(
                            width: double.infinity,
                            height: 38,
                            child: ElevatedButton(
                              onPressed: signup,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF587B55),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22),
                                ),
                              ),
                              child: const Text(
                                'Daftar',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account? ',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: openLogin,
                                  child: const Text(
                                    'Sign in',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF587B55),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),

                          _socialButton(
                            type: SocialType.facebook,
                            text: 'Continue with Facebook',
                          ),

                          const SizedBox(height: 12),

                          _socialButton(
                            type: SocialType.google,
                            text: 'Continue with Google',
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

  Widget _inputField({
    required TextEditingController controller,
    TextInputType? keyboardType,
    bool prefixIcon = false,
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
          prefixIcon: prefixIcon
              ? Container(
                  margin: const EdgeInsets.only(
                    left: 8,
                    right: 5,
                    top: 7,
                    bottom: 7,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE9FFF3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.email_outlined,
                    size: 17,
                    color: Color(0xFF00A86B),
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

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
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscurePassword = !obscurePassword;
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
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  Widget _confirmPasswordField() {
    return SizedBox(
      height: 41,
      child: TextField(
        controller: confirmPasswordController,
        obscureText: obscureConfirmPassword,
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 8,
          ),
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureConfirmPassword = !obscureConfirmPassword;
              });
            },
            icon: Icon(
              obscureConfirmPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 19,
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11),
            borderSide: const BorderSide(
              color: Color(0xFF00C853),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

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
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialIcon(type),
            const SizedBox(width: 18),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

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
            borderRadius: BorderRadius.circular(3),
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
