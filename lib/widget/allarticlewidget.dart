import 'package:condui_app/Bloc/like/liked_bloc.dart';
import 'package:condui_app/Bloc/like/liked_event.dart';
import 'package:condui_app/model/conduitmodel.dart';
import 'package:condui_app/ui/articlepage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../intl/appcolor.dart';

class AllArticlewidget extends StatefulWidget {
  AllArticlewidget({super.key, required this.article});
  AllArticlesModel article;

  @override
  State<AllArticlewidget> createState() => _AllArticlewidgetState();
}

class _AllArticlewidgetState extends State<AllArticlewidget> {
  bool? isfavourite = false;
  late LikeBloc likeBloc;
  // late EditBloc editBloc;
  String tags = '';
  void setdata() {
    for (String itemdata in widget.article.tagList!) {
      setState(() {
        tags = itemdata;
      });
    }
  }

  @override
  void initState() {
    setdata();
    setState(() {
      likeBloc = context.read<LikeBloc>();
      isfavourite = widget.article.favorited;

      // titleCtr = TextEditingController(text: widget.article.title);
      // bodyCtr = TextEditingController(text: widget.article.body);
    });
    super.initState();
  }

  changeLikeState() {
    setState(() {
      isfavourite = !isfavourite!;
      if (isfavourite!) {
        likeBloc.add(LikeArticleEvent(slug: widget.article.slug!));
      } else {
        likeBloc.add(RemoveLikeArticleEvent(slug: widget.article.slug!));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ArticalBySlugPage(
            data: widget.article,
          );
        }));
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage("${widget.article.author!.image}"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${widget.article.author!.username}",
                          style: TextStyle(
                            fontSize: 18,
                            letterSpacing: 0.39,
                            fontWeight: FontWeight.w700,
                            color: AppColor.APiblackcolor,
                          ),
                        ),
                        Text(
                          "${widget.article.updatedAt}",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.9,
                              color: AppColor.ratting),
                        )
                      ],
                    ),
                    Spacer(),
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Text(
                    "${widget.article.title}",
                    //maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.24,
                        color: AppColor.APiblackcolor),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Text(
                    "${widget.article.body}",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: 12.5,
                        // fontWeight: FontWeight.w400,
                        letterSpacing: 0.9,
                        color: AppColor.APitext),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Wrap(
                  alignment: WrapAlignment.start,
                  spacing: 8,
                  runSpacing: 8,
                  children: widget.article.tagList!.map((tags) {
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
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: changeLikeState,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeOut,
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                            scale: animation,
                            child: child,
                          );
                        },
                        child: isfavourite!
                            ? Icon(
                                Icons.favorite,
                                size: 25,
                                color: Colors.green,
                                key: ValueKey<int>(1),
                              )
                            : Icon(
                                Icons.favorite_outline,
                                color: Colors.grey,
                                size: 25,
                                key: ValueKey<int>(2),
                              ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.message,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
