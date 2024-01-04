import 'package:flutter/material.dart';
import 'package:prayertime/data/adkar.dart';

class AdkarCard extends StatelessWidget {
  const AdkarCard({super.key, required this.categories, required this.index});
  final List<Map<String, dynamic>> categories;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(categories[index]['category']),
        subtitle: Text('Array Length: ${categories[index]['length']}'),
        onTap: () {
          // Handle tapping on a category (navigate to another screen, etc.)
          int categoryId = categories[index]['id'];
          List<dynamic> categoryArray = AdkarData.getArrayById(categoryId);
          // Do something with the categoryArray
        },
      ),
    );
  }
}
