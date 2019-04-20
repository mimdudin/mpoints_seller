import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../utils/pallete.dart';

class CreatePinSignup extends StatefulWidget {
  @override
  _CreatePinSignupState createState() => _CreatePinSignupState();
}

class _CreatePinSignupState extends State<CreatePinSignup> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              _buildLogo(),
              _buildLabel(),
              _buildPinForm()
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.center,
      height: 100,
      child: Image.asset(
        "assets/logo_v2.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildLabel() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Create PIN',
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(fontSize: 16, color: Pallete.primary),
      ),
    );
  }

  Widget _buildPinForm() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 32),
      child: PinInputTextField(
        pinLength: _pinLength,
        decoration: _pinDecoration,
        pinEditingController: _pinEditingController,
        autoFocus: true,
        textInputAction: TextInputAction.go,
        onSubmit: (pin) {
          debugPrint('submit pin:$pin');
        },
      ),
    );
  }
}
