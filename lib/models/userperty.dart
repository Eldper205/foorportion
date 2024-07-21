// Instead of using "Firebase User Object - (User) &(UserCredential)"
// -> we turn into "Custom User Object"
// -> it contain only the information that we need (email, maybe display name in the future)

class UserPerty {
  // declare properties that user have
  final String uid;

  // Named Parameter - Constructor
  UserPerty({required this.uid});
}

class UserData {

  final String uid;
  final String name;
  final String portionsize;
  final int rice;

  UserData({ required this.uid, required this.name, required this.portionsize, required this.rice});

}
