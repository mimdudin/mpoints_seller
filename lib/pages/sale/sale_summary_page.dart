import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../utils/pallete.dart';
import '../../utils/loading.dart';
import '../../utils/strings.dart';
import '../../services/main_model.dart';
import '../../models/customer.dart';
import '../../models/transaction.dart';
import './sale_employeee_validation.dart';

class SaleSummaryPage extends StatefulWidget {
  final Customer customer;
  final Function showInSnackBar;

  SaleSummaryPage(this.customer, this.showInSnackBar);

  @override
  _SaleSummaryPageState createState() => _SaleSummaryPageState();
}

class _SaleSummaryPageState extends State<SaleSummaryPage> {
  String _scanBarcode = '';
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
              Strings.addEligibleProduct,
              style: TextStyle(color: Pallete.primary),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Pallete.primary),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              _buildCustomerInfo(),
            ],
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: 20),
                model.transactionList == null ||
                        model.transactionList.length == 0
                    ? _buildPriceProductPlaceholder()
                    : _buildPriceProduct(model),
                SizedBox(height: 20),
                _buildScanEligibleProductList(model),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildScanBtn(model),
                      _buildNextBtn(model)
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState(MainModel model) async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes =
          await FlutterBarcodeScanner.scanBarcode("#ff6666", 'Cancel', true);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      print(_scanBarcode);

      model.fetchAvailableEligibleProduct(
          _scanBarcode, model.transactionList.length + 1, showInSnackBar);
    });
  }

  Widget _buildScanEligibleProductList(MainModel model) {
    if (model.transactionList != null) {
      model.transactionList.sort((b, a) => a.id.compareTo(b.id));
    }

    return Expanded(
        child: Container(
      child: model.transactionList == null || model.transactionList.length == 0
          ? Center(
              child: Text('Nothing eligible product list.'),
            )
          : ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 10),
              itemCount: model.transactionList == null
                  ? 0
                  : model.transactionList.length,
              itemBuilder: (context, i) {
                var transaction = model.transactionList[i];
                return _buildCardEligibleProduct(transaction);
              },
            ),
    ));
  }

  Widget _buildCardEligibleProduct(Product transaction) {
    return Container(
      child: Card(
        elevation: 2.0,
        child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Pallete.primary, width: 1.5)),
                          child: Text("${transaction?.id}" ?? "0"),
                        ),
                        Positioned(
                          right: 0,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(color: Colors.white),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  width: 150,
                  child: Text(
                    transaction?.productName ?? "Product Name",
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.subhead.copyWith(
                        fontSize: 16,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Container(
                  width: 100,
                  child: Text('Mp. ${transaction?.mpoints}' ?? 'Mp. 12345678',
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                      style: Theme.of(context)
                          .textTheme
                          .title
                          .copyWith(fontSize: 16, color: Pallete.primary)),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildCustomerInfo() {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "${widget.customer?.firstName} ${widget.customer?.lastName}" ??
                "Unknown",
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(fontSize: 14, color: Pallete.primary),
          ),
          Text(
            "${widget.customer?.customerNumber}" ?? "012345",
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(fontSize: 12, color: Colors.grey[400]),
          )
        ],
      ),
    );
  }

  Widget _buildNextBtn(MainModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 105,
            child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                label: model.isLoadingTransaction
                    ? Image.asset('assets/icons/Right.png',
                        height: 25, color: Pallete.primary)
                    : Image.asset('assets/icons/Right.png', height: 25),
                icon: model.isLoadingTransaction
                    ? LoadingCircular10()
                    : Text(
                        Strings.next,
                        style: Theme.of(context).textTheme.button.copyWith(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
              color: Pallete.primary,
              onPressed: () {
                if (model.transactionList == null ||
                    model.transactionList.length == 0) {
                  showInSnackBar('No eligible product added.');
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              SaleEmployeeValidation(
                                  widget.showInSnackBar,
                                  widget.customer,
                                  model.transactionList
                                      .map((m) => m.mpoints)
                                      .reduce((a, b) => a + b))));
                }
              })),
        ],
      ),
    );
  }

  Widget _buildScanBtn(MainModel model) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: 40,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 105,
            child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                label: model.isLoadingTransaction
                    ? Image.asset('assets/icons/QR.png',
                        height: 25, color: Pallete.primary)
                    : Image.asset('assets/icons/QR.png', height: 25),
                icon: model.isLoadingTransaction
                    ? LoadingCircular10()
                    : Text(
                        Strings.add,
                        style: Theme.of(context).textTheme.button.copyWith(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                color: Pallete.primary,
                onPressed: () => initPlatformState(model)),
          )
        ],
      ),
    );
  }

  Widget _buildPriceProduct(MainModel model) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            "Mp. ${model.transactionList.map((m) => m.mpoints).reduce((a, b) => a + b)}" ??
                "Mp. 12345",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title.copyWith(
                fontSize: 18,
                color: Pallete.primary,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1),
          Container(
            alignment: Alignment.center,
            height: 1.5,
            width: 100,
            color: Colors.grey[400],
          ),
          SizedBox(height: 2),
          Text(
            Strings.pointsTotal,
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(fontSize: 12, color: Colors.black45),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceProductPlaceholder() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Mp. 0',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title.copyWith(
                fontSize: 18,
                color: Pallete.primary,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 1),
          Container(
            alignment: Alignment.center,
            height: 1.5,
            width: 100,
            color: Colors.grey[400],
          ),
          SizedBox(height: 2),
          Text(
            Strings.pointsTotal,
            style: Theme.of(context)
                .textTheme
                .subtitle
                .copyWith(fontSize: 12, color: Colors.black45),
          ),
        ],
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
