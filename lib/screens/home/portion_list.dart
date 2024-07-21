import 'package:flutter/material.dart';
import 'package:food_portion/models/portion.dart';
// (Provider): access data from a (Stream)
import 'package:provider/provider.dart';
import 'package:food_portion/screens/home/portion_tile.dart';

// File: Outputting the different brews on the page or
//       rather cycling through.

class PortionList extends StatefulWidget {
  const PortionList({Key? key}) : super(key: key);

  @override
  State<PortionList> createState() => _PortionListState();
}

class _PortionListState extends State<PortionList> {
  @override
  Widget build(BuildContext context) {

    // If those (List of Portion) aren't loaded yet, then we're trying to
    // cycle through those same Portion length and performing the function inside (ListView.Builder)
    final portion = Provider.of<List<Portion>>(context) ?? [];
    // print(portion?.docs);

    /* Optional: Create own (Portion Model): when we receive a query snapshot down the stream,
       we can convert that into a (Portion Object). Then when we listen to this stream
       inside our UI widgets then we just receive the portion objects or the list of (Portion Object)
       rather than a (Query Snapshot) everytime.
    */
    // Advantage: easily cycle through those objects & create some kind of template & output the data

    // ForEach method to cycling through and print out each documents.
    // portion.forEach((portion) {
    //   print(portion.name);
    //   print(portion.portionsize);
    //   print(portion.rice);
    // });

    // if (portion != null) {
    //   for (var doc in portion.docs) {
    //     print(doc.data());
    //   }
    // }

    return ListView.builder(
      // how many items are in the list that we wanna cycle through
      itemCount: portion.length,
      // return template or widget tree for each item inside the list
      itemBuilder: (context, index) {
        return PortionTile(foodportion: portion[index]);
      }
    );
  }
}

