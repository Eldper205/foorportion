
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_portion/models/portion.dart';
import 'package:food_portion/models/userperty.dart';

class DatabaseService {

  final String uid;
  // Named Parameter
  DatabaseService ({ required this.uid });

  /* collection reference: if we wanna do something with that collection like
     add/read/updated/remove documents from the collection, we can use this
     collection reference (variable = portionCollection).
  */
  final CollectionReference portionCollection = FirebaseFirestore.instance.collection('foodportion');

  // (Portion List) from (snapshot)
  List<Portion> _portionListFromSnapshot(QuerySnapshot snapshot) {
    // Return a list of portion
    return snapshot.docs.map((doc){  // refer each document as "doc"
      // Return a single portion object
      return Portion(
          name: doc.get('name') ?? '',  // if doesn't exist, give it empty string
          portionsize: doc.get('portionsize') ?? '0',
          rice: doc.get('rice') ?? 0,
          // An interable, convert to to List.
      );
    }).toList();
  }

  // userData from (snapshot)
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        portionsize: snapshot.get('portionsize'),
        rice: snapshot.get('rice'),
    );
  }

  // Set (Streams) to listen to the database.
  // get foodportion stream
  Stream<List<Portion>> get portion {
    return portionCollection.snapshots().map(_portionListFromSnapshot);
  }

  // get user document (Stream)
  Stream<UserData> get userData {
    // get the ID of the user that's logged in
    return portionCollection.doc(uid).snapshots()
        .map(_userDataFromSnapshot);
  }


  /* User signs up and have a unique ID generated by firebase, we gonna take
  that ID to create a new document with that ID inside the collection for that user.
  and add some dummy data to begin with for that user -> name, portion, spicy
  */

  // String - (portion) easier to render on the screen later on than using int
  // int - to conjunction with colors to show a dark or lighter color
  Future<void> updateUserData(String name, String portionsize, int rice) async {
    return await portionCollection.doc(uid).set({
      // pass through a Map
      // Map: represent diff properties and the values inside the firestore document
      // that we creating here or updating
      'name': name,
      'portionsize': portionsize,
      'rice': rice,
    });
  }
}