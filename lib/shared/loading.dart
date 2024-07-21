import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,  // background color of the page
      child: const Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}
