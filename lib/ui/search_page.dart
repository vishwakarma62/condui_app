import 'package:condui_app/model/conduitmodel.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key, required this.articleitemlist});
  List<AllArticlesModel> articleitemlist;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<AllArticlesModel> filterdata = [];
  void search(String query) {
    setState(() {
      filterdata = widget.articleitemlist
          .where((article) => article.tagList!
              .any((tag) => tag.toLowerCase().contains(query.toLowerCase())))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              search(value);
            },
          ),
          ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (context, index) {
                return Text("${filterdata[index]}");
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 8,
                );
              },
              itemCount: filterdata.length)
        ],
      ),
    );
  }
}
