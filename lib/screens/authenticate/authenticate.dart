// Authenticate.dart
// Root Authentication Widget 根身份 验证/认证 小部件
// -> either show 'sign-in widget' or 'register widget'

import 'package:flutter/material.dart';
import 'package:food_portion/screens/authenticate/sign_in.dart';
import 'package:food_portion/screens/authenticate/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  // A state to show either Sign-In widget or Register widget.
  // if it's true, show the Sign-In widget, show Register widget if it's false.
  bool showSignIn = true;
  void toggleView() {  // 切换视图
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    // Do a check
    if (showSignIn) {
      // Pass function to widget
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
