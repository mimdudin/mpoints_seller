import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../services/main_model.dart';
import '../../utils/pallete.dart';
import '../../utils/loading.dart';
import '../../utils/my_icons.dart';
import '../../utils/strings.dart';
import '../../models/employee.dart';
import './employee_detail_page.dart';
import './add_employee_page.dart';

class EmployeeListPage extends StatefulWidget {
  @override
  _EmployeeListPageState createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              Strings.employees,
              style: TextStyle(color: Pallete.primary),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Pallete.primary),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 15),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Strings.employeeList,
                    style: Theme.of(context).textTheme.title.copyWith(
                        fontSize: 16,
                        color: Pallete.primary,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 5),
                _buildEmployeeListView(model),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            elevation: 4.0,
            icon: Container(),
            backgroundColor: Pallete.primary,
            label: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Text('New Employee')),
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        AddEmployeePage(showInSnackBar))),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildEmployeeListView(MainModel model) {
    if (model.employeeList != null) {
      model.employeeList.sort((b, a) => a.id.compareTo(b.id));
    }

    return Expanded(
        child: Container(
      child: model.isLoadingUser
          ? LoadingCircular25()
          : model.employeeList == null || model.employeeList.length == 0
              ? Center(
                  child: Text('Nothing employee currently.'),
                )
              : ListView.builder(
                  itemCount: model.employeeList == null
                      ? 0
                      : model.employeeList.length,
                  itemBuilder: (context, i) {
                    var employee = model.employeeList[i];
                    return _buildEmployeeCard(employee, i);
                  },
                ),
    ));
  }

  Widget _buildEmployeeCard(Employee employee, int i) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) =>
                  EmployeeDetailPage(employee, i, showInSnackBar))),
      child: Container(
        child: Card(
          elevation: 2.0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${employee?.firstName} ${employee?.lastName}",
                    style: Theme.of(context).textTheme.subhead.copyWith(
                        fontSize: 16,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        width: 100,
                        child: Text(
                          Strings.pinNumber,
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              .copyWith(fontSize: 15),
                        )),
                    SizedBox(width: 20),
                    Container(
                      width: 60,
                      child: Text(employee?.pin,
                          overflow: TextOverflow.clip,
                          style: Theme.of(context)
                              .textTheme
                              .title
                              .copyWith(fontSize: 16, color: Pallete.primary)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value),
      duration: Duration(seconds: 2),
    ));
  }

  void hideSnackBar() {
    _scaffoldKey.currentState
        .hideCurrentSnackBar(reason: SnackBarClosedReason.timeout);
  }
}
