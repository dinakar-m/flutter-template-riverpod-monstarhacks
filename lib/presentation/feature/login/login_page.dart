import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/resources/colors.dart';
import '../../../../constants/resources/images.dart';
import '../../../../constants/routes.dart';
import '../../../../constants/routes.dart';
import '../../common/user_manager.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController =
      TextEditingController(text: UserManager.lecturerEmail);
  final _passwordController = TextEditingController(text: '1111');
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(milliseconds: 500), () {
    //   UserManager.isLoggedIn().then(
    //     (value) => {
    //       // logged in
    //       if (value)
    //         {
    //           debugPrint('login page logged in '),
    //           // context.pushNamed(RouteNames.homeScreen),
    //           // Navigator.of(context).pop(),
    //         }
    //     },
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 100.0),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 32.0),
                TextButton(
                  child: _isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        )
                      : Text('Log In'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                ),
                SizedBox(height: 250.0),
                Text(
                    "Login Info lecturerEmail ${UserManager.lecturerEmail} ${UserManager.volunteerEmail} pass 1111 "),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate a network delay
    await Future.delayed(Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the email and password match
    if ((_emailController.text == UserManager.lecturerEmail ||
            _emailController.text == UserManager.volunteerEmail) &&
        _passwordController.text == '1111') {
      // Save the email to shared preferences
      await prefs!.setString('email', _emailController.text);
      debugPrint('go to home screen');
      context.pushNamed(RouteNames.homeScreen);
      // Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => HomePage()),
      //       );
      // Navigator.of(context).pop();
    } else {
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Incorrect email or password'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }
}
