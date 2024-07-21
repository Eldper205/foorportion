import 'package:flutter/material.dart';
import 'package:food_portion/models/userperty.dart';
import 'package:food_portion/screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_portion/services/auth.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserPerty?>.value(
      // what stream we want to listen to / what data do we expect to get back
      value: AuthService().user,
      initialData: null, // To provide initialData as null

      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
