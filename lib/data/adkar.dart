import 'dart:convert';
import 'package:flutter/services.dart';

class AdkarData {
  static List<Map<String, dynamic>> _adkarList = [];

  static Future<void> loadAdkarData() async {
    String adkarJson = await rootBundle.loadString('lib/data/adkar.json');
    List<dynamic> decodedJson = json.decode(adkarJson);

    // Ensure that the decoded JSON is a List<Map<String, dynamic>>
    if (decodedJson is List &&
        decodedJson.every((element) => element is Map<String, dynamic>)) {
      _adkarList = decodedJson.cast<Map<String, dynamic>>();
    } else {
      // Handle the case where the JSON structure is not as expected
      print("Invalid JSON structure");
    }
  }

  static List<Map<String, dynamic>> getCategoriesOrderedByLength() {
    // Sort categories by the length of their "array"
    _adkarList.sort((a, b) => b['array'].length.compareTo(a['array'].length));
    return _adkarList.map((category) {
      return {
        'id': category['id'],
        'category': category['category'],
        'length': category['array'].length,
      };
    }).toList();
  }

  static List<dynamic> getArrayById(int categoryId) {
    // Find the category by id
    Map<String, dynamic> category = _adkarList.firstWhere(
      (category) => category['id'] == categoryId,
      orElse: () => <String, dynamic>{},
    );
    // Return the array if the category is found, otherwise return an empty list
    return category.isEmpty ? [] : category['array'];
  }
}
