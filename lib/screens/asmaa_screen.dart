import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prayertime/widgets/name_card.dart';

Future<List<Map<String, dynamic>>> loadDataFromJson() async {
  String jsonString = await rootBundle.loadString('lib/data/asmaa.json');
  Map<String, dynamic> data = json.decode(jsonString);
  return List<Map<String, dynamic>>.from(data['data']);
}

class NamesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: loadDataFromJson(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Expanded(
            child: CustomScrollView(
              slivers: [
                SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return NameCard(
                        name: snapshot.data![index]["name"],
                        transliteration: snapshot.data![index]
                            ["transliteration"],
                        number: snapshot.data![index]["number"],
                      );
                    },
                    childCount: snapshot.data!.length,
                  ),
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading data'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
