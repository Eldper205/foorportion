// Wrapper.dart 包装纸
// -> listen for auth changes. 监听授权更改
// -> show either 'Authenticate' or 'Home widget'.

// -> not use "state" directly: Stateless Widget

import 'package:flutter/material.dart';
import 'package:food_portion/models/userperty.dart';
import 'package:food_portion/screens/authenticate/authenticate.dart';
import 'package:food_portion/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // This is for accessing the user data from the <Provider> package
    final user = Provider.of<UserPerty?>(context);

    // return either 'Home' or 'Authenticate' widget.
    // if the user value is (null), we are not logged in - show Authenticate.dart
    // if get the user back, we are logged in - show Home.dart
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
