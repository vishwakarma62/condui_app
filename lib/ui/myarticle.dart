import 'package:condui_app/Bloc/favoritebloc/bloc/favourite_bloc.dart';
import 'package:condui_app/Bloc/myarticle/bloc/my_article_bloc.dart';
import 'package:condui_app/Bloc/profilebloc/bloc/profile_bloc.dart';
import 'package:condui_app/Bloc/profilebloc/bloc/profile_event.dart';
import 'package:condui_app/model/conduitmodel.dart';
import 'package:condui_app/ui/util/massage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Bloc/profilebloc/bloc/profile_state.dart';
import '../intl/appcolor.dart';
import '../widget/allarticlewidget.dart';

class MyArticlePage extends StatefulWidget {
  MyArticlePage({
    super.key,
    required,
  });

  @override
  State<MyArticlePage> createState() => _MyArticlePageState();
}

class _MyArticlePageState extends State<MyArticlePage> {
  @override
  void initState() {
    context.read<MyArticleBloc>()..add(MyArticleclickedEvent());
    context.read<ProfileBloc>()..add(FetchProfileEvent());
    super.initState();
  }

  bool myarticle = true;
  String? imageurl;
  String? email;
  String? username;
  String? bio;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.conduitscaffoldcolor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColor.conduitgreen,
          title: Text(
            "Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<ProfileBloc, ProfileState>(
                listener: (context, state) {
                  if (state is ProfileLoadingState) {
                    testmassage.showdialogue();
                  }
                  if (state is ProfileErrorState) {
                    testmassage.dismiss();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text("${state.message}"),
                      ),
                    );
                  }
                  if (state is ProfileNoInternetState) {
                    testmassage.dismiss();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        behavior: SnackBarBehavior.floating,
                        content: Text("No Internet"),
                      ),
                    );
                  }
                  if (state is ProfileLoadedState) {
                    testmassage.dismiss();

                    imageurl = state.profileList.profile!.image;
                    bio = state.profileList.profile!.bio;
                    username = state.profileList.profile!.username;
                  }
                },
                builder: (context, state) {
                  return Container(
                    margin: EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 22.0, left: 12, right: 12),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: AppColor.conduitgreen),
                                ),
                                child: imageurl != null
                                    ? ClipOval(
                                        child: Image.network(
                                          imageurl!,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Icon(
                                        Icons.person,
                                        size: 40, // Adjust the size as needed
                                        color: Colors
                                            .green, // Adjust the color as needed
                                      ),
                              ),
                              Text(
                                username != null ? "$username" : "",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 95,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColor.conduitscaffoldcolor),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    bio != null ? "$bio" : "",
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Row(
                            children: [
                              Spacer(),
                              GestureDetector(
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
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: AppColor.conduitgreen)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.settings),
                                        Text(
                                          "Edit Profile Setting",
                                          style: TextStyle(),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      GestureDetector(
                        onTap: () {
                          context.read<MyArticleBloc>()
                            ..add(MyArticleclickedEvent());
                          setState(() {
                            myarticle = true;
                          });
                        },
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: myarticle ? AppColor.conduitgreen : null,
                            border: Border.all(color: AppColor.conduitgreen),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 35.0),
                            child: Text("My Article"),
                          )),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            myarticle = false;
                            context.read<FavouriteBloc>()
                              ..add(LoadingStartEvent());
                          });
                        },
                        child: Container(
                          height: 24,
                          decoration: BoxDecoration(
                            color: myarticle ? null : AppColor.conduitgreen,
                            border: Border.all(color: AppColor.conduitgreen),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                              child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 25.0),
                            child: Text("Favourite Article"),
                          )),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              myarticle ? myarticleblocbody() : favarticleblocbody(),

              // ListView.separated(
              //     primary: false,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return AllArticlewidget(
              //         article: articlelist[index],
              //       );
              //     },
              //     separatorBuilder: (context, index) {
              //       return Container(
              //         width: 14,
              //       );
              //     },
              //     itemCount: articlelist.length),
            ],
          ),
        ),
      ),
    );
  }

  Widget myarticleblocbody() {
    return BlocConsumer<MyArticleBloc, MyArticleState>(
      listener: (context, state) {
        if (state is MyArticleNoInternetState) {
          testmassage.dismiss();
          Fluttertoast.showToast(
              msg: "${state.mssg}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is MyArticleErrorState) {
          testmassage.dismiss();
          Fluttertoast.showToast(
              msg: "${state.error}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is MyArticleSuccessState) {
          testmassage.dismiss();
        }
      },
      builder: (context, state) {
        if (state is MyArticleLoadingState) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                CircularProgressIndicator(),
              ],
            ),
          );
        }
        if (state is MyArticleSuccessState) {
          List<AllArticlesModel> articlelist = state.allarticle;
          if (state.allarticle.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Text("No data found..."),
                ],
              ),
            );
          } else {
            return ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AllArticlewidget(
                    article: articlelist[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    width: 14,
                  );
                },
                itemCount: articlelist.length);
          }
        }
        if (state is MyArticleErrorState) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                Container(
                  width: 250,
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.conduitgreen),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        context.read<MyArticleBloc>()
                          ..add(MyArticleclickedEvent());
                      },
                      child: Center(
                        child: Text(
                          "something went wrong...",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is MyArticleNoInternetState) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                Container(
                  width: 250,
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.conduitgreen),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        context.read<MyArticleBloc>()
                          ..add(MyArticleclickedEvent());
                      },
                      child: Center(
                        child: Text(
                          "please connect your internet...",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget favarticleblocbody() {
    return BlocConsumer<FavouriteBloc, FavouriteState>(
      listener: (context, state) {
        if (state is FavouriteLoadedState) {
          testmassage.dismiss();
        }
        if (state is FavouriteNoInternetState) {
          testmassage.dismiss();
          Fluttertoast.showToast(
              msg: "${state.net}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
        if (state is FavouriteErrorState) {
          testmassage.dismiss();
          Fluttertoast.showToast(
              msg: "${state.error}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      },
      builder: (context, state) {
        if (state is FavouriteLoadingState) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                CircularProgressIndicator(),
              ],
            ),
          );
        }
        if (state is FavouriteNoInternetState) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                Container(
                  width: 250,
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.conduitgreen),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        context.read<FavouriteBloc>()..add(LoadingStartEvent());
                      },
                      child: Center(
                        child: Text(
                          "please connect you internet...",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is FavouriteErrorState) {
          return Center(
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                ),
                Container(
                  width: 250,
                  height: 44,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.conduitgreen),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        context.read<FavouriteBloc>()..add(LoadingStartEvent());
                      },
                      child: Center(
                        child: Text(
                          "something went wrong...",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is FavouriteLoadedState) {
          List<AllArticlesModel> articlelist = state.favouritedata;

          if (state.favouritedata.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Text("No data found.."),
                ],
              ),
            );
          } else {
            return ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return AllArticlewidget(
                    article: articlelist[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    width: 14,
                  );
                },
                itemCount: articlelist.length);
          }
        }
        return Container();
      },
    );
  }
}
