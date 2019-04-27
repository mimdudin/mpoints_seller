import 'package:flutter/material.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../utils/pallete.dart';
import '../../utils/strings.dart';
// import '../authentications/auth.dart';
// import '../home.dart';
// import '../authentications/login_page.dart';
import '../../utils/loading.dart';
import '../../services/main_model.dart';
import './sale_success_page.dart';

class SaleEmployeeValidation extends StatefulWidget {
  final Function showInSnackBar;
  final String customerName;

  SaleEmployeeValidation(this.showInSnackBar, this.customerName);

  @override
  _SaleEmployeeValidationState createState() => _SaleEmployeeValidationState();
}

class _SaleEmployeeValidationState extends State<SaleEmployeeValidation> {
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
                      _buildBackBtn(context),
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
      margin: EdgeInsets.only(top: 250),
      alignment: Alignment.center,
      child: Text(
        Strings.enterEmployeePIN,
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
              if (model.employeeList
                      .where((em) => em.pin == pin)
                      .toList()
                      .length <
                  1) {
                _buildAlert(context);
                _pinEditingController.clear();
              } else {
                model
                    .addTransactionToStatement(
                        model.statementList.length + 1,
                        widget.customerName,
                        model.transactionList
                            .map((m) => m.mpoints)
                            .reduce((a, b) => a + b))
                    .then((_) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();

                  _pinEditingController.clear();
                  model.clearTransactionList();

                  widget.showInSnackBar('Successfully adding transactions.');
                });
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

  Widget _buildBackBtn(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30),
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
}
