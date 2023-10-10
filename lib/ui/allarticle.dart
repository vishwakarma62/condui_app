import 'package:condui_app/Bloc/allarticlebloc/bloc/all_article_bloc.dart';
import 'package:condui_app/model/conduitmodel.dart';
import 'package:condui_app/widget/allarticlewidget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../intl/appcolor.dart';

class AllArticlePage extends StatefulWidget {
  const AllArticlePage({super.key});

  @override
  State<AllArticlePage> createState() => _AllArticlePageState();
}

class _AllArticlePageState extends State<AllArticlePage> {
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
              //final load = state as ConduitLoadedState;
              List<AllArticlesModel> articlelist = state.allarticlemodel;

              if (state.allarticlemodel.isEmpty) {
                return Center(
                  child: Column(children: [
                    Text("No data Found"),
                  ]),
                );
              } else {
                return RefreshIndicator(
                  onRefresh: refreshdata,
                  child: ListView.separated(
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
                      itemCount: articlelist.length),
                );
              }
            }

            return Container();
          },
        ),
      ),
    );
  }
}
