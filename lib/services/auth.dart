import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_portion/models/userperty.dart';
import 'package:food_portion/services/database.dart';

// auth services
class AuthService {
  // Define instance/object to communicate with firebase auth on back-end for us.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  /* final: not gonna change in the future.
     _auth: this property is private. Only can use in this file & not in another file
  */

  // ***Custom/New User Object***
  // **This is older version (FirebaseUser) works, now just use (User.uid) to access user information.
  // create cUser Object based on (User) <- which is Firebase User Object
  UserPerty? _userFromFirebaseUser(User? user) {
    return user != null ? UserPerty(uid: user.uid) : null;
  }

  // auth change user stream
  // -> onAuthStateChanged is now "authStateChanges()"
  Stream<UserPerty?> get user {
    return _auth.authStateChanges().map((user) => _userFromFirebaseUser(user));
    // map the stream into a stream of users based on our user class by using Map method.
  }

  // Define different methods that gonna interact with firebase auth

  // 1) Sign-in anonymous
  // -> gonna be asynchronous task, return a <Future>.
  Future signInAnony() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      /* Type of Firebase User Object: -> we create "Custom User Object" in user.dart
        *AuthResult* renamed to *UserCredential*.
        *FirebaseUser* renamed to *User*.
      */
      return _userFromFirebaseUser(user!);
    } catch (e) {
      // Catch error message
      print(e.toString());
      return null;
    }
  }

  // 2) Sign-in with email & password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      // await: finish the _auth.signInAnonymously() before assigning to 'result'
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      /* Type of Firebase User Object: -> we create "Custom User Object" in user.dart
        *AuthResult* renamed to *UserCredential*.
        *FirebaseUser* renamed to *User*.
      */
      // Turn "Firebase User" into "Regular User" that we created a class for.
      return _userFromFirebaseUser(user!);
    } catch(e) {
      // Catch error message
      print(e.toString());
      return null;
    }
  }


  // 3) Register with email & password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      // await: finish the _auth.signInAnonymously() before assigning to 'result'
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      /* Type of Firebase User Object: -> we create "Custom User Object" in user.dart
        *AuthResult* renamed to *UserCredential*.
        *FirebaseUser* renamed to *User*.
      */

      // Create a new document for the user with the uid. (pass in 'uid' from the "user" that comes back to us
      // pass in dummy data for the new user
      // integer 100: in conjunction with colors & strength of the colors (run from 100 - 900)
      await DatabaseService(uid: user!.uid).updateUserData('New member', '0', 100);

      // Turn "Firebase User" into "Regular User" that we created a class for.
      return _userFromFirebaseUser(user);
    } catch(e) {
      // Catch error message
      print(e.toString());
      return null;
    }
  }

  // 4) Sign-out - asynchronous task: take time to complete
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Error Signing out: $e');
      return null;
    }
  }
}
