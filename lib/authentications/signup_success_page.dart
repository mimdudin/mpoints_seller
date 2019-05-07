import 'package:flutter/material.dart';

class SignupSuccessPage extends StatefulWidget {
  final String status;

  SignupSuccessPage(this.status);

  @override
  _SignupSuccessPageState createState() => _SignupSuccessPageState();
}

class _SignupSuccessPageState extends State<SignupSuccessPage> {
  @override
  void initState() {
    super.initState();
    print(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: Container(
              child: ListView(
        children: <Widget>[
          SizedBox(height: 20),
          _buildLogo(),
          SizedBox(height: 40),
          Column(
            children: <Widget>[
              _buildSuccessIcon(),
              SizedBox(height: 40),
              _buildSomeText("Registration Success!!!", 24),
              SizedBox(height: 10),
              _buildSomeText(
                  "Your account under review. We will back on 24 hours.", 14),
              SizedBox(height: 120),
              _buildHomeBtn(),
              SizedBox(height: 25),
            ],
          )
        ],
      ))),
    );
  }

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25),
      alignment: Alignment.centerLeft,
      height: 100,
      child: Image.asset(
        "assets/logo_v2.png",
        fit: BoxFit.cover,
      ),
    );
  }

   Widget _buildSuccessIcon() {
    return Container(
        child: Image.asset(
      'assets/icons/success.png',
      height: 150,
      color: Color(0xffAD8D0B),
    ));
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
        margin: EdgeInsets.symmetric(horizontal: 30),
        // width: MediaQuery.of(context).size.width / 1.8,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
          Container(
            width: 115,
            child: RaisedButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              label: Container(
                // padding: EdgeInsets.only(bottom: 4),
                child: Image.asset('assets/icons/Right.png', height: 25),
              ),
              icon: Text(
                'Finish',
                style: Theme.of(context).textTheme.button.copyWith(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ),
              color: Color(0xffAD8D0B),
              onPressed: () => widget.status == 'HasSignUp'
                  ? _pushReplacementToHome()
                  : _navigatorPop(),
            ),
          )
        ]));
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

  Future<bool> _onWillPop() {
    return widget.status == 'HasSignUp'
        ? Navigator.of(context).pushReplacementNamed('/main')
        : Navigator.pop(context);
  }

  void _navigatorPop() {
    Navigator.pop(context);
  }

  void _pushReplacementToHome() {
    Navigator.of(context).pushReplacementNamed('/main');
  }
}
