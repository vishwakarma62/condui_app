import 'package:condui_app/Bloc/articlebyslugbloc/article_by_slug_bloc.dart';
import 'package:condui_app/Bloc/deletebloc/delete_bloc.dart';
import 'package:condui_app/Bloc/editbloc/edit_bloc.dart';
import 'package:condui_app/Bloc/like/liked_bloc.dart';
import 'package:condui_app/repo/allarticlerepo.dart';
import 'package:condui_app/repo/loginrepo.dart';
import 'package:condui_app/ui/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'Bloc/allarticlebloc/bloc/all_article_bloc.dart';
import 'Bloc/createarticle/bloc/creat_article_bloc.dart';
import 'Bloc/favoritebloc/bloc/favourite_bloc.dart';
import 'Bloc/login/bloc/login_bloc.dart';
import 'Bloc/myarticle/bloc/my_article_bloc.dart';
import 'Bloc/profilebloc/bloc/profile_bloc.dart';
import 'Bloc/signupbloc/bloc/sign_up_bloc.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AllArticleBloc(ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(repo: AuthImpl()),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(signUpRepository: AuthImpl()),
        ),
        BlocProvider(
          create: (context) => MyArticleBloc(ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => CreatArticleBloc(ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => FavouriteBloc(ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(repo: ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => LikeBloc(repo: ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => EditBloc(ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => ArticleBySlugBloc(ArticleRepository()),
        ),
        BlocProvider(
          create: (context) => DeleteBloc(ArticleRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: FlutterSmartDialog.init(),
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a blue toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplasgScreen(),
      ),
    );
  }
}
