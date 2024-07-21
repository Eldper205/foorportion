// Home.dart
// -> wraps the 'Food Portion List' and 'Setting'.
// -> not use "state" directly: Stateless Widget

import 'package:flutter/material.dart';
import 'package:food_portion/models/portion.dart';
import 'package:food_portion/screens/home/settings_form.dart';
import 'package:food_portion/services/auth.dart';
import 'package:food_portion/services/database.dart';
import 'package:provider/provider.dart';
import 'package:food_portion/screens/home/portion_list.dart';


class Home extends StatelessWidget {

  // Define AuthService instance
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    // invoke an in-built function
    void _showSettingsPanel() {
      showModalBottomSheet(context: context, builder: (context) {
        // return a widget tree
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    // Set up (Provider) to wrap this Scaffold
    return StreamProvider<List<Portion>>.value(
      value: DatabaseService(uid: '').portion,
      initialData: [],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Food portion', style: TextStyle(fontSize: 17.0)),
          backgroundColor: Colors.black,
          elevation: 0.0, // elemenate drop shadow

          // actions: expect widget list, represent some buttons appear at the top right.
          actions: <Widget>[
            TextButton.icon(
              onPressed: () async {
                // When this line is complete, our (Stream) gonna get back "null"
                // value, so it was redirect to authenticate.dart.
                await _auth.signOut();
              },  // User (Provider) package to listen to that (Stream)
              icon: Icon(Icons.person_2_rounded),
              label: Text('Logout', style: TextStyle(fontSize: 14.0)),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
              ),
            ),
            TextButton.icon(
              onPressed: ()  {
                // When this line is complete, our (Stream) gonna get back "null"
                // value, so it was redirect to authenticate.dart.
                _showSettingsPanel();
              },  // User (Provider) package to listen to that (Stream)
              icon: Icon(Icons.settings),
              label: Text('Setting', style: TextStyle(fontSize: 14.0)),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
              ),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/food_bg2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: PortionList()
        ),
      ),
    );
  }
}
