import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../utils/pallete.dart';
import '../authentications/enter_pin_login.dart';
import '../authentications/signup_success_page.dart';
import '../utils/strings.dart';
import '../utils/loading.dart';
import '../utils/my_icons.dart';
import '../services/main_model.dart';

class SellerRegistration extends StatefulWidget {
  final String uid, email, status;

  SellerRegistration(this.uid, this.email, this.status);

  @override
  _SellerRegistrationState createState() => _SellerRegistrationState();
}

class _SellerRegistrationState extends State<SellerRegistration> {
  var _registeredNameController = TextEditingController();
  var _businessNameController = TextEditingController();
  var _businessAddressController = TextEditingController();
  var _businessNumberController = TextEditingController();
  var _mailingAddressController = TextEditingController();
  var _phoneController = TextEditingController();

  var _registeredNameFocusNode = FocusNode();
  var _businessNumberFocusNode = FocusNode();
  var _businessNameFocusNode = FocusNode();
  var _businessAddressFocusNode = FocusNode();
  var _mailingAddressFocusNode = FocusNode();
  var _phoneFocusNode = FocusNode();

  String _registeredName;
  String _businessAddress;
  String _businessName;
  String _businessNumber;
  String _mailingAddress;
  String _phoneNumber;

  bool _isLoading;

  var _formKey = GlobalKey<FormState>();
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _isLoading = false;
  }

  @override
  void dispose() {
    super.dispose();

    _registeredNameController.dispose();
    _businessNameController.dispose();
    _businessNumberController.dispose();
    _phoneController.dispose();
    _businessAddressController.dispose();
    _mailingAddressController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                Strings.sellerRegistration,
                style: TextStyle(color: Pallete.primary),
              ),
              leading:
                  Icon(LineAwesomeIcons.pen, color: Pallete.primary, size: 32),
            ),
            body: Container(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            ExpansionTile(
                              children: <Widget>[
                                _buildRegisteredNameField(),
                                _buildBusinessNameField(),
                                _buildBusinessRegistationNumber(),
                                SizedBox(height: 20),
                              ],
                              title: Text(
                                Strings.businessDetails,
                                style: TextStyle(
                                    color: Pallete.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ExpansionTile(
                              children: <Widget>[
                                _buildPhoneNumber(),
                                _buildBusinessAddress(),
                                _buildMailingAddress(),
                              ],
                              title: Text(
                                Strings.contactDetails,
                                style: TextStyle(
                                    color: Pallete.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      _buildSignUpBtn(context, model),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  void _validateAndSubmit(MainModel model) async {
    if (!_formKey.currentState.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState.save();

    try {
      await model
          .updateProrfile(
              widget.uid,
              _businessAddress,
              widget.email,
              _mailingAddress,
              _businessName,
              _businessNumber,
              _phoneNumber,
              _registeredName)
          .then((_) {
        widget.status == 'HasSignUp' ? _pushReplacement() : _pushRemoveUntil();

        _registeredNameController.clear();
        _businessNameController.clear();
        _businessNumberController.clear();
        _phoneController.clear();
        _businessAddressController.clear();
        _mailingAddressController.clear();
      });
    } catch (e) {
      debugPrint('ERORR UPDATE PROFILE: $e');
    }
  }

  Widget _buildRegisteredNameField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            controller: _registeredNameController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: Strings.enterRegName,
              labelText: Strings.registeredName,
              hintStyle: TextStyle(
                  color: Color(0xffb7b7b7),
                  height: 1.4,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  color: Colors.black54,
                  height: 1.2,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
            ),
            focusNode: _registeredNameFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty) {
                return Strings.errorRegisteredName;
              }
            },
            onSaved: (value) => _registeredName = value,
          ),
        ));
  }

  Widget _buildBusinessNameField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            controller: _businessNameController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: Strings.enterBusinessName,
              labelText: Strings.businessName,
              hintStyle: TextStyle(
                  color: Color(0xffb7b7b7),
                  height: 1.4,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  color: Colors.black54,
                  height: 1.2,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
            ),
            focusNode: _businessNameFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty) {
                return Strings.errorBusinessName;
              }
            },
            onSaved: (value) => _businessName = value,
          ),
        ));
  }

  Widget _buildBusinessRegistationNumber() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            controller: _businessNumberController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: Strings.enterBusinessNumber,
              labelText: Strings.businessNumber,
              hintStyle: TextStyle(
                  color: Color(0xffb7b7b7),
                  height: 1.4,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  color: Colors.black54,
                  height: 1.2,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
            ),
            focusNode: _businessNumberFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty) {
                return Strings.errorBusinessNumber;
              }
            },
            onSaved: (value) => _businessNumber = value,
          ),
        ));
  }

  Widget _buildPhoneNumber() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            controller: _phoneController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              labelText: Strings.phoneNumber,
              labelStyle: TextStyle(
                  color: Colors.black54,
                  height: 1.2,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
              hintStyle: TextStyle(
                  color: Colors.black54,
                  height: 1.5,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
              prefixText: '+230 ',
              prefixStyle: TextStyle(
                  color: Pallete.primary,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            focusNode: _phoneFocusNode,
            keyboardType: TextInputType.number,
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty) {
                return Strings.invalidPhoneNumber;
              }
            },
            // inputFormatters: <TextInputFormatter>[
            //   WhitelistingTextInputFormatter.digitsOnly,
            //   // Fit the validating format.
            //   _phoneNumberFormatter,
            // ],
            onSaved: (value) => _phoneNumber = value,
          ),
        ));
  }

  Widget _buildBusinessAddress() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            controller: _businessAddressController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: Strings.enterBusinessAddress,
              labelText: Strings.businessAddress,
              hintStyle: TextStyle(
                  color: Color(0xffb7b7b7),
                  height: 1.4,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  color: Colors.black54,
                  height: 1.2,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
            ),
            focusNode: _businessAddressFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty) {
                return Strings.errorBusinessAddress;
              }
            },
            onSaved: (value) => _businessAddress = value,
          ),
        ));
  }

  Widget _buildMailingAddress() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            controller: _mailingAddressController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: Strings.enterMailingAddress,
              labelText: Strings.mailingAddress,
              hintStyle: TextStyle(
                  color: Color(0xffb7b7b7),
                  height: 1.4,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
              labelStyle: TextStyle(
                  color: Colors.black54,
                  height: 1.2,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w500),
            ),
            focusNode: _mailingAddressFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty) {
                return Strings.errorMailingAddress;
              }
            },
            onSaved: (value) => _mailingAddress = value,
          ),
        ));
  }

  Widget _buildSignUpBtn(BuildContext context, MainModel model) {
    return Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(bottom: 20, right: 20),
        width: MediaQuery.of(context).size.width / 1.3,
        height: 40,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                width: 115,
                child: RaisedButton.icon(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  label: _isLoading
                      ? Image.asset('assets/icons/Right.png',
                          height: 25, color: Pallete.primary)
                      : Image.asset('assets/icons/Right.png', height: 25),
                  icon: _isLoading
                      ? LoadingCircular10()
                      : Text(
                          Strings.finish,
                          style: Theme.of(context).textTheme.button.copyWith(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                  color: Pallete.primary,
                  onPressed: () => _validateAndSubmit(model),
                )),
          ],
        ));
  }

  void _pushRemoveUntil() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (BuildContext context) =>
                SignupSuccessPage(widget.status)),
        ModalRoute.withName('/main'));
  }

  void _pushReplacement() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => SignupSuccessPage(widget.status)));
  }
}
