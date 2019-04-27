import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/pallete.dart';
import '../utils/strings.dart';
import '../utils/loading.dart';
import './seller_registration.dart';
import './auth.dart';
import './signup_success_page.dart';

class SignupPage extends StatefulWidget {
  final BaseAuth auth;
  // final VoidCallback onSignedIn;

  SignupPage({this.auth});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  var _emailFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();

  String _email;
  String _password;

  bool _obscureText;
  bool _isLoading;

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _obscureText = true;
    _isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Center(
          child: Container(
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      _buildBackground(),
                      _buildBackBtn(context),
                      _buildLogo(),
                      _buildSignUpLabel(),
                    ],
                  ),

                  SizedBox(height: 25),
                  _buildEmailField(),
                  SizedBox(height: 5),
                  _buildPasswordField(),
                  SizedBox(height: 15),
                  _buildSignUpBtn(),
                  // SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateAndSubmit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState.save();

    try {
      await widget.auth
          .createUserWithEmailPassword(_email, _password)
          .then((user) {
        print("Registered User ${user.uid}");
        // widget.onSignedIn();

        setState(() {
          _isLoading = false;
        });

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    SellerRegistration(user.uid, _email, 'NotSignUp')));

        _emailController.clear();
        _passwordController.clear();
      });
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
        showInSnackBar(Strings.emailAlregistered);
        print(e.code);
      }
      setState(() {
        _isLoading = false;
      });
      print("Error: $e");
    }
  }

  Widget _buildBackground() {
    return Container(
      child: Image.asset(
        "assets/BG.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildSignUpLabel() {
    return Container(
      margin: EdgeInsets.only(top: 250),
      alignment: Alignment.center,
      child: Text(
        Strings.signUp,
        style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(fontSize: 22, color: Pallete.primary),
      ),
    );
  }

  Widget _buildBackBtn(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 28,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ));
  }

  Widget _buildSignUpBtn() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        height: 40,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: _isLoading
                    ? LoadingCircular10()
                    : Text(
                        Strings.signUp,
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 16, color: Colors.white),
                      ),
                color: Pallete.primary,
                onPressed: _validateAndSubmit //_validateAndSubmit,
                ),
          ],
        ));
  }

  Widget _buildEmailField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: Strings.email,
              hintStyle: TextStyle(
                  color: Color(0xffb7b7b7),
                  height: 1.5,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
            ),
            focusNode: _emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty ||
                  !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                      .hasMatch(value)) {
                return Strings.validEmail;
              }
            },
            onSaved: (value) => _email = value,
          ),
        ));
  }

  Widget _buildPasswordField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            obscureText: _obscureText,
            autofocus: false,
            controller: _passwordController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: Strings.password,
              hintStyle: TextStyle(
                  color: Color(0xffb7b7b7),
                  height: 1.5,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
              suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                iconSize: 16,
                onPressed: () {
                  // Update the state i.e. toogle the state of passwordVisible variable
                  setState(() {
                    _obscureText ? _obscureText = false : _obscureText = true;
                  });
                },
              ),
            ),
            focusNode: _passwordFocusNode,
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty || value.length < 6) {
                return Strings.minPassword;
              }
            },
            onSaved: (value) => _password = value,
          ),
        ));
  }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(left: 25, right: 25, top: 80),
      alignment: Alignment.center,
      height: 150,
      child: Image.asset(
        "assets/logo_v2.png",
        fit: BoxFit.cover,
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      duration: Duration(seconds: 2),
    ));
  }

  void hideSnackBar() {
    _scaffoldKey.currentState
        .hideCurrentSnackBar(reason: SnackBarClosedReason.timeout);
  }
}
