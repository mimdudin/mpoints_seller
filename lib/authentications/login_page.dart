import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../utils/phone_input_formatter.dart';
import '../utils/pallete.dart';
import '../utils/strings.dart';
import '../authentications/enter_pin_login.dart';
import '../authentications/signup_page.dart';
// import '../utils/circular_loading.dart';
// import '../pages/terms_privacy_page.dart';
// import './auth.dart';

class LoginPage extends StatefulWidget {
  // final BaseAuth auth;
  // final VoidCallback onSignedIn;

  // LoginPage({this.auth, this.onSignedIn});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                      Container(
                        child: Image.asset(
                          "assets/BG.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      _buildLogo(),
                      Container(
                        margin: EdgeInsets.only(top: 250),
                        alignment: Alignment.center,
                        child: Text(
                          'Sign In',
                          style: Theme.of(context)
                              .textTheme
                              .subhead
                              .copyWith(fontSize: 22, color: Pallete.primary),
                        ),
                      ),
                    ],
                  ),
                  _buildEmailField(),
                  SizedBox(height: 5),
                  _buildPasswordField(),
                  SizedBox(height: 15),
                  _buildSignUpBtn(),
                  SizedBox(height: 25),

                  _buildForgotSignInBtn(),
                  SizedBox(height: 15),

                  // SizedBox(height: 20),
                  _buildLabelTerms(),
                  // SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _validateAndSubmit() async {
  //   if (!_formKey.currentState.validate()) {
  //     return;
  //   }

  //   setState(() {
  //     _isLoading = true;
  //   });

  //   _formKey.currentState.save();

  //   try {
  //     await widget.auth
  //         .createUserWithEmailPassword(
  //             _email, _password, _firstName, _lastName, _phoneNumber, "")
  //         .then((user) {
  //       print("Registered User ${user.uid}");
  //       widget.onSignedIn();

  //       setState(() {
  //         _isLoading = false;
  //       });

  //       Navigator.pop(context);
  //       _firstController.clear();
  //       _lastController.clear();
  //       _phoneController.clear();
  //       _emailController.clear();
  //       _passwordController.clear();
  //     });
  //   } on PlatformException catch (e) {
  //     if (e.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
  //       showInSnackBar("Email address is already use by another account.");
  //       print(e.code);
  //     }
  //     setState(() {
  //       _isLoading = false;
  //     });
  //     print("Error: $e");
  //   }
  // }

  Widget _buildLabelTerms() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          child: Text("Don't have an account? ",
              style:
                  Theme.of(context).textTheme.caption.copyWith(fontSize: 13)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => SignupPage()));
          },
          child: Container(
            child: Text('Sign Up',
                style: TextStyle(
                    fontSize: 15.0,
                    color: Pallete.primary,
                    fontWeight: FontWeight.w500)),
          ),
        )
      ],
    );
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
                    ? CircularProgressIndicator()
                    : Text(
                        'Sign In',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(fontSize: 16, color: Colors.white),
                      ),
                color: Pallete.primary,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EnterPinLogin()));
                } //_validateAndSubmit,
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
              hintText: 'Email',
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
                return 'Please enter valid email.';
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
              hintText: 'Password',
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
                return 'enter password';
              }
            },
            onSaved: (value) => _password = value,
          ),
        ));
  }

  Widget _buildForgotSignInBtn() {
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
            // onTap: _showDialog,
          ),
          // Container(
          //   height: 40,
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(100))),
          //   child: RaisedButton(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(Radius.circular(100))),
          //     child: _isLoading
          //         ? CircularProgressIndicator()
          //         : Text(
          //             Strings.signIn,
          //             style: Theme.of(context)
          //                 .textTheme
          //                 .button
          //                 .copyWith(fontSize: 16, color: Colors.white),
          //           ),
          //     color: Pallete.primary,
          //     // onPressed: _validateAndSubmit,
          //   ),
          // ),
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
}