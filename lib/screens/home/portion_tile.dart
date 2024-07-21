import 'package:flutter/material.dart';
import 'package:food_portion/models/portion.dart';

class PortionTile extends StatelessWidget {

  final Portion foodportion;
  PortionTile({ required this.foodportion });

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar( // image on the left
            radius: 25.0,
            // foodportion.rice = 100 lighter, 900 darker (200, 300, so forth)
            backgroundColor: Colors.red[foodportion.rice],
          ),
          title: Text(foodportion.name),
          subtitle: Text('Takes ${foodportion.portionsize} portion size(s)'),
        ),
      ),
    );
  }
}
