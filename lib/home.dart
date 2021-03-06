import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import './utils/pallete.dart';
import './utils/my_icons.dart';
import './pages/transactions/transaction_list_page.dart';
import './pages/employee/employee_list_page.dart';
import './pages/sale/sale_scanUser_page.dart';
import './services/main_model.dart';
import './authentications/auth.dart';
import './utils/strings.dart';

class Home extends StatefulWidget {
  final VoidCallback onSignedOut;
  final MainModel model;
  final Auth auth;
  final String userType;

  Home({this.auth, this.onSignedOut, this.model, this.userType});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    print(widget.userType);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Scaffold(
          key: _scaffoldKey,
          body: Container(
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    _buildBackground(),
                    _buildWelcomeSeller(model),
                    _buildLogo(),
                    _buildMenu(Strings.transactions, Icons.history,
                        _goToTransactionsPage, 250.0),
                    SizedBox(height: 20),
                    _buildMenu(Strings.employees, LineAwesomeIcons.user,
                        _goToEmployeesPage, 400.0)
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SaleScanUserPage(model, showInSnackBar))),
            tooltip: 'ADD',
            child: Icon(Icons.add, size: 40),
            backgroundColor: Pallete.primary,
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

  Widget _buildWelcomeSeller(MainModel model) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 40),
          alignment: Alignment.center,
          child: Text(
            "Welcome ${model.user?.name}",
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(fontSize: 22, color: Colors.white),
          ),
        ),
        Positioned(
          right: 5.0,
          top: 3,
          child: IconButton(
              icon: Icon(
                LineAwesomeIcons.signOut,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {
                _signOut().then((_) {
                  setState(() {
                    model.clearEmployeeList();
                    model.clearStatementList();
                    model.clearTransactionList();
                    model.clearUser();
                  });
                });
              }),
        )
      ],
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

  Widget _buildMenu(String title, IconData icon, Function method, marginTop) {
    return GestureDetector(
      onTap: method,
      child: Container(
        margin: EdgeInsets.only(left: 40, right: 40, top: marginTop),
        height: 130,
        child: Card(
          elevation: 2.0,
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Icon(
                        icon,
                        size: 70,
                        color: Pallete.primary,
                      ),
                    ),
                    SizedBox(width: 20),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        textAlign: TextAlign.left,
                        style: Theme.of(context)
                            .textTheme
                            .subhead
                            .copyWith(fontSize: 30, color: Pallete.primary),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  height: 0.5,
                  decoration: BoxDecoration(color: Pallete.primary),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _goToTransactionsPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => TransactionListPage()));
  }

  void _goToEmployeesPage() {
    if (widget.userType == 'Employee') {
      _buildAlert(context);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => EmployeeListPage()));
    }
  }

  Future<void> _signOut() async {
    try {
      await widget.auth.signOut();
      widget.onSignedOut();
      Navigator.pushReplacementNamed(context, '/main');
    } catch (e) {
      print("Error: $e");
    }
  }

  void showInSnackBar(String message) {
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState
          .showSnackBar(new SnackBar(content: new Text(message)));
    }
  }

  // Alert with single button.
  _buildAlert(context) {
    Alert(
      context: context,
      type: AlertType.error,
      title: Strings.dontHaveAuthorize,
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
}
