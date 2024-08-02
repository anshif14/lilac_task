import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lilac_task/common/contants/Palette.dart';
import 'package:lilac_task/common/contants/image_constants.dart';
import 'package:lilac_task/core/API%20services/api_services.dart';
import 'package:lilac_task/features/featured%20Course/screens/featured_course_screen.dart';
import 'package:lilac_task/main.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Future<void> login() async {
  //   // ... Handle login logic using http package
  //
  //   final response = await http.post(
  //     Uri.parse(
  //         'https://test.gslstudent.lilacinfotech.com/api/lead/auth/login'),
  //     body: jsonEncode({
  //       'userField': emailController.text,
  //       'password': passwordController.text,
  //     }),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //
  //   // print(response.statusCode);
  //
  //   // Successful login, store access token
  //
  //   if (response.statusCode == 201) {
  //     final data = jsonDecode(response.body);
  //     // print(data);
  //
  //     final accessToken = data['data']['auth']['access_token'];
  //     // Store accessToken securely
  //     print('Login successful: $accessToken');
  //
  //     Navigator.push(
  //       context,
  //       CupertinoPageRoute(
  //         builder: (context) => FeaturedCourseScreen(
  //           accessToken: accessToken,
  //         ),
  //       ),
  //       // (route) => false,
  //     );
  //   } else {
  //     final data = jsonDecode(response.body);
  //
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(data['message'])));
  //   }
  //
  //   ///=====================================///
  // }

  loginFunc(){
    ref.watch(apiServiceProvider).login(emailController.text, passwordController.text, context);
  }

  bool _rememberMe = false;

  @override
  void initState() {
    emailController.text = 'lead@gmail.com';
    passwordController.text = "1234567";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorPalette.white,
      appBar: AppBar(
        backgroundColor: ColorPalette.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Start with",
                        style: TextStyle(
                            color: ColorPalette.grey1,
                            fontWeight: FontWeight.w700,
                            fontSize: w * 0.08),
                      ),
                      Text(
                        "Lilac Infotech",
                        style: TextStyle(
                            color: ColorPalette.black,
                            fontWeight: FontWeight.w700,
                            fontSize: w * 0.09),
                      ),
                      Text(
                        "Enter your mobile number",
                        style: TextStyle(
                            color: ColorPalette.grey1,
                            fontWeight: FontWeight.w700,
                            fontSize: w * 0.035),
                      ),
                    ],
                  ),
                  Image.asset(
                    ImageConstants.login_design1,
                    height: w * 0.55,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorPalette.grey2)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          hintText: "Email / Phone number",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color:ColorPalette.grey2,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorPalette.grey2)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorPalette.grey2,
                              fontWeight: FontWeight.w400),
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          _rememberMe = value ?? false;
                          setState(() {});
                        },
                      ),
                      const Text(
                        "Remember me",
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorPalette.grey1,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorPalette.primary,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(
                height: h * 0.02,
              ),
              Container(
                  width: w * 0.9,
                  height: h * 0.07,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                          backgroundColor:
                              const WidgetStatePropertyAll(ColorPalette.primary)),
                      onPressed: (){
                        loginFunc();
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: ColorPalette.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ))),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Signup with",
                  style: TextStyle(
                      fontSize: 16,
                      color: ColorPalette.grey1,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                  width: w * 0.9,
                  height: h * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: ColorPalette.white,
                      border: Border.all(color: ColorPalette.grey3)),
                  child: Center(
                    child: Image.asset(
                      ImageConstants.google_signIn,
                      height: w * 0.07,
                    ),
                  ))
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        height: h * 0.07,
        color: ColorPalette.white,
        child: const Column(
          children: [
            Text(
              "By signing up, you agree to our",
              style: TextStyle(
                  color: ColorPalette.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Terms & Conditions",
                    style: TextStyle(
                        color: ColorPalette.secondary, fontWeight: FontWeight.w700)),
                Text(
                  " and ",
                  style: TextStyle(
                      color: ColorPalette.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400),
                ),
                Text("Privacy & Policy",
                    style: TextStyle(
                        color: ColorPalette.secondary, fontWeight: FontWeight.w700)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    // TODO: implement dispose
    super.dispose();
  }
}
