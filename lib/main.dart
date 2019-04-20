import 'package:flutter/material.dart';

import './authentications/signup_page.dart';
import './utils/pallete.dart';
import './authentications/login_page.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MPoints Seller',
       theme: ThemeData(
            primaryColor: Pallete.primary, cursorColor: Pallete.primary),
      home: LoginPage(),
    );
  }
}