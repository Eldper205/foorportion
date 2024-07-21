// Instead of "Query Snapshot" everytime.
// -> we turn into "Food Portion Object"
// -> it contain only the information that we need

class Portion {
  // declare properties that Portion have
  final String name;
  final String portionsize;
  final int rice;

  // Named Parameter - Constructor
  Portion({required this.name, required this.portionsize, required this.rice});
}
