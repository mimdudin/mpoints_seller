import 'package:flutter/material.dart';

import './authentications/auth.dart';
import './authentications/enter_pin_login.dart';
import './authentications/login_page.dart';
import './services/main_model.dart';

class RootPage extends StatefulWidget {
  final BaseAuth auth;
  final MainModel model;

  RootPage({this.auth, this.model});

  @override
  _RootPageState createState() => _RootPageState();
}

enum AuthStatus { notSignedIn, signedIn }

class _RootPageState extends State<RootPage> {
  AuthStatus _status = AuthStatus.notSignedIn;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userData) {
      setState(() {
        _status =
            userData == null || widget.model.user.pin == '' ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _onSignedIn() {
    setState(() {
      _status = AuthStatus.signedIn;
    });
  }

  void _onSignedOut() {
    // setState(() {
      _status = AuthStatus.notSignedIn;
    // });
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case AuthStatus.notSignedIn:
        return LoginPage(auth: widget.auth, onSignedIn: _onSignedIn);
        break;
      case AuthStatus.signedIn:
        return EnterPinLogin(
            auth: widget.auth, onSignedOut: _onSignedOut, onSignedIn: _onSignedIn, model: widget.model);
        break;
    }
  }
}
