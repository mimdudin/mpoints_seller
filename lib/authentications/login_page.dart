import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/pallete.dart';
import '../utils/strings.dart';
import '../authentications/enter_pin_login.dart';
import '../utils/loading.dart';
import '../authentications/signup_page.dart';
import '../utils/loading.dart';
import './auth.dart';

class LoginPage extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  LoginPage({this.auth, this.onSignedIn});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _forgotPassController = TextEditingController();

  var _emailFocusNode = FocusNode();
  var _passwordFocusNode = FocusNode();

  String _email;
  String _password;
  String _forgotEmail;

  bool _obscureText;
  bool _isLoading;
  bool _validate;

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _obscureText = true;
    _isLoading = false;
    _validate = false;
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _forgotPassController.dispose();
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
                      _buildLogo(),
                      _buildSignInLabel(),
                    ],
                  ),
                  _buildEmailField(),
                  SizedBox(height: 5),
                  _buildPasswordField(),
                  SizedBox(height: 15),
                  _buildSignInBtn(),
                  SizedBox(height: 25),
                  _buildForgotPass(),
                  SizedBox(height: 15),
                  _buildDontHaveAcc(),
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
          .signInWithEmailAndPassword(_email, _password)
          .then((user) {
        print("Signed In ${user.uid}");
        widget.onSignedIn();

        setState(() {
          _isLoading = false;
        });

        _emailController.clear();
        _passwordController.clear();
      });
    } on PlatformException catch (e) {
      if (e.code == 'ERROR_WRONG_PASSWORD') {
        showInSnackBar(Strings.errorEmailPass);
        print(e.code);
      } else if (e.code == 'ERROR_USER_NOT_FOUND') {
        showInSnackBar(Strings.errorNotUser);
        print(e.code);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildSignInLabel() {
    return Container(
      margin: EdgeInsets.only(top: 250),
      alignment: Alignment.center,
      child: Text(
        Strings.signIn,
        style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(fontSize: 22, color: Pallete.primary),
      ),
    );
  }

  Widget _buildBackground() {
    return Container(
      child: Image.asset(
        "assets/BG.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildDontHaveAcc() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text(Strings.dontHaveAcc,
              style:
                  Theme.of(context).textTheme.caption.copyWith(fontSize: 13)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SignupPage(auth: widget.auth)));
          },
          child: Container(
            child: Text(Strings.signUp,
                style: TextStyle(
                    fontSize: 15.0,
                    color: Pallete.primary,
                    fontWeight: FontWeight.w500)),
          ),
        )
      ],
    );
  }

  Widget _buildSignInBtn() {
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
                        Strings.signIn,
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
                return Strings.validPassword;
              }
            },
            onSaved: (value) => _password = value,
          ),
        ));
  }

  Widget _buildForgotPass() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            child: Text(
              Strings.forgotPass,
              style: Theme.of(context).textTheme.subtitle.copyWith(
                  fontSize: 14,
                  color: Pallete.primary,
                  fontStyle: FontStyle.italic),
            ),
            onTap: _showDialog,
          ),
        ],
      ),
    );
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

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(Strings.resetPassDesc),
            content: Container(
                child: TextField(
              controller: _forgotPassController,
              // focusNode: _forgotFocusNode,
              decoration: InputDecoration(
                  hintStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  hintText: Strings.hintEmail,
                  errorText: _validate ? Strings.validEmail : null),
              onChanged: (v) => _forgotEmail = v,
            )),
            actions: <Widget>[
              // model.isLoading
              //     ? SpinKitFadingCube(
              //         color: Colors.orange,
              //         size: 30,
              //       )
              //     :
              // usually buttons at the bottom of the dialog
              // FlatButton(
              //   child: new Text("CANCEL"),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              // ),
              FlatButton(
                  child: Text(
                    "OK",
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Pallete.primary),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_forgotPassController.text.isEmpty ||
                          !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(_forgotPassController.text)) {
                        _validate = true;
                      } else {
                        _validate = false;

                        print(_forgotEmail);
                        _requestForgotPassword();
                        Navigator.of(context).pop();
                        _forgotPassController.clear();
                      }
                    });
                  })
            ],
          );
        });
  }

  Future<void> _requestForgotPassword() async {
    try {
      await widget.auth.forgotPassword(_forgotEmail);
      showInSnackBar(Strings.requestingPass);
    } catch (e) {
      showInSnackBar(Strings.errorRequestPass);
      print("Error $e");
    }
  }
}
