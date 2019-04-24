import 'package:flutter/material.dart';

import '../../utils/pallete.dart';

class EmployeeDetailPage extends StatefulWidget {
  @override
  _EmployeeDetailPageState createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Employee Details',
            style: TextStyle(color: Pallete.primary),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Pallete.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          child: Form(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    ExpansionTile(
                      children: <Widget>[
                        _buildTitleField(),
                        _buildFirstNameField(),
                        _buildLastNameField(),
                        _buildPINnumber(),
                        SizedBox(height: 20),
                      ],
                      title: Text(
                        'Basic Details',
                        style: TextStyle(
                            color: Pallete.primary,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                _buildNextBtn(),
              ])),
        ));
  }

  Widget _buildTitleField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            initialValue: 'Mr.',
            enabled: false,
            style: TextStyle(color: Pallete.primary),
            decoration: InputDecoration(
              hintText: 'enter title employee',
              labelText: 'Title',
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

  Widget _buildFirstNameField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            enabled: false,
            initialValue: 'Gino',
            style: TextStyle(color: Pallete.primary),
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: 'enter first name',
              labelText: 'First Name',
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

  Widget _buildLastNameField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            enabled: false,
            initialValue: 'Furcy',
            style: TextStyle(color: Pallete.primary),
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: 'enter last name',
              labelText: 'Last Name',
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

  Widget _buildPINnumber() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            enabled: false,
            initialValue: '252352',
            style: TextStyle(color: Pallete.primary),
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: 'enter pin number',
              labelText: 'PIN Number',
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

  Widget _buildNextBtn() {
    return Container(
      alignment: Alignment.centerRight,
      height: 40,
      margin: EdgeInsets.only(bottom: 20, right: 20),
      width: MediaQuery.of(context).size.width / 1.3,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Text(
          'delete',
          // Strings.next,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(fontSize: 16, color: Colors.white),
        ),
        color: Pallete.primary,
        onPressed: () {
          // setState(() {
          //   if (_partNumController.text.isNotEmpty) {
          //     if (widget.model.partnerList
          //             .where(
          //                 (partner) => partner.partnerNumber == _partnerNumber)
          //             .toList()
          //             .length >
          //         0) {
          //       _validate = false;

          //       // var mpoints = int.parse(widget.purchaseAmount) * 10 / 100;
          //       // print(mpoints.toString());

          //       // var socialPoints = int.parse(widget.purchaseAmount) * 1 / 100;
          //       // print(socialPoints.toString());

          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (BuildContext context) => ClaimSummaryPage(
          //                   int.parse(widget.purchaseAmount),
          //                   // mpoints,
          //                   // socialPoints,
          //                   _partnerNumber)));
          //       _partNumController.clear();
          //     } else {
          //       _validate = false;

          //       _buildAlert(context);
          //       _partNumController.clear();
          //     }
          //   } else {
          //     _validate = true;
          //   }
          // });
        },
      ),
    );
  }
}
