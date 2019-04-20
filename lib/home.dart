import 'package:flutter/material.dart';

import './utils/pallete.dart';
import './utils/my_icons.dart';
import './pages/transaction_list_page.dart';
import './pages/employee_list_page.dart';

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
            _buildWelcomeSeller(),
            _buildLogo(),
            _buildMenu('Transactions', Icons.history, _goToTransactionsPage),
            SizedBox(height: 20),
            _buildMenu('Employees', LineAwesomeIcons.user, _goToEmployeesPage)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) => ClaimPointsPage())),
        tooltip: 'ADD',
        child: Icon(Icons.add, size: 40),
        backgroundColor: Pallete.primary,
      ),
    );
  }

  Widget _buildWelcomeSeller() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'Wellcome Groceries Go',
        style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(fontSize: 24, color: Pallete.primary),
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

  Widget _buildMenu(String title, IconData icon, Function method) {
    return GestureDetector(
      onTap: method,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
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

  void _goToTransactionsPage(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TransactionListPage()));
  }

  void _goToEmployeesPage(){
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EmployeeListPage()));
  }
}
