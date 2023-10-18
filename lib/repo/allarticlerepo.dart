import 'dart:convert';

import 'package:condui_app/model/profilemodel.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../config/const.dart';
import '../model/conduitmodel.dart';

abstract class Articlerepo {
  Future<List<AllArticlesModel>> allarticlefetchdata();
  Future<dynamic> favourite();
  Future<dynamic> addfavourite(String _slug);
  Future<dynamic> unfavourite(String _slug);
  Future<dynamic> editArticle(AllArticlesModel _articlemodel, String _slug);
  Future<dynamic> deleteArticle(String _slug);
  Future<dynamic> createArticlebyslug(String _slug);
  Future<List<AllArticlesModel>> myarticle();
  Future<dynamic> favouritearticledata();
}

class ArticleRepository extends Articlerepo {
  Future<List<AllArticlesModel>> allarticlefetchdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.getString('token');
    //print(jsontoken);
    http.Response response =
        await http.get(Uri.parse(ApiConstant.allarticle), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jsontoken',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final List<dynamic> data = jsonResponse['articles'];

      return data.map((e) => AllArticlesModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  Future likeArticle(String slug) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    String url = ApiConstant.favfirsturl + slug + "/favorite";
    // print(url);
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${jsontoken}"
      },
    );
    // print(response.body);
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to like article');
    }
  }

  Future removeLikeArticle(String slug) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    String url = ApiConstant.favfirsturl + slug + "/favorite";
    // print(url);
    http.Response response = await http.delete(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${jsontoken}"
      },
    );
    //print(response.body);

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to unlike article');
    }
  }

  @override
  Future<dynamic> createArticlebyslug(String _slug) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.getString('token');

    String url = ApiConstant.favfirsturl + _slug;
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jsontoken',
    });

    if (response.statusCode == 200) {
      dynamic jsonResponse = json.decode(response.body);
     // print(jsonResponse);
      // Parse the JSON response into a map

      dynamic data = jsonResponse['article'];

      // Extract the 'articles' key, which should be a list

      return AllArticlesModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Future deleteArticle(
    String _slug,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    String url = ApiConstant.favfirsturl + _slug;

    //print(_slug);

    http.Response response = await http.delete(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${jsontoken}"
      },
    );

    print(response.body);
    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete article');
    }
  }

  @override
  Future editArticle(
    AllArticlesModel _articlemodel,
    String _slug,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    String url = ApiConstant.favfirsturl + _slug;
    Map<String, dynamic> body = _articlemodel.toJson();

    http.Response response = await http.put(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${jsontoken}"
      },
      body: jsonEncode({'article': body}),
    );

    // dynamic setdata = jsonEncode({'article': body});

    if (response.statusCode == 200) {
      dynamic jsondata = jsonDecode(response.body);
      dynamic data = jsondata['article'];
      return AllArticlesModel.fromJson(data);
    } else {
      throw Exception('Failed to edit article');
    }
  }

  @override
  Future favourite() {
    // TODO: implement favourite
    throw UnimplementedError();
  }

  @override
  Future unfavourite(String _slug) {
    // TODO: implement unfavourite
    throw UnimplementedError();
  }

  @override
  Future<List<AllArticlesModel>> myarticle() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.getString('token');
    dynamic jsonusername = prefs.getString('username');
    //print(jsontoken);
    http.Response response = await http
        .get(Uri.parse(ApiConstant.userarticleurl + jsonusername), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jsontoken',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final List<dynamic> data = jsonResponse['articles'];
      //print(data);

      return data.map((e) => AllArticlesModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Future createArticle(
    AllArticlesModel _articlemodel,
  ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.get('token');

    String url = ApiConstant.addarticleurl;
    Map<String, dynamic> body = _articlemodel.toJson();
    //print(body);

    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "Bearer ${jsontoken}"
      },
      body: jsonEncode({'article': body}),
    );
    dynamic setdata = jsonEncode({'article': body});
    //print(setdata);
    //print(response.body);
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create article');
    }
  }

  @override
  Future favouritearticledata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic jsontoken = prefs.getString('token');
    dynamic jsonusername = prefs.getString('username');
    //(jsonusername);

    http.Response response = await http
        .get(Uri.parse(ApiConstant.favouriteUrl + jsonusername), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $jsontoken',
    });

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);

      final List<dynamic> data = jsonResponse['articles'];
      // print(data);

      return data.map((e) => AllArticlesModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Future<dynamic> getProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic username = prefs.getString('username');
    dynamic tokendata = await prefs.getString('token');
    String url = ApiConstant.baseurl + username;
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $tokendata',
    });
    // http.Response response = await UserClient.instance.doGet(url);
    dynamic jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      //print(response.body);
      // ProfileModel profile = ProfileModel.fromJson(jsonData);
      return ProfileModel.fromJson(jsonData);
    } else {
      throw Exception();
    }
  }

  @override
  Future<dynamic> postProfileData(ProfileModel _profileModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic username = prefs.getString('username');
    String url = ApiConstant.baseurl + username;
    http.Response response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImVtYWlsIjoiYXRhbEBtYWlsaW5hdG9yLmNvbSIsInVzZXJuYW1lIjoiYXRhbCJ9LCJpYXQiOjE2OTU2MTY4MzMsImV4cCI6MTcwMDgwMDgzM30.jhzeBVZQjojRCM3oxm1hYhsMm51xyt8KnhH-BRSPveQ',
    });
    // http.Response response = await UserClient.instance.doGet(url);
    dynamic jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      //print(response.body);
      // ProfileModel profile = ProfileModel.fromJson(jsonData);
      return ProfileModel.fromJson(jsonData);
    } else {
      throw Exception();
    }
  }

  @override
  Future addfavourite(String _slug) {
    // TODO: implement addfavourite
    throw UnimplementedError();
  }

  // @override
  // Future<dynamic> favourite() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   dynamic jsontoken = prefs.getString('token');
  //   dynamic jsonusername = prefs.getString('username');
  //   print(jsonusername);

  //   http.Response response = await http
  //       .get(Uri.parse(ApiConstant.favouriteUrl + jsonusername), headers: {
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer $jsontoken',
  //   });

  //   if (response.statusCode == 200) {
  //     final Map<String, dynamic> jsonResponse = json.decode(response.body);

  //     final List<dynamic> data = jsonResponse['articles'];
  //     print(data);

  //     return data.map((e) => AllArticlesModel.fromJson(e)).toList();
  //   } else {
  //     throw Exception('Failed to fetch data');
  //   }
  // }

  // @override
  // Future addfavourite(String _slug) async {
  //   print(_slug);
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   dynamic jsontoken = prefs.get('token');

  //   http.Response response = await http.post(
  //       Uri.parse(
  //         ApiConstant.favfirsturl + _slug + ApiConstant.favsecondurl,
  //       ),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $jsontoken',
  //       });

  //   return response;
  // }

  // @override
  // Future unfavourite(String _slug) async {
  //   print(_slug);
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   dynamic jsontoken = prefs.get('token');

  //   http.Response response = await http.delete(
  //       Uri.parse(
  //         ApiConstant.favfirsturl + _slug + ApiConstant.favsecondurl,
  //       ),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $jsontoken',
  //       });

  //   return response;
  // }

  // Future likeArticle(String slug) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   dynamic jsontoken = prefs.get('token');

  //   String url = ApiConstant.favfirsturl + slug + "/favorite";
  //   // print(url);
  //   http.Response response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       "content-type": "application/json",
  //       "Authorization": "Bearer ${jsontoken}"
  //     },
  //   );
  //   print(response.body);
  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     throw Exception('Failed to like article');
  //   }
  // }

  // Future removeLikeArticle(String slug) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   dynamic jsontoken = prefs.get('token');

  //   String url = ApiConstant.favfirsturl + slug + "/favorite";
  //   // print(url);
  //   http.Response response = await http.delete(
  //     Uri.parse(url),
  //     headers: {
  //       "content-type": "application/json",
  //       "Authorization": "Bearer ${jsontoken}"
  //     },
  //   );
  //   print(response.body);

  //   if (response.statusCode == 200) {
  //     return true;
  //   } else {
  //     throw Exception('Failed to unlike article');
  //   }
  // }

  // @override
  // Future createArticle(
  //   AllArticlesModel _articlemodel,
  // ) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   dynamic jsontoken = prefs.get('token');

  //   String url = ApiConstant.favfirsturl;
  //   Map<String, dynamic> body = _articlemodel.toJson();
  //   print(body);

  //   http.Response response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       "content-type": "application/json",
  //       "Authorization": "Bearer ${jsontoken}"
  //     },
  //     body: jsonEncode({'article': body}),
  //   );
  //   dynamic setdata = jsonEncode({'article': body});
  //   print(setdata);
  //   print(response.body);
  //   if (response.statusCode == 201) {
  //     return true;
  //   } else {
  //     throw Exception('Failed to create article');
  //   }
  // }
}
