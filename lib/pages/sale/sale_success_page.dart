import 'package:flutter/material.dart';

class SaleSuccessPage extends StatefulWidget {
  @override
  _SaleSuccessPageState createState() => _SaleSuccessPageState();
}

class _SaleSuccessPageState extends State<SaleSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: ListView(
      children: <Widget>[
        SizedBox(height: 40),
        Column(
          children: <Widget>[
            _buildSomeText("Transactions Created!!!", 24),
            SizedBox(height: 10),
            _buildSomeText("Your are success create transactions.", 14),
            SizedBox(height: 60),
            _buildSuccessIcon(),
            SizedBox(height: 30),
            _buildHomeBtn(),
            SizedBox(height: 25),
          ],
        )
      ],
    )));
  }

  Widget _buildSuccessIcon() {
    return Container(
      child: Icon(
        Icons.check_circle_outline,
        color: Color(0xffAD8D0B),
        size: 140,
      ),
    );
  }

  Widget _buildSomeText(String label, double fontSize) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Text(
        label,
        style: Theme.of(context)
            .textTheme
            .subhead
            .copyWith(fontSize: fontSize, color: Color(0xffAD8D0B)),
      ),
    );
  }

  Widget _buildHomeBtn() {
    return Container(
      alignment: Alignment.centerRight,
      height: 40,
      width: MediaQuery.of(context).size.width / 1.8,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
      child: RaisedButton.icon(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(100))),
        icon: Icon(
          Icons.home,
          color: Colors.white,
        ),
        label: Text(
          "Home",
          style: Theme.of(context)
              .textTheme
              .button
              .copyWith(fontSize: 16, color: Colors.white),
        ),
        color: Color(0xffAD8D0B),
        onPressed: () => Navigator.pop(context),
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
            color: Color(0xffAD8D0B),
          ),
          onPressed: () => Navigator.pop(context),
        ));
  }
}
