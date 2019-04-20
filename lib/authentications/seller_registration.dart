import 'package:flutter/material.dart';

import '../utils/pallete.dart';
import '../authentications/enter_pin_login.dart';

class SellerRegistration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Seller Registration',
          style: TextStyle(color: Pallete.primary),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Pallete.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Form(
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
                'Business Details',
                style: TextStyle(
                    color: Pallete.primary, fontWeight: FontWeight.bold),
              ),
            ),
            ExpansionTile(
              children: <Widget>[
                _buildPhoneNumber(),
                _buildBusinessAddress(),
                _buildMailingAddress(),
              ],
              title: Text(
                'Contact Details',
                style: TextStyle(
                    color: Pallete.primary, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            _buildSignUpBtn(context),
            SizedBox(height: 20),
          ],
        )),
      ),
    );
  }

  Widget _buildRegisteredNameField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: 'enter registered name',
              labelText: 'Registered Name*',
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
            // focusNode: _emailFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            // validator: (value) {
            //   if (value.isEmpty ||
            //       !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            //           .hasMatch(value)) {
            //     return 'Please enter valid email.';
            //   }
            // },
            // onSaved: (value) => _email = value,
          ),
        ));
  }

  Widget _buildBusinessNameField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: 'enter business name',
              labelText: 'Business Name*',
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
            // focusNode: _emailFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            // validator: (value) {
            //   if (value.isEmpty ||
            //       !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            //           .hasMatch(value)) {
            //     return 'Please enter valid email.';
            //   }
            // },
            // onSaved: (value) => _email = value,
          ),
        ));
  }

  Widget _buildBusinessRegistationNumber() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: 'enter registration number',
              labelText: 'Business Registration Number',
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
            // focusNode: _emailFocusNode,
            keyboardType: TextInputType.number,
            maxLines: 1,
            // validator: (value) {
            //   if (value.isEmpty ||
            //       !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            //           .hasMatch(value)) {
            //     return 'Please enter valid email.';
            //   }
            // },
            // onSaved: (value) => _email = value,
          ),
        ));
  }

  Widget _buildPhoneNumber() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: 'enter phone number',
              labelText: 'Phone Number',
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
            // focusNode: _emailFocusNode,
            keyboardType: TextInputType.number,
            maxLines: 1,
            // validator: (value) {
            //   if (value.isEmpty ||
            //       !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            //           .hasMatch(value)) {
            //     return 'Please enter valid email.';
            //   }
            // },
            // onSaved: (value) => _email = value,
          ),
        ));
  }

  Widget _buildBusinessAddress() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: 'enter business address',
              labelText: 'Business Address',
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
            // focusNode: _emailFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            // validator: (value) {
            //   if (value.isEmpty ||
            //       !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            //           .hasMatch(value)) {
            //     return 'Please enter valid email.';
            //   }
            // },
            // onSaved: (value) => _email = value,
          ),
        ));
  }

  Widget _buildMailingAddress() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: 'enter mailing address',
              labelText: 'Mailing Address',
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
            // focusNode: _emailFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            // validator: (value) {
            //   if (value.isEmpty ||
            //       !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            //           .hasMatch(value)) {
            //     return 'Please enter valid email.';
            //   }
            // },
            // onSaved: (value) => _email = value,
          ),
        ));
  }

  Widget _buildSignUpBtn(BuildContext context) {
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
                child:
                    // _isLoading
                    //     ? CircularProgressIndicator()
                    //     :
                    Text(
                  'Finish',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontSize: 16, color: Colors.white),
                ),
                color: Pallete.primary,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EnterPinLogin()));
                } //_validateAndSubmit,
                ),
          ],
        ));
  }
}
