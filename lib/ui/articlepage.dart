import 'package:condui_app/Bloc/articlebyslugbloc/article_by_slug_bloc.dart';
import 'package:condui_app/Bloc/deletebloc/delete_bloc.dart';
import 'package:condui_app/model/conduitmodel.dart';
import 'package:condui_app/ui/bottomnavigationar.dart';
import 'package:condui_app/ui/editpage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../intl/appcolor.dart';

class ArticalBySlugPage extends StatefulWidget {
  ArticalBySlugPage({super.key, required this.data});
  static const id = "Articleby_slug_page";
  AllArticlesModel data;

  @override
  State<ArticalBySlugPage> createState() => _ArticalBySlugPageState();
}

class _ArticalBySlugPageState extends State<ArticalBySlugPage> {
  @override
  void initState() {
    getdata();
    titleCtr = TextEditingController(text: widget.data.title);
    bodyCtr = TextEditingController(text: widget.data.body);
    context.read<ArticleBySlugBloc>()
      ..add(
        ArticleBySlugClickedEvent(
          slugdata: widget.data.slug.toString(),
        ),
      );
    super.initState();
  }

  TextEditingController? titleCtr;
  TextEditingController? bodyCtr;

  String? username;

  void getdata() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
  }

  Future refresh() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => refresh(),
      child: Scaffold(
        appBar: AppBar(
          
          backgroundColor: Colors.green,
          title: Text(
            "Details",
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<ArticleBySlugBloc, ArticleBySlugState>(
                listener: (context, state) {
              if (state is ArticleBySlugErrorState) {
                final geterror = state as ArticleBySlugErrorState;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text("${geterror.error}"),
                  ),
                );
              }
              if (state is ArticleBySlugNoInternetState) {
                final mssg = state as ArticleBySlugNoInternetState;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    content: Text("${mssg.mssg}"),
                  ),
                );
              }
            }),
            BlocListener<DeleteBloc, DeleteState>(listener: ((context, state) {
              if (state is DeletedState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: AppColor.conduitgreen,
                    content: Text("${state.mssg}"),
                  ),
                );
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return BottomNavigation(index: 0);
                    },
                  ),
                );
              }
            }))
          ],
          child: BlocBuilder<ArticleBySlugBloc, ArticleBySlugState>(
            builder: (context, state) {
              if (state is ArticleBySlugLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ArticleBySlugErrorState) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      context.read<ArticleBySlugBloc>()
                        ..add(
                          ArticleBySlugClickedEvent(
                            slugdata: widget.data.slug.toString(),
                          ),
                        );
                    },
                    child: Text(
                      "please try again...",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
              if (state is ArticleBySlugNoInternetState) {
                return Center(
                  child: InkWell(
                    onTap: () {
                      context.read<ArticleBySlugBloc>()
                        ..add(
                          ArticleBySlugClickedEvent(
                            slugdata: widget.data.slug.toString(),
                          ),
                        );
                    },
                    child: Text(
                      "please try again...",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }
              if (state is ArticleBySlugSuccessState) {
                final String inputDateString = "${state.articledata.createdAt}";

                final DateFormat inputFormat =
                    DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
                final DateFormat outputFormat = DateFormat.yMd();

                final DateTime dateTime = inputFormat.parse(inputDateString);
                final String formattedDate = outputFormat.format(dateTime);

                final success = state as ArticleBySlugSuccessState;
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${success.articledata.title}",
                          style: TextStyle(
                              letterSpacing: 0.24,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppColor.APiblackcolor),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundImage: NetworkImage(
                                  success.articledata.author!.image!),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${success.articledata.author!.username}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 0.39,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "${formattedDate}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.9,
                                      color: Colors.grey),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 4,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Divider(
                          thickness: 2.4,
                          color: AppColor.figmadevider.withOpacity(0.6),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              weight: 50,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "1850",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17.3,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Icon(
                              Icons.message,
                              color: Colors.grey,
                            ),
                            Spacer(),
                            if (widget.data.author!.username == username)
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return EditPage(
                                            articaldata: widget.data);
                                      },
                                    ),
                                  );
                                },
                                icon: Icon(Icons.edit),
                              ),
                            if (widget.data.author!.username == username)
                              IconButton(
                                onPressed: () {
                                  _deletearticle(context);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Divider(
                          thickness: 2,
                          color: AppColor.figmadevider.withOpacity(0.6),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Text(
                          "${state.articledata.description}",
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "${success.articledata.body}",
                          style: TextStyle(
                              fontSize: 12.5,
                              letterSpacing: 0.9,
                              color: Colors.black.withOpacity(0.6)),
                        ),
                        SizedBox(
                          height: 18,
                        ),
                        Wrap(
                          alignment: WrapAlignment.end,
                          spacing: 8,
                          runSpacing: 8,
                          children: widget.data.tagList!.map((tags) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 4),
                                child: Text(tags),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
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
                    "Are you sure you want to delete article",
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
                              context.read<DeleteBloc>()
                                ..add(
                                  DeleteclickedEvent(
                                    slugdata: widget.data.slug.toString(),
                                  ),
                                );
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
