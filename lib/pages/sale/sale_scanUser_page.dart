import 'package:flutter/material.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import './sale_summary_page.dart';
import '../../utils/pallete.dart';
import '../../utils/my_icons.dart';
import '../../utils/loading.dart';
import '../../utils/strings.dart';
import '../../services/main_model.dart';

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

class SaleScanUserPage extends StatefulWidget {
  final MainModel model;
  final Function showInSnackBar;

  SaleScanUserPage(this.model, this.showInSnackBar);

  @override
  _SaleScanUserPageState createState() => new _SaleScanUserPageState();
}

class _SaleScanUserPageState extends State<SaleScanUserPage>
    with SingleTickerProviderStateMixin {
  QRReaderController controller;
  AnimationController animationController;

  List<CameraDescription> cameras = [];
  Animation<double> verticalPosition;

  var _customerNumController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _validate = false;
  String _customerNumber;

  @override
  void initState() {
    super.initState();

    checkAvailableCamera();
  }

  @override
  void dispose() {
    _customerNumController?.dispose();
    animationController?.stop();
    animationController?.dispose();
    controller?.stopScanning();
    controller?.dispose();
    super.dispose();
  }

  Future<Null> checkAvailableCamera() async {
    // Fetch the available cameras before initializing the app.
    try {
      cameras = await availableCameras();

      if (cameras != null) {
        animationController = new AnimationController(
          vsync: this,
          duration: new Duration(seconds: 3),
        );

        animationController.addListener(() {
          this.setState(() {});
        });
        animationController.forward();
        verticalPosition = Tween<double>(begin: 0.0, end: 300.0).animate(
            CurvedAnimation(parent: animationController, curve: Curves.linear))
          ..addStatusListener((state) {
            if (state == AnimationStatus.completed) {
              animationController.reverse();
            } else if (state == AnimationStatus.dismissed) {
              animationController.forward();
            }
          });

        // pick the first available camera
        onNewCameraSelected(cameras[0]);
      }
    } on QRReaderException catch (e) {
      logError(e.code, e.description);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            Strings.selectCustomer,
            style: TextStyle(color: Pallete.primary),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Pallete.primary),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(LineAwesomeIcons.userAdd, color: Colors.grey),
            ),
          ],
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 40),
              _buildQRScanner(),
              SizedBox(height: 25),
              _buildQRandOrLabel('Or'),
              SizedBox(height: 25),
              Column(
                children: <Widget>[
                  _buildCustomerNumField(),
                  SizedBox(height: 30),
                  _buildNextBtn(model)
                ],
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildQRScanner() {
    return Container(
      height: 300,
      child: Stack(
        children: <Widget>[
          Container(alignment: Alignment.center, child: _cameraPreviewWidget()),
          Center(
            child: Stack(
              children: <Widget>[
                SizedBox(
                  height: 300.0,
                  width: 300.0,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 2.0)),
                  ),
                ),
                Positioned(
                  top: verticalPosition != null ? verticalPosition.value : 0,
                  child: Container(
                    width: 300.0,
                    height: 2.0,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
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

  Widget _buildNextBtn(MainModel model) {
    return Container(
        alignment: Alignment.centerRight,
        margin: EdgeInsets.only(bottom: 20, right: 20),
        width: MediaQuery.of(context).size.width / 1.3,
        height: 40,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(100))),
              child: model.isLoadingCustomer
                  ? LoadingCircular10()
                  : Text(
                      'Next',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(fontSize: 16, color: Colors.white),
                    ),
              color: Pallete.primary,
              onPressed: () {
                setState(() {
                  if (_customerNumController.text.isNotEmpty) {
                    _validate = false;

                    model
                        .fetchAvailableCustomerByNumber(_customerNumber)
                        .then((_) {
                      if (model.customerList.length > 0 &&
                          model.customerList != null) {
                        for (var customer in model.customerList) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SaleSummaryPage(customer, widget.showInSnackBar)));
                        }

                        _customerNumController.clear();
                      } else {
                        _validate = false;

                        _buildAlert(context);
                        _customerNumController.clear();
                      }
                    });
                  } else {
                    _validate = true;
                  }
                });
              },
            ),
          ],
        ));
  }

  // Alert with single button.
  _buildAlert(context) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: Strings.invalidCustomerNumber,
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

  Widget _buildCustomerNumField() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.3,
      alignment: Alignment.center,
      child: TextField(
        textAlign: TextAlign.center,
        controller: _customerNumController,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Pallete.primary),
            ),
            hintText: Strings.enterCustomerNum,
            contentPadding: EdgeInsets.symmetric(vertical: 3),
            errorText: _validate ? Strings.errorCustomerNum : null,
            errorStyle: TextStyle(fontSize: 14, color: Colors.redAccent[200])),
        maxLines: 1,
        keyboardType: TextInputType.number,
        onChanged: (v) {
          setState(() {
            _customerNumber = v;
            print(v);
          });
        },
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return Text(
        Strings.noCamSelected,
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: 1,
        child: new QRReaderPreview(controller),
      );
    }
  }

  void onCodeRead(dynamic value) {
    print(value.toString());
    setState(() {
      widget.model.fetchAvailableCustomer(value.toString()).then((_) {
        if (widget.model.customerList.length > 0 &&
            widget.model.customerList != null) {
          for (var customer in widget.model.customerList) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SaleSummaryPage(customer, widget.showInSnackBar)));
          }

          _customerNumController.clear();
        } else {
          _buildAlert(context);
          _customerNumController.clear();
        }
      });
    });
    // ... do something
    // wait 5 seconds then start scanning again.
    new Future.delayed(const Duration(seconds: 5), controller.startScanning);
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = new QRReaderController(cameraDescription, ResolutionPreset.low,
        [CodeFormat.qr, CodeFormat.pdf417], onCodeRead);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      // if (mounted) setState(() {});
      if (controller.value.hasError) {
        showInSnackBar('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
      if (mounted) {
        setState(() {});
        controller.startScanning();
      }
    } on QRReaderException catch (e) {
      logError(e.code, e.description);
      showInSnackBar('Error: ${e.code}\n${e.description}');
    }
  }

  void showInSnackBar(String message) {
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState
          .showSnackBar(new SnackBar(content: new Text(message)));
    }
  }
}
