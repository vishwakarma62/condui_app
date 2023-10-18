import 'package:condui_app/ui/addarticle.dart';
import 'package:condui_app/ui/allarticle.dart';
import 'package:condui_app/ui/profile.dart';
import 'package:condui_app/ui/yourfeed.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../intl/appcolor.dart';

import 'login.dart';
import 'myarticle.dart';

class BottomNavigation extends StatefulWidget {
  BottomNavigation({
    super.key,
    required this.index,
  });
  static const id = "Bottomnavigation_first_index_page";
  var index;

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final PageController _pageController = PageController(initialPage: 0);
  int _pageIndex = 0;
  final List<Map<String, dynamic>> _Pagedetails = [
    {
      'pageName': const AllArticlePage(),
      'title': 'conduit',
      'subtitle': 'A place to share your knowledge'
    },
    {'pageName': const YourFeedPage(), 'title': 'Your Feed', 'subtitle': ''},
    {
      'pageName': const AddArticlePage(),
      'title': 'Add Article',
      'subtitle': ''
    },
  ];

  var _selectedpageindex = 0;
  List<BottomNavigationBarItem> _buildFourItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: SizedBox(
            width: 24,
            child: Image.asset(
              "assets/images/icons8-globe-64.png",
              color: _selectedpageindex == 0 ? AppColor.conduitgreen : null,
            )),
        label: 'Global',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.note,
        ),
        label: 'Your Feed',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.add,
        ),
        label: 'Add',
      ),
    ];
  }

  @override
  void initState() {
    setState(() {
      _selectedpageindex = widget.index;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.green,
        title: Column(
          children: [
            Text(
              _Pagedetails[_selectedpageindex]['title'],
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            Text(
              _Pagedetails[_selectedpageindex]['subtitle'],
              style: TextStyle(fontSize: 12, color: Colors.white),
            )
          ],
        ),
      ),
      body: _Pagedetails[_selectedpageindex]['pageName'],
      drawer: Theme(
        data: ThemeData(backgroundColor: AppColor.conduitscaffoldcolor),
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColor.conduitgreen),
                        color: AppColor.conduitscaffoldcolor,
                        shape: BoxShape.circle),
                    child: Icon(
                      Icons.person,
                      size: 60,
                      color: AppColor.conduitgreen,
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return DemoPage2();
                  }));
                },
                leading: Icon(
                  Icons.person,
                  color: AppColor.conduitgreen,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Profile",
                    style: TextStyle(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MyArticlePage();
                  }));
                },
                leading: Icon(
                  Icons.article_sharp,
                  color: AppColor.conduitgreen,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "My Articles",
                    style: TextStyle(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(),
              ),
              ListTile(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "not developed",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                },
                leading: Icon(
                  Icons.password,
                  color: AppColor.conduitgreen,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Change Password",
                    style: TextStyle(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(),
              ),
              GestureDetector(
                onTap: () {
                  _deletearticle(context);
                  // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content: Column(
                  // children: [
                  //   Text(
                  //     "Are you sure you want to sign out?",
                  //     style: TextStyle(color: Colors.white),
                  //   ),
                  //   SizedBox(
                  //     height: 20,
                  //   ),
                  //   Row(
                  //     children: [
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: AppColor.conduitscaffoldcolor,
                  //           borderRadius: BorderRadius.circular(10),
                  //         ),
                  //         child: Text(
                  //           "Cancel",
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       ),
                  //       Spacer(),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             color: AppColor.conduitscaffoldcolor),
                  //         child: Text(
                  //           "Cancel",
                  //           style: TextStyle(color: Colors.white),
                  //         ),
                  //       )
                  //     ],
                  //   )
                  // ],
                  // )));
                },
                child: ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: AppColor.conduitgreen,
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text(
                      "Sign Out",
                      style: TextStyle(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.green,
        currentIndex: _selectedpageindex,
        onTap: (value) {
          setState(() {
            _selectedpageindex = value;
          });
        },
        items: _buildFourItems(),
      ),
    );
  }

  var log = "islogout";
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('login', log);
  }

  void _deletearticle(BuildContext context) {
    showModalBottomSheet(
        context: (context),
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            //height: 105,
            color: Colors.black,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, left: 20),
                  child: Text(
                    "Are you sure you want to sign out?",
                    style: TextStyle(color: Colors.white.withOpacity(0.8)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: MaterialButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Colors.grey.withOpacity(0.8),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: MaterialButton(
                            onPressed: () {
                              isLoggedIn();
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return LoginPage();
                              }));
                            },
                            child: Text(
                              "Confirm",
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: AppColor.conduitgreen,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}
