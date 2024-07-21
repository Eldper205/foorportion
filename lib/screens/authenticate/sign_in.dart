import 'package:flutter/material.dart';
import 'package:food_portion/services/auth.dart';
import 'package:food_portion/shared/constants.dart';
import 'package:food_portion/shared/loading.dart';

class SignIn extends StatefulWidget {
  // Named parameter (constructor) - for SignIn class
  const SignIn({super.key, required this.toggleView});

  // Pass the value from authenticate.dart inside widget itself,
  // instead of inside State.
  final Function toggleView;


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Need define an instance of AuthService class to access services in auth.dart
  final AuthService _auth = AuthService();

  // Register: Define Global Form Key, of type Form State
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  // Initially password is obscure 最初密码是模糊的
  var _isObscured;

  bool loading = false;  // Loading widget: true while we click the button

  @override
  void initState() {
    super.initState();
    _isObscured = true;
  }

  @override
  Widget build(BuildContext context) {
    // Ternary Operator, if true, show loading widget, if false show the scaffold
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0, // remove the dop shadow
        title: Text('Sign In', style: TextStyle(fontSize: 17.0)),
        actions: <Widget>[
          TextButton.icon (
            icon: Icon(Icons.person_2_rounded),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey[600],
            ),
            label: Text('Register', style: TextStyle(fontSize: 14.0)),
            onPressed: () {
              widget.toggleView();
              // this.toggleView(); -> refer to the State Object
            },
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),

        // Form widget: allow to do Form Validation
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Text(
                'Food Portion',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0),
              ),
              SizedBox(height: 10.0),
              Text('Enter your login credential below'),
              SizedBox(height: 30.0),
              // Email
              TextFormField(
                focusNode: emailFocusNode,
                keyboardType: TextInputType.emailAddress,
                decoration: TextInputDecoration,
                validator: (val) {
                  if (val!.isEmpty || !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w]{2,4}').hasMatch(val)) {
                    emailFocusNode.requestFocus();
                    return "Enter a valid email!";
                  }
                },
                // val: represent whatever is in the form field at that point
                // onChanged: every time a user typed something extra into
                //            form field or presses a Delete key or space or something
                //            everytime the value changes this function is gonna run &
                //            get us the value that're currently inside that form field.
                onChanged: (val) {
                  // Track what the user is typing into fields.
                  // Store into local state variable.
                  setState(() {
                    email = val;
                  });
                }
              ),
              SizedBox(height: 20.0),
              // Password
              TextFormField(
                obscureText: _isObscured, // 隐藏字体
                focusNode: passwordFocusNode,
                keyboardType: TextInputType.emailAddress,
                decoration: PasswordInputDecoration.copyWith(
                  suffixIcon: IconButton(
                    icon: _isObscured ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty){
                    passwordFocusNode.requestFocus();
                    return 'Please enter your paswword!';
                  }
                  if (val.length < 6) {
                    passwordFocusNode.requestFocus();
                    return 'Password with six min characters long!';
                  }
                },
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  // Check if our form valid at the point, in which  we click on the button & the function fires
                  if (_formKey.currentState!.validate()) {
                    // currentState -> to get current state of the form
                    // .validate -> validate our form based on its current state

                    // If true: valid form, execute codes like send request into firebase to signup the user
                    // If false: non-valid form, show helper texts to re-type the form field.
                    setState(() {
                      loading = true;  // verify the login credentials
                    });
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      // if get back 'null, update that error
                      setState(() {
                        error = 'Invalid credentials, please check again!';
                        loading = false; // remove loading widget while wrong credentials
                      });
                    }
                  }
                },
                child: Text('Sign In'),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(100, 50), // button width & height
                  backgroundColor: Colors.black, // background color
                  // foregroundColor: Colors.amber, // text color 前景
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),

        /* *** Sign-in Anonymously ***
        child: ElevatedButton(
          child: Text('Sign In Anony'),
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(120, 50),
          ),
          onPressed: () async {
            // perform an asynchronous task
            dynamic result = await _auth.signInAnony();
            // _auth: define in the early of this class
            if (result == null) {
              // login hasn't worked
              print('Error signing in');
            } else {
              // worked
              print('Signed in');
              print(result.uid);
            }
          },
        ),
        *** Sign-in Anonymously - end *** */
      ),
    );
  }
}