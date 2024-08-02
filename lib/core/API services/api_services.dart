import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../features/featured Course/screens/featured_course_screen.dart';

class ApiServices{
  Future<void> login(String emailController,String passwordController,BuildContext context) async {
    // ... Handle login logic using http package

    final response = await http.post(
      Uri.parse(
          'https://test.gslstudent.lilacinfotech.com/api/lead/auth/login'),
      body: jsonEncode({
        'userField': emailController,
        'password': passwordController,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    // print(response.statusCode);
    // Successful login, store access token

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      // print(data);

      final accessToken = data['data']['auth']['access_token'];
      // Store accessToken securely

      print('Login successful: $accessToken');

      Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => FeaturedCourseScreen(
            accessToken: accessToken,
          ),
        ),
        // (route) => false,
      );
    } else {
      final data = jsonDecode(response.body);

    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text(data['message'])));
     }
    ///=====================================///
  }

}



final apiServiceProvider = Provider((ref) => ApiServices() );