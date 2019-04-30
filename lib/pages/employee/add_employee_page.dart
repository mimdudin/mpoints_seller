import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../utils/pallete.dart';
import '../../services/main_model.dart';
import '../../utils/loading.dart';
import '../../utils/strings.dart';

class AddEmployeePage extends StatefulWidget {
  final Function showInSnackBar;

  AddEmployeePage(this.showInSnackBar);

  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  var _titleController = TextEditingController();
  var _firstNameController = TextEditingController();
  var _lastNameController = TextEditingController();
  var _pinController = TextEditingController();

  var _titleFocusNode = FocusNode();
  var _firstNameFocusNode = FocusNode();
  var _lastNameFocusNode = FocusNode();
  var _pinFocusNode = FocusNode();

  String _title;
  String _firstName;
  String _lastName;
  String _pin;

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

    _titleController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _pinController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: Text(
                Strings.employeeRegistration,
                style: TextStyle(color: Pallete.primary),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Pallete.primary),
                onPressed: () => Navigator.of(context).pop(),
              ),
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
                                  Strings.basicDetails,
                                  style: TextStyle(
                                      color: Pallete.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        _buildFinishBtn(model),
                      ])),
            ));
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
          .addEmployee(_pin, _firstName, _lastName, _title,
              model.employeeList.length + 1)
          .then((_) {
        Navigator.of(context).pop();

        _titleController.clear();
        _firstNameController.clear();
        _lastNameController.clear();
        _pinController.clear();

        widget.showInSnackBar('$_firstName $_lastName added to Employees');
      });
    } catch (e) {
      debugPrint('ERORR Adding employee: $e');
    }
  }

  Widget _buildTitleField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            autofocus: false,
            controller: _titleController,
            cursorColor: Pallete.primary,
            // style: TextStyle(color: Pallete.primary),
            decoration: InputDecoration(
              hintText: Strings.enterTitle,
              labelText: "${Strings.title}*",
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
            focusNode: _titleFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty) {
                return Strings.errorTitle;
              }
            },
            onSaved: (value) => _title = value,
          ),
        ));
  }

  Widget _buildFirstNameField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            // style: TextStyle(color: Pallete.primary),
            autofocus: false,
            controller: _firstNameController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: Strings.enterFirstName,
              labelText: "${Strings.firstName}*",
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
            focusNode: _firstNameFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty) {
                return Strings.errorFirstName;
              }
            },
            onSaved: (value) => _firstName = value,
          ),
        ));
  }

  Widget _buildLastNameField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
        child: Container(
          child: TextFormField(
            // style: TextStyle(color: Pallete.primary),
            autofocus: false,
            controller: _lastNameController,
            cursorColor: Pallete.primary,
            decoration: InputDecoration(
              hintText: Strings.enterLastName,
              labelText: '${Strings.lastName}*',
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
            focusNode: _lastNameFocusNode,
            keyboardType: TextInputType.text,
            maxLines: 1,
            validator: (value) {
              if (value.isEmpty) {
                return Strings.errorLastName;
              }
            },
            onSaved: (value) => _lastName = value,
          ),
        ));
  }

  Widget _buildPINnumber() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
      child: Container(
        child: TextFormField(
          // style: TextStyle(color: Pallete.primary),
          autofocus: false,
          controller: _pinController,
          cursorColor: Pallete.primary,
          decoration: InputDecoration(
            hintText: Strings.enterPINnumber,
            labelText: '${Strings.pinNumber}*',
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
          focusNode: _pinFocusNode,
          keyboardType: TextInputType.number,
          maxLines: 1,
          validator: (value) {
            if (value.isEmpty || value.length < 4) {
              return Strings.errorPin;
            }
          },
          onSaved: (value) => _pin = value,
        ),
      ),
    );
  }

  Widget _buildFinishBtn(MainModel model) {
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
}
