import 'package:flutter/material.dart';
import 'verification_code_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {
  final TextEditingController emailController =
      TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void sendVerificationCode() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter your email address',
          ),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            VerificationCodeScreen(
          email: email,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: LayoutBuilder(
          builder: (
            BuildContext context,
            BoxConstraints constraints,
          ) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),

                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 28,
                  ),

                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      // =====================================
                      // LOGO STOCK.CO
                      // =====================================

                      Center(
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min,
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration:
                                  BoxDecoration(
                                color:
                                    const Color(
                                  0xFF1D2A20,
                                ),
                                borderRadius:
                                    BorderRadius
                                        .circular(3),
                              ),
                              child: const Icon(
                                Icons.view_in_ar,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),

                            const SizedBox(
                              width: 5,
                            ),

                            const Text(
                              'stock.co',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight:
                                    FontWeight.w700,
                                color:
                                    Color(0xFF111111),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // JARAK LOGO KE JUDUL
                      const SizedBox(
                        height: 42,
                      ),

                      // =====================================
                      // TITLE
                      // =====================================

                      const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight:
                              FontWeight.w700,
                          color:
                              Color(0xFF111111),
                        ),
                      ),

                      const SizedBox(
                        height: 8,
                      ),

                      // =====================================
                      // DESCRIPTION
                      // =====================================

                      const Text(
                        'Please enter your email address to request a\n'
                        'password reset',
                        style: TextStyle(
                          fontSize: 10,
                          height: 1.45,
                          color:
                              Color(0xFF444444),
                        ),
                      ),

                      const SizedBox(
                        height: 26,
                      ),

                      // =====================================
                      // EMAIL LABEL
                      // =====================================

                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight:
                              FontWeight.w500,
                          color:
                              Color(0xFF222222),
                        ),
                      ),

                      const SizedBox(
                        height: 7,
                      ),

                      // =====================================
                      // EMAIL INPUT
                      // =====================================

                      TextField(
                        controller:
                            emailController,

                        keyboardType:
                            TextInputType
                                .emailAddress,

                        style: const TextStyle(
                          fontSize: 12,
                          color:
                              Color(0xFF333333),
                        ),

                        decoration:
                            InputDecoration(
                          hintText:
                              'Enter your email',

                          hintStyle:
                              const TextStyle(
                            fontSize: 12,
                            color:
                                Color(0xFFAAAAAA),
                          ),

                          contentPadding:
                              const EdgeInsets
                                  .symmetric(
                            horizontal: 16,
                            vertical: 13,
                          ),

                          filled: true,
                          fillColor:
                              Colors.white,

                          border:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              22,
                            ),
                            borderSide:
                                const BorderSide(
                              color:
                                  Colors.black,
                              width: 1.1,
                            ),
                          ),

                          enabledBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              22,
                            ),
                            borderSide:
                                const BorderSide(
                              color:
                                  Colors.black,
                              width: 1.1,
                            ),
                          ),

                          focusedBorder:
                              OutlineInputBorder(
                            borderRadius:
                                BorderRadius
                                    .circular(
                              22,
                            ),
                            borderSide:
                                const BorderSide(
                              color:
                                  Color(
                                0xFF5F7D5D,
                              ),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 45,
                      ),

                      // =====================================
                      // SEND CODE BUTTON
                      // =====================================

                      SizedBox(
                        width: double.infinity,
                        height: 40,

                        child:
                            ElevatedButton(
                          onPressed:
                              sendVerificationCode,

                          style:
                              ElevatedButton
                                  .styleFrom(
                            backgroundColor:
                                const Color(
                              0xFF5F7D5D,
                            ),

                            foregroundColor:
                                Colors.white,

                            elevation: 0,

                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                22,
                              ),
                            ),
                          ),

                          child:
                              const Text(
                            'Send Code',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      // =====================================
                      // SPACER
                      // =====================================

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}