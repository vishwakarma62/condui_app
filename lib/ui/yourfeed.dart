import 'package:condui_app/intl/appcolor.dart';
import 'package:flutter/material.dart';


class YourFeedPage extends StatefulWidget {
  const YourFeedPage({super.key});

  @override
  State<YourFeedPage> createState() => _YourFeedPageState();
}

class _YourFeedPageState extends State<YourFeedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: AppColor.conduitscaffoldcolor,
      body: Container(
        child: Center(
          child: Text("No articles are here..yet"),
        ),
      ),
    );
  }
}
