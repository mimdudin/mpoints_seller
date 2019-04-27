import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './pages/transactions/transaction_list_page.dart';
import './authentications/signup_page.dart';
import './utils/pallete.dart';
import './authentications/seller_registration.dart';
import './services/main_model.dart';
import './authentications/login_page.dart';
import './root_page.dart';
import './authentications/auth.dart';
import './splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MainModel model = new MainModel();

    return ScopedModel(
      model: model,
      child: MaterialApp(
        title: 'MPoints Seller',
        theme: ThemeData(
            primaryColor: Pallete.primary, cursorColor: Pallete.primary),
        home: SplashScreen(),
        routes: {
          '/main': (BuildContext context) =>
              RootPage(model: model, auth: Auth()),
          '/seller_registration': (BuildContext context) =>
              SellerRegistration(model.user?.uid, model.user?.email, 'HasSignUp'),
          '/transactions': (BuildContext context) => TransactionListPage()
        },
      ),
    );
  }
}
