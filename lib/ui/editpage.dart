import 'package:condui_app/Bloc/allarticlebloc/bloc/all_article_bloc.dart';
import 'package:condui_app/Bloc/articlebyslugbloc/article_by_slug_bloc.dart';
import 'package:condui_app/Bloc/editbloc/edit_bloc.dart';
import 'package:condui_app/intl/appcolor.dart';
import 'package:condui_app/model/conduitmodel.dart';
import 'package:condui_app/ui/articlepage.dart';
import 'package:condui_app/ui/util/massage.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class EditPage extends StatefulWidget {
  EditPage({super.key, required this.articaldata});
  AllArticlesModel articaldata;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  @override
  void initState() {
    context.read<ArticleBySlugBloc>()
      ..add(
        ArticleBySlugClickedEvent(
          slugdata: widget.articaldata.slug.toString(),
        ),
      );
    super.initState();
  }

  bool showinfo = false;
  TextEditingController? titleCtr;
  TextEditingController? aboutCtr;
  TextEditingController? bodyCtr;
  TextEditingController tagCtr = TextEditingController();
  List<String> tags = [];

  void addItem(String item) {
    if (item.isNotEmpty) {
      setState(() {
        tags.add(item);
        tagCtr.clear();
      });
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.conduitgreen,
        centerTitle: true,
        title: Text("Edit Article page"),
      ),
      body: SingleChildScrollView(
        child: MultiBlocListener(
          listeners: [
            BlocListener<EditBloc, EditState>(
              listener: (context, state) {
                if (state is EditLoadingState) {
                  testmassage.showdialogue();
                }
                if (state is EditErrorState) {
                  testmassage.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${state.error}"),
                    ),
                  );
                }
                if (state is EditNoInternetState) {
                  testmassage.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("${state.net}"),
                    ),
                  );
                }
                if (state is EditSuccessState) {
                  testmassage.dismiss();
                 
                  print(state.editedartical.author!.username);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return ArticalBySlugPage(data: state.editedartical);
                  }));
                  context.read<AllArticleBloc>()
                    ..add(
                      AllArticleInitialEvent(),
                    );
                }
              },
            ),
            BlocListener<ArticleBySlugBloc, ArticleBySlugState>(
              listener: (context, state) {
                if (state is ArticleBySlugLoadingState) {
                  testmassage.showdialogue();
                }
                if (state is ArticleBySlugErrorState) {
                  testmassage.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("${state.error}"),
                    ),
                  );
                }
                if (state is ArticleBySlugNoInternetState) {
                  testmassage.dismiss();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text("${state.mssg}"),
                    ),
                  );
                }
                if (state is ArticleBySlugSuccessState) {
                  testmassage.dismiss();
                  titleCtr =
                      TextEditingController(text: state.articledata.title);
                  bodyCtr = TextEditingController(text: state.articledata.body);
                  aboutCtr = TextEditingController(
                      text: state.articledata.description);
                  tags = state.articledata.tagList!;
                }
              },
            ),
          ],
          child: BlocBuilder<ArticleBySlugBloc, ArticleBySlugState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Text(
                              "Title*",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter title";
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(fontSize: 12),
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: titleCtr,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.2)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.2)),
                                    filled: true,
                                    fillColor: AppColor.conduittextfieldcolor,
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.2),
                                    ),
                                    hintText: "Title",
                                    hintStyle: TextStyle(fontSize: 12)),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "About*",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter about yourself";
                                  } else {
                                    return null;
                                  }
                                },
                                style: TextStyle(fontSize: 12),
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: aboutCtr,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.2)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.2)),
                                    filled: true,
                                    fillColor: AppColor.conduittextfieldcolor,
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.2),
                                    ),
                                    hintText: "About",
                                    hintStyle: TextStyle(fontSize: 12)),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Your article*",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter your article";
                                  } else {
                                    return null;
                                  }
                                },
                                maxLines: 3,
                                style: TextStyle(fontSize: 12),
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: bodyCtr,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.2)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.2)),
                                    filled: true,
                                    fillColor: AppColor.conduittextfieldcolor,
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.2),
                                    ),
                                    hintText: "Your Article( in markdown )",
                                    hintStyle: TextStyle(fontSize: 12)),
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            if (showinfo == true)
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColor.conduitgreen),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text("1."),
                                          Expanded(
                                            child: ListTile(
                                              title: Text(
                                                "Start typing the tag you want to create.",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16.0),
                                            child: Text("2."),
                                          ),
                                          Expanded(
                                            child: ListTile(
                                              title: Text(
                                                "After typing the tag, press the 'Done; or 'Next' button on your keyboard.",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 28.0),
                                            child: Text("3."),
                                          ),
                                          Expanded(
                                            child: ListTile(
                                              title: Text(
                                                "The Tag you typed will automatically be converted into a tag and added to the list of tags below the input fields.",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 16.5),
                                            child: Text("4."),
                                          ),
                                          Expanded(
                                            child: ListTile(
                                              title: Text(
                                                "You Can continue typing and creating more tags using the same method.",
                                                style: TextStyle(fontSize: 12),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: tags.map((item) {
                                return Chip(
                                  label: Text(item),
                                  onDeleted: () {
                                    setState(() {
                                      tags.remove(item);
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                            Text(
                              "Tags*",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                onEditingComplete: () {
                                  addItem(tagCtr.text);
                                },
                                style: TextStyle(fontSize: 12),
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: tagCtr,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      highlightColor: Colors.transparent,
                                      splashColor: Colors.transparent,
                                      onPressed: () {
                                        setState(() {
                                          showinfo = !showinfo;
                                        });
                                      },
                                      icon: showinfo
                                          ? SizedBox(
                                              width: 30,
                                              height: 30,
                                              child: Image.asset(
                                                "assets/images/icons8-cross-50.png",
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Icon(Icons.info),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.2)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.2)),
                                    filled: true,
                                    fillColor: AppColor.conduittextfieldcolor,
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.2),
                                    ),
                                    hintText: "Tags",
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
                                    FocusScopeNode currentFocus =
                                        FocusScope.of(context);
                                    if (!currentFocus.hasPrimaryFocus) {
                                      currentFocus.unfocus();
                                    }

                                    if (_formKey.currentState!.validate()) {
                                      context.read<EditBloc>()
                                        ..add(
                                          EditclickedEvent(
                                              editdata: AllArticlesModel(
                                                  tagList: tags,
                                                  description: aboutCtr!.text,
                                                  body: bodyCtr!.text,
                                                  title: titleCtr!.text),
                                              slugdata:
                                                  widget.articaldata.slug!),
                                        );
                                    }
                                  },
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
