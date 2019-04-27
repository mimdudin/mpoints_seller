import 'package:flutter/material.dart';
import '../utils/pallete.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingCircular25 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: Pallete.primary,
      size: 25,
    );
  }
}

class LoadingCircular15 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: Pallete.primary,
      size: 15,
    );
  }
}

class LoadingCircular10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      color: Colors.white54,
      size: 10,
    );
  }
}