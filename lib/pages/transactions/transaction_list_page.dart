import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../utils/pallete.dart';
import '../../utils/loading.dart';
import '../../utils/strings.dart';
import '../../pages/sale/sale_scanUser_page.dart';
import '../../services/main_model.dart';
import './transaction_item_card.dart';

class TransactionListPage extends StatefulWidget {
  @override
  _TransactionListPageState createState() => _TransactionListPageState();
}

class _TransactionListPageState extends State<TransactionListPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, model) {
        return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              Strings.transactionList,
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
                    '${Strings.transactionList}:',
                    style: Theme.of(context).textTheme.title.copyWith(
                        fontSize: 16,
                        color: Pallete.primary,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 5),
                _buildStatementListView(model),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            elevation: 4.0,
            icon: const Icon(Icons.add),
            backgroundColor: Pallete.primary,
            label: const Text('New Sale'),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          SaleScanUserPage(model, showInSnackBar)));
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        );
      },
    );
  }

  Widget _buildStatementListView(MainModel model) {
    if (model.statementList != null) {
      model.statementList.sort((b, a) => a.id.compareTo(b.id));
    }

    return Expanded(
        child: Container(
      child: model.isLoadingUser
          ? LoadingCircular25()
          : model.statementList == null || model.statementList.length == 0
              ? Center(
                  child: Text('Nothing statements currently.'),
                )
              : ListView.builder(
                  itemCount: model.statementList == null
                      ? 0
                      : model.statementList.length,
                  itemBuilder: (context, i) {
                    var statement = model.statementList[i];
                    return TransactionItemCard(statement);
                  },
                ),
    ));
  }

  void showInSnackBar(String message) {
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState
          .showSnackBar(new SnackBar(content: new Text(message)));
    }
  }
}
