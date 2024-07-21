import 'package:flutter/material.dart';
import 'package:food_portion/models/userperty.dart';
import 'package:food_portion/services/database.dart';
import 'package:food_portion/shared/constants.dart';
import 'package:food_portion/shared/loading.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({Key? key}) : super(key: key);

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  // Define Global Form Key, of type Form State
  final _formKey = GlobalKey<FormState>();
  final List<String> portionsize = ['0', '1', '2', '3', '4'];
  final List<int> rices = [100, 200, 300, 400, 500, 600, 700, 800, 900];

  // form values
  String _currentName = '';
  String _currentPortionSize = '0';
  int _currentRice = 100;

  @override
  Widget build(BuildContext context) {

    // This is for accessing the user data from the <Provider> package
    final user = Provider.of<UserPerty?>(context);

    if (user == null) {
      return Loading();
    }

    // Wrap (Form) with (StreamBuilde r)
    return StreamBuilder<UserData>(
      // (DatabaseService) expect "UID" and use that to find document which matches
      // up to the user who is logged in.
      stream: DatabaseService(uid: user.uid).userData,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          // Store data inside "userData" variable of (UserData Type Object)
          UserData userData = snapshot.data!;
          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your food portion.',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  initialValue: userData.name,
                  keyboardType: TextInputType.emailAddress,
                  decoration: NameInputDecoration,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Please enter a name!";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      _currentName = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                // dropdown
                DropdownButtonFormField(
                  value: userData.portionsize, // value of the dropdown button
                  decoration: NumberInputDecoration,
                  // mapping through this
                  items: portionsize.map((portionsi) {
                    return DropdownMenuItem(
                      value: portionsi, // track selected actual value
                      child: Text('$portionsi portion'),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() {
                      _currentPortionSize = val!;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                Text(
                  'Rice preferences based on color.',
                  style: TextStyle(fontSize: 14.0),
                ),
                // slider
                Slider (  // Slider works with (Double) data type
                  value: (_currentRice.toDouble() != null)
                      ? _currentRice.toDouble()
                      : userData.rice.toDouble(),
                  activeColor:
                  Colors.red[_currentRice.toDouble() != null
                      ? _currentRice.toDouble().toInt()
                      : userData.rice],
                  inactiveColor:
                  Colors.red[_currentRice.toDouble() != null
                      ? _currentRice.toDouble().toInt()
                      : userData.rice],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) {
                    setState(() {
                      _currentRice = val.round(); // .round -> round to int
                    });
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    fixedSize: const Size(100, 55),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  // In future, gonna communicating with firebase to update the record
                  // in firestore.
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentName.isNotEmpty ? _currentName : userData.name,
                        _currentPortionSize.isNotEmpty
                            ? _currentPortionSize
                            : userData.portionsize,
                        _currentRice.toDouble() != null
                            ? _currentRice.toDouble().toInt()
                            : userData.rice,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }

      }
    );
  }
}
