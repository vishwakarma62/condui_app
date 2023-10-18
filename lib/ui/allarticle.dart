import 'package:condui_app/Bloc/allarticlebloc/bloc/all_article_bloc.dart';
import 'package:condui_app/model/conduitmodel.dart';
import 'package:condui_app/ui/search_page.dart';
import 'package:condui_app/widget/allarticlewidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../intl/appcolor.dart';

class AllArticlePage extends StatefulWidget {
  const AllArticlePage({Key? key});

  @override
  State<AllArticlePage> createState() => _AllArticlePageState();
}

class _AllArticlePageState extends State<AllArticlePage> {
  String searchTag = ''; // Store the search tag

  @override
  void initState() {
    context.read<AllArticleBloc>()..add(AllArticleInitialEvent());
    super.initState();
  }

  Future<void> refreshdata() async {
    context.read<AllArticleBloc>()..add(AllArticleInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.conduitscaffoldcolor,
      body: BlocListener<AllArticleBloc, AllArticleState>(
        listener: (context, state) {
          if (state is AllArticleErrorState) {
            final geterror = state as AllArticleErrorState;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 2),
                content: Text("${geterror.error}")));
          }

          if (state is AllArticleNoInternetState) {
            final net = state as AllArticleNoInternetState;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: Duration(seconds: 2), content: Text("${net.mssg}")));
          }
        },
        child: BlocBuilder<AllArticleBloc, AllArticleState>(
          builder: (context, state) {
            if (state is AllArticleLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is AllArticleNoInternetState) {
              return Center(
                child: InkWell(
                    onTap: () {
                      context.read<AllArticleBloc>()
                        ..add(AllArticleInitialEvent());
                    },
                    child: Container(
                        width: 250,
                        height: 44,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.conduitgreen,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                            child: Text("please connect your internet...")))),
              );
            }
            if (state is AllArticleErrorState) {
              return Center(
                child: InkWell(
                    onTap: () {
                      context.read<AllArticleBloc>()
                        ..add(AllArticleInitialEvent());
                    },
                    child: Container(
                        width: 250,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.conduitgreen),
                        ),
                        child: Center(child: Text("something went wrong...")))),
              );
            }
            if (state is AllArticleSuccessState) {
              List<AllArticlesModel> allArticles = state.allarticlemodel;

              // Apply the search filter
              List<AllArticlesModel> filteredArticles =
                  allArticles.where((article) {
                if (searchTag.isEmpty) {
                  return true; // No filter, return all articles
                }
                // Check if the article has a tag that contains the search tag
                return article.tagList?.any((tag) =>
                        tag.toLowerCase().contains(searchTag.toLowerCase())) ==
                    true;
              }).toList();

              return RefreshIndicator(
                onRefresh: refreshdata,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 18,
                      ),
                      // Add a search input field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: TextField(
                          style: TextStyle(fontSize: 13.5),
                          onChanged: (value) {
                            setState(() {
                              searchTag = value
                                  .toLowerCase(); // Convert the input to lowercase
                            });
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(12),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: "Search by tag...",
                            hintStyle: TextStyle(fontSize: 13.5),
                          ),
                        ),
                      ),
                      if (filteredArticles.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text("No data found"),
                        ),

                      ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return AllArticlewidget(
                            article: filteredArticles[index],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            width: 14,
                          );
                        },
                        itemCount: filteredArticles.length,
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
    );
  }
}
