import 'package:flutter/material.dart';

import './utils/pallete.dart';
import './utils/my_icons.dart';
import './pages/transactions/transaction_list_page.dart';
import './pages/employee/employee_list_page.dart';
import './pages/sale/sale_scanUser_page.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                _buildWelcomeSeller(),
                _buildLogo(),
                _buildMenu(
                    'Transactions', Icons.history, _goToTransactionsPage, 250.0),
                SizedBox(height: 20),
                _buildMenu(
                    'Employees', LineAwesomeIcons.user, _goToEmployeesPage, 400.0)
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SaleScanUserPage())),
        tooltip: 'ADD',
        child: Icon(Icons.add, size: 40),
        backgroundColor: Pallete.primary,
      ),
    );
  }

  Widget _buildWelcomeSeller() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.center,
      child: Text(
        'Wellcome Groceries Go',
        style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(fontSize: 24, color: Colors.white),
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EmployeeListPage()));
  }
}
