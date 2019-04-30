import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../utils/pallete.dart';
import '../../utils/strings.dart';
import '../../utils/loading.dart';
import '../../models/employee.dart';
import '../../services/main_model.dart';

class EmployeeDetailPage extends StatefulWidget {
  final Employee employee;
  final int i;
  final Function showInSnackbar;

  EmployeeDetailPage(this.employee, this.i, this.showInSnackbar);

  @override
  _EmployeeDetailPageState createState() => _EmployeeDetailPageState();
}

class _EmployeeDetailPageState extends State<EmployeeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                Strings.employeeDetails,
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
                            _buildTitleField(widget.employee),
                            _buildFirstNameField(widget.employee),
                            _buildLastNameField(widget.employee),
                            _buildPINnumber(widget.employee),
                            SizedBox(height: 20),
                          ],
                          title: Text(
                            Strings.basicDetails,
                            style: TextStyle(
                                color: Pallete.primary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    _buildDeleteBtn(model),
                  ])),
            ));
      },
    );
  }

  Widget _buildTitleField(Employee employee) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            initialValue: employee?.title,
            enabled: false,
            style: TextStyle(color: Pallete.primary),
            decoration: InputDecoration(
              // hintText: 'enter title employee',
              labelText: Strings.title,
              // hintStyle: TextStyle(
              //     color: Color(0xffb7b7b7),
              //     height: 1.4,
              //     fontSize: 13.0,
              //     fontWeight: FontWeight.w500),
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

  Widget _buildFirstNameField(Employee employee) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            enabled: false,
            initialValue: employee?.firstName,
            style: TextStyle(color: Pallete.primary),
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              // hintText: 'enter first name',
              labelText: Strings.firstName,
              // hintStyle: TextStyle(
              //     color: Color(0xffb7b7b7),
              //     height: 1.4,
              //     fontSize: 13.0,
              //     fontWeight: FontWeight.w500),
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

  Widget _buildLastNameField(Employee employee) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            enabled: false,
            initialValue: employee?.lastName,
            style: TextStyle(color: Pallete.primary),
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              // hintText: 'enter last name',
              labelText: Strings.lastName,
              // hintStyle: TextStyle(
              //     color: Color(0xffb7b7b7),
              //     height: 1.4,
              //     fontSize: 13.0,
              //     fontWeight: FontWeight.w500),
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

  Widget _buildPINnumber(Employee employee) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            enabled: false,
            initialValue: employee?.pin,
            style: TextStyle(color: Pallete.primary),
            autofocus: false,
            // controller: _emailController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              // hintText: 'enter pin number',
              labelText: Strings.pinNumber,
              // hintStyle: TextStyle(
              //     color: Color(0xffb7b7b7),
              //     height: 1.4,
              //     fontSize: 13.0,
              //     fontWeight: FontWeight.w500),
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

  Widget _buildDeleteBtn(MainModel model) {
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
                  label: model.isLoadingUser
                      ? Image.asset('assets/icons/Delete.png',
                          height: 25, color: Pallete.primary)
                      : Image.asset('assets/icons/Delete.png', height: 25),
                  icon: model.isLoadingUser
                      ? LoadingCircular10()
                      : Text(
                          Strings.delete,
                          style: Theme.of(context).textTheme.button.copyWith(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w400),
                        ),
                  color: Pallete.primary,
                  onPressed: () {
                    model.selectedEmployee(widget.i);
                    model.deleteEmployee().then((_) {
                      Navigator.of(context).pop();
                      widget.showInSnackbar(
                          '${widget.employee.firstName} ${widget.employee.firstName} removed in Employees.');
                    });
                  },
                )),
          ],
        ));
  }
}
