import 'package:flutter/material.dart';

import '../home/home_screen.dart';



class VerificationCodeScreen extends StatefulWidget {

   final String email;



   const VerificationCodeScreen({

      super.key,

      required this.email,

   });



   @override

   State<VerificationCodeScreen> createState() =>

         _VerificationCodeScreenState();

}



class _VerificationCodeScreenState

      extends State<VerificationCodeScreen> {

   final List<TextEditingController> controllers =

         List.generate(

      4,

      (index) => TextEditingController(),

   );



   final List<FocusNode> focusNodes =

         List.generate(

      4,

      (index) => FocusNode(),

   );



   bool showError = false;

   bool isVerified = false;



   @override

   void dispose() {

      for (final controller in controllers) {

         controller.dispose();

      }



      for (final node in focusNodes) {

         node.dispose();

      }



      super.dispose();

   }



   // =================================================

   // VERIFY CODE

   // =================================================



   void verifyCode() {

      final code = controllers

            .map((controller) => controller.text)

            .join();



      if (code.length != 4) {

         setState(() {

            showError = true;

            isVerified = false;

         });



         return;

      }



      setState(() {

         showError = false;

         isVerified = true;

      });



      // Frontend sementara:

      // setelah kode lengkap  â€ â€™ masuk Home.

      Future.delayed(

         const Duration(milliseconds: 600),

         () {

            if (!mounted) return;



            Navigator.pushAndRemoveUntil(

               context,

               MaterialPageRoute(

                  builder: (context) =>

                        HomeScreen(),

               ),

               (route) => false,

            );

         },

      );

   }



   // =================================================

   // RESEND CODE

   // =================================================



   void resendCode() {

      for (final controller in controllers) {

         controller.clear();

      }



      setState(() {

         showError = false;

         isVerified = false;

      });



      FocusScope.of(context).requestFocus(

         focusNodes[0],

      );



      ScaffoldMessenger.of(context).showSnackBar(

         const SnackBar(

            content: Text(

               'Kode verifikasi baru telah dikirim.',

            ),

         ),

      );

   }



   // =================================================

   // OTP INPUT

   // =================================================



   void onCodeChanged(

      String value,

      int index,

   ) {

      if (value.length == 1) {

         if (index < 3) {

            FocusScope.of(context).requestFocus(

               focusNodes[index + 1],

            );

         } else {

            FocusScope.of(context).unfocus();

         }

      }



      if (showError) {

         setState(() {

            showError = false;

         });

      }

   }



   // =================================================

   // BACK

   // =================================================



   void goBack() {

      Navigator.pop(context);

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

                           padding:

                                 const EdgeInsets.symmetric(

                              horizontal: 48,

                              vertical: 28,

                           ),

                           child: Column(

                              crossAxisAlignment:

                                    CrossAxisAlignment.start,

                              children: [

                                 // =================================

                                 // LOGO

                                 // =================================



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

                                                            .circular(

                                                   3,

                                                ),

                                             ),

                                             child: const Icon(

                                                Icons.view_in_ar,

                                                size: 15,

                                                color:

                                                      Colors.white,

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

                                                      Color(

                                                   0xFF111111,

                                                ),

                                             ),

                                          ),

                                       ],

                                    ),

                                 ),



                                 const SizedBox(

                                    height: 42,

                                 ),



                                 // =================================

                                 // TITLE

                                 // =================================



                                 const Text(

                                    'Verification Code',

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



                                 const Text(

                                    'Please enter the verification code sent to your\n'

                                    'email address',

                                    style: TextStyle(

                                       fontSize: 10,

                                       height: 1.45,

                                       color:

                                             Color(0xFF444444),

                                    ),

                                 ),



                                 const SizedBox(

                                    height: 5,

                                 ),



                                 // =================================

                                 // EMAIL

                                 // =================================



                                 Text(

                                    widget.email,

                                    style: const TextStyle(

                                       fontSize: 10,

                                       fontWeight:

                                             FontWeight.w600,

                                       color:

                                             Color(0xFF587B55),

                                    ),

                                 ),



                                 const SizedBox(

                                    height: 28,

                                 ),



                                 // =================================

                                 // OTP

                                 // =================================



                                 Row(

                                    mainAxisAlignment:

                                          MainAxisAlignment

                                                .spaceBetween,

                                    children: List.generate(

                                       4,

                                       (index) {

                                          return _otpBox(

                                             index,

                                          );

                                       },

                                    ),

                                 ),



                                 // =================================

                                 // ERROR

                                 // =================================



                                 if (showError)

                                    Padding(

                                       padding:

                                             const EdgeInsets

                                                   .only(

                                          top: 10,

                                          left: 3,

                                       ),

                                       child: Row(

                                          children: [

                                             const Icon(

                                                Icons

                                                      .error_outline,

                                                size: 13,

                                                color:

                                                      Color(

                                                   0xFFFF5964,

                                                ),

                                             ),



                                             const SizedBox(

                                                width: 6,

                                             ),



                                             const Text(

                                                'Kode verifikasi harus terdiri dari 4 digit',

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

                                    height: 20,

                                 ),



                                 // =================================

                                 // RESEND

                                 // =================================



                                 Center(

                                    child: Row(

                                       mainAxisAlignment:

                                             MainAxisAlignment

                                                   .center,

                                       children: [

                                          const Text(

                                             "Didn't receive the code? ",

                                             style:

                                                   TextStyle(

                                                fontSize: 9,

                                                color:

                                                      Color(

                                                   0xFF777777,

                                                ),

                                             ),

                                          ),



                                          GestureDetector(

                                             onTap:

                                                   resendCode,

                                             child:

                                                   const Text(

                                                'Resend Code',

                                                style:

                                                      TextStyle(

                                                   fontSize: 9,

                                                   fontWeight:

                                                         FontWeight

                                                               .w600,

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



                                 const SizedBox(

                                    height: 35,

                                 ),



                                 // =================================

                                 // SUCCESS MESSAGE

                                 // =================================



                                 if (isVerified)

                                    Container(

                                       width:

                                             double.infinity,

                                       margin:

                                             const EdgeInsets

                                                   .only(

                                          bottom: 10,

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

                                                BorderRadius

                                                      .circular(

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



                                             SizedBox(

                                                width: 7,

                                             ),



                                             Text(

                                                'Kode berhasil diverifikasi',

                                                style:

                                                      TextStyle(

                                                   fontSize: 9,

                                                   color:

                                                         Color(

                                                      0xFF179957,

                                                   ),

                                                   fontWeight:

                                                         FontWeight

                                                               .w500,

                                                ),

                                             ),

                                          ],

                                       ),

                                    ),



                                 // =================================

                                 // VERIFY BUTTON

                                 // =================================



                                 SizedBox(

                                    width:

                                          double.infinity,

                                    height: 40,

                                    child:

                                          ElevatedButton(

                                       onPressed:

                                             verifyCode,

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

                                          'Verify',

                                          style:

                                                TextStyle(

                                             fontSize: 12,

                                             fontWeight:

                                                   FontWeight

                                                         .w500,

                                          ),

                                       ),

                                    ),

                                 ),



                                 const SizedBox(

                                    height: 16,

                                 ),



                                 // =================================

                                 // BACK TO LOGIN

                                 // =================================



                                 Center(

                                    child:

                                          GestureDetector(

                                       onTap: goBack,

                                       child:

                                             const Text(

                                          'Back',

                                          style:

                                                TextStyle(

                                             fontSize: 10,

                                             color:

                                                   Color(

                                                0xFF587B55,

                                             ),

                                             fontWeight:

                                                   FontWeight

                                                         .w600,

                                          ),

                                       ),

                                    ),

                                 ),



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



   // =================================================

   // OTP BOX

   // =================================================



   Widget _otpBox(int index) {

      return SizedBox(

         width: 55,

         height: 55,

         child: TextField(

            controller:

                  controllers[index],

            focusNode:

                  focusNodes[index],

            keyboardType:

                  TextInputType.number,

            textAlign:

                  TextAlign.center,

            maxLength: 1,

            style: const TextStyle(

               fontSize: 20,

               fontWeight:

                     FontWeight.w600,

               color:

                     Color(0xFF222222),

            ),

            onChanged: (value) {

               onCodeChanged(

                  value,

                  index,

               );

            },

            decoration:

                  InputDecoration(

               counterText: '',

               filled: true,

               fillColor: Colors.white,

               contentPadding:

                     EdgeInsets.zero,

               border:

                     OutlineInputBorder(

                  borderRadius:

                        BorderRadius.circular(

                     12,

                  ),

                  borderSide:

                        const BorderSide(

                     color:

                           Color(0xFF222222),

                     width: 1,

                  ),

               ),

               enabledBorder:

                     OutlineInputBorder(

                  borderRadius:

                        BorderRadius.circular(

                     12,

                  ),

                  borderSide:

                        const BorderSide(

                     color:

                           Color(0xFF222222),

                     width: 1,

                  ),

               ),

               focusedBorder:

                     OutlineInputBorder(

                  borderRadius:

                        BorderRadius.circular(

                     12,

                  ),

                  borderSide:

                        const BorderSide(

                     color:

                           Color(0xFF5F7D5D),

                     width: 1.5,

                  ),

               ),

               errorBorder:

                     OutlineInputBorder(

                  borderRadius:

                        BorderRadius.circular(

                     12,

                  ),

                  borderSide:

                        const BorderSide(

                     color:

                           Color(0xFFFF5964),

                     width: 1.5,

                  ),

               ),

            ),

         ),

      );

   }

}