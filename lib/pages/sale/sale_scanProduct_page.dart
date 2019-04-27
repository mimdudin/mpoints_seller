import 'package:flutter/material.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../utils/pallete.dart';
import './sale_summary_page.dart';
import '../../utils/my_icons.dart';
import '../../utils/strings.dart';

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class SaleScanProductPage extends StatefulWidget {
  // final MainModel model;
  // final String purchaseAmount;

  // SaleScanProductPage(this.model, this.purchaseAmount);

  @override
  _SaleScanProductPageState createState() => new _SaleScanProductPageState();
}

class _SaleScanProductPageState extends State<SaleScanProductPage>
    with SingleTickerProviderStateMixin {
  var _partNumController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _validate = false;
  String _partnerNumber;
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _partNumController?.dispose();

    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    // return ScopedModelDescendant<MainModel>(
    //   builder: (context, child, model) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Add Eligible Products',
          style: TextStyle(color: Pallete.primary),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Pallete.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Gino Furcy', style: Theme.of(context).textTheme.subhead.copyWith(
                  fontSize: 14, color: Pallete.primary
                ),),
                Text('54545223', style: Theme.of(context).textTheme.subhead.copyWith(
                  fontSize: 12, color: Colors.grey[400]
                ),)
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            // SizedBox(height: 5),
            // _buildBackBtn(context),
            // SizedBox(height: 20),
            // _buildQRandOrLabel('QR scanner'),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              height: 40,
              width: MediaQuery.of(context).size.width / 1.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                child: Text(
                  'scan',
                  // Strings.next,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontSize: 16, color: Colors.white),
                ),
                color: Pallete.primary,
                onPressed: () {
                  initPlatformState();
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
            ),
            SizedBox(height: 40),
            _buildPriceProduct(),
            SizedBox(height: 25),
            _buildQRandOrLabel('Or'),
            SizedBox(height: 25),
            Column(
              children: <Widget>[
                _buildAmountField(),
                SizedBox(height: 30),
                _buildNextBtn()
              ],
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
    //   },
    // );
  }

  Widget _buildPriceProduct() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Rs. 999.999',
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
          Text('Points Total', style: Theme.of(context).textTheme.subtitle.copyWith(
            fontSize: 12, color: Colors.black45
          ),),
        ],
      ),
    );
  }

  Widget _buildQRandOrLabel(String label) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .title
            .copyWith(fontSize: 15, color: Pallete.primary),
      ),
    );
  }

  Widget _buildNextBtn() {
    return Container(
      alignment: Alignment.centerRight,
      height: 40,
      width: MediaQuery.of(context).size.width / 1.3,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Text(
          'next',
          // Strings.next,
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(fontSize: 16, color: Colors.white),
        ),
        color: Pallete.primary,
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SaleSummaryPage()));
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

  // Alert with single button.
  _buildAlert(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: 'invalid partner number',
      //  Strings.invalidPartNumber
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

  Widget _buildAmountField() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      alignment: Alignment.center,
      child: TextField(
        textAlign: TextAlign.center,
        controller: _partNumController,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Pallete.primary),
            ),
            hintText: 'partner number',
            // Strings.enterPartNumber,
            contentPadding: EdgeInsets.symmetric(vertical: 3),
            errorText: _validate ? "Partner Number can't be Empty." : null,
            errorStyle: TextStyle(fontSize: 14, color: Colors.redAccent[200])),
        maxLines: 1,
        keyboardType: TextInputType.number,
        onChanged: (v) {
          setState(() {
            _partnerNumber = v;
            print(v);
          });
        },
      ),
    );
  }

  Widget _buildBackBtn(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 28,
            color: Pallete.primary,
          ),
          onPressed: () => Navigator.pop(context),
        ));
  }

  void showInSnackBar(String message) {
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState
          .showSnackBar(new SnackBar(content: new Text(message)));
    }
  }
}
