import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static String lecturerEmail = 'lecturer@gmail.com';
  static String volunteerEmail = 'volunteer@gmail.com';

  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the email and password match
    prefs!.setString('email', '');
  }

  static Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs!.getString('email');

    return email != null && email.isNotEmpty;
  }

  static Future<bool> isLecturerLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');

    debugPrint('isLecturerLoggedIn $email ${email == lecturerEmail}');

    return email == lecturerEmail;
  }
}
