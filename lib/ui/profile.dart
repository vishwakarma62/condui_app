import 'package:condui_app/Bloc/profilebloc/bloc/profile_bloc.dart';
import 'package:condui_app/Bloc/profilebloc/bloc/profile_event.dart';
import 'package:condui_app/intl/appcolor.dart';
import 'package:condui_app/ui/util/massage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Bloc/profilebloc/bloc/profile_state.dart';

class DemoPage2 extends StatefulWidget {
  const DemoPage2({super.key});

  @override
  State<DemoPage2> createState() => _DemoPage2State();
}

class _DemoPage2State extends State<DemoPage2> {
  var data;
  TextEditingController? imageCtr;
  TextEditingController? usernameCtr;
  TextEditingController? bioCtr;
  TextEditingController? emailCtr;
  late String imageurl;
  @override
  void initState() {
    context.read<ProfileBloc>()..add(FetchProfileEvent());
    super.initState();
  }

  String? emaildata;
  void getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emaildata = prefs.getString('email');
  }

  String? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: AppColor.conduitgreen,
        title: Text("profile"),
      ),
      backgroundColor: AppColor.conduitscaffoldcolor,
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLoadingState) {
            getdata();
            testmassage.showdialogue();
          }
          if (state is ProfileLoadedState) {
            testmassage.dismiss();

            imageCtr =
                TextEditingController(text: state.profileList.profile!.image);
            usernameCtr = TextEditingController(
                text: state.profileList.profile!.username);
            bioCtr =
                TextEditingController(text: state.profileList.profile!.bio);
            emailCtr = TextEditingController(text: emaildata);
            image = state.profileList.profile!.image;
          }
          if (state is ProfileErrorState) {
            testmassage.dismiss();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "${state.message}",
              ),
            ));
          }
          if (state is ProfileNoInternetState) {
            testmassage.dismiss();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "no internet",
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColor.conduitgreen),
                  ),
                  child: image != null
                      ? ClipOval(
                          child: Image.network(
                            image!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: 40, // Adjust the size as needed
                          color: Colors.grey, // Adjust the color as needed
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: 12),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: imageCtr,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.image,
                          color: AppColor.conduitgreen,
                        ),
                        filled: true,
                        fillColor: AppColor.conduittextfieldcolor,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        contentPadding: EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.2),
                        ),
                        hintText: "Profile photo url",
                        hintStyle: TextStyle(fontSize: 12)),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: 12),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: usernameCtr,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: AppColor.conduitgreen,
                        ),
                        filled: true,
                        fillColor: AppColor.conduittextfieldcolor,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        contentPadding: EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.2),
                        ),
                        hintText: "Username",
                        hintStyle: TextStyle(fontSize: 12)),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    maxLines: 3,
                    style: TextStyle(fontSize: 12),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: bioCtr,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColor.conduittextfieldcolor,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        contentPadding: EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.2),
                        ),
                        hintText: "Bio",
                        hintStyle: TextStyle(fontSize: 12)),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: 12),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailCtr,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: AppColor.conduitgreen,
                        ),
                        filled: true,
                        fillColor: AppColor.conduittextfieldcolor,
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.2)),
                        contentPadding: EdgeInsets.all(12),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.2),
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(fontSize: 12)),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 44,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: AppColor.conduitgreen,
                      ),
                      onPressed: () {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      child: Text(
                        "Save",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
