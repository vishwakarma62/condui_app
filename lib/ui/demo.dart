import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

class TagPage extends StatefulWidget {
  const TagPage({super.key});

  @override
  State<TagPage> createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  void change() {
  final String inputDateString = "2023-09-30T10:53:15.965Z";

  final DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
  final DateFormat outputFormat = DateFormat.yMd();

  final DateTime dateTime = inputFormat.parse(inputDateString);
  final String formattedDate = outputFormat.format(dateTime);

  print("Formatted Date and Time: $formattedDate");
}
  List<String> items = [];
  TextEditingController textController = TextEditingController();
  String data = '';
  void sedata() {
  
    for (String itemdata in items) {
      setState(() {
        data = itemdata;
      });
    }
  }

  void addItem(String item) {
    if (item.isNotEmpty) {
      setState(() {
        items.add(item);
        textController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            
             Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items.map((data) {
                return Chip(
                  label: Text(data),
                  onDeleted: () {
                    setState(() {
                      items.remove(data);
                    });
                  },
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
               change();
              },
              child: Text("click"),
            ),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: items.map((item) {
                return Chip(
                  label: Text(item),
                  onDeleted: () {
                    setState(() {
                      items.remove(item);
                    });
                  },
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onEditingComplete: () {
                        addItem(textController.text);
                      },
                      controller: textController,
                      onSubmitted: (text) {
                        addItem(text);
                      },
                      decoration: InputDecoration(
                        labelText: 'Add Item',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
