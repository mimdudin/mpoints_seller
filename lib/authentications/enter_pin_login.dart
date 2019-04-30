import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../utils/pallete.dart';
import '../utils/strings.dart';
import '../authentications/auth.dart';
import '../home.dart';
import '../authentications/login_page.dart';
import '../utils/loading.dart';
import '../services/main_model.dart';

class EnterPinLogin extends StatefulWidget {
  final Auth auth;
  final VoidCallback onSignedOut, onSignedIn;
  final MainModel model;

  EnterPinLogin({this.auth, this.onSignedOut, this.onSignedIn, this.model});

  @override
  _EnterPinLoginState createState() => _EnterPinLoginState();
}

class _EnterPinLoginState extends State<EnterPinLogin> {
  /// Default max pin length.
  static final int _pinLength = 4;

  /// Control the input text field.
  PinEditingController _pinEditingController =
      PinEditingController(pinLength: _pinLength, autoDispose: false);

  /// Decorate the outside of the Pin.
  PinDecoration _pinDecoration = BoxLooseDecoration(
    strokeColor: Pallete.primary,
    textStyle: _textStyle,
    enteredColor: Pallete.primary,
  );

  /// Default Text style.
  static final TextStyle _textStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
  );

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future loadData() async {
    await widget.auth.currentUser().then((currentUser) {
      widget.model.fetchUserById(currentUser.uid).then((user) {
        if (user.pin == '' && user.name != '')
          _goToLoginPage();
        else if (user.name == '' && user.pin == '') _goToSellerRegistrationPage();
      });
      print(currentUser);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _pinEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      _buildBackground(),
                      _buildLogo(),
                      _buildPINlabel(),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 32),
                    child: model.isLoadingUser
                        ? LoadingCircular25()
                        : _buildPinForm(model),
                  )
                ],
              ),
            ),
          ),
        );
      },
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

  Widget _buildPINlabel() {
    return Container(
      margin: EdgeInsets.only(top: 260),
      alignment: Alignment.center,
      child: Text(
        Strings.enterPIN,
        style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(fontSize: 22, color: Pallete.primary),
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

  Widget _buildPinForm(MainModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: PinInputTextField(
        pinLength: _pinLength,
        decoration: _pinDecoration,
        pinEditingController: _pinEditingController,
        autoFocus: false,
        textInputAction: TextInputAction.go,
        onSubmit: (pin) {
          setState(() {
            if (pin.isEmpty) {
              _buildAlert(context);
              _pinEditingController.clear();
            } else {
              if (pin != model.user.pin) {
                _buildAlert(context);
                _pinEditingController.clear();
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Home(
                              auth: widget.auth,
                              model: widget.model,
                              onSignedOut: widget.onSignedOut,
                            )));
                _pinEditingController.clear();
              }
            }
          });
          debugPrint('submit pin:$pin');
        },
      ),
    );
  }

  // Alert with single button.
  _buildAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: Strings.invalidPIN,
      // desc: Strings.notEnoughMPDesc,
      buttons: [
        DialogButton(
          color: Pallete.primary,
          child: Text(
            "OKAY",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  void _goToLoginPage() {
    Navigator.pushReplacementNamed(context, '/main');
  }

  void _goToSellerRegistrationPage() {
    Navigator.pushReplacementNamed(context, '/seller_registration');
  }
}
