import 'package:condui_app/Bloc/login/bloc/login_bloc.dart';
import 'package:condui_app/intl/appcolor.dart';
import 'package:condui_app/model/authmodel.dart';
import 'package:condui_app/ui/allarticle.dart';
import 'package:condui_app/ui/signuppage.dart';
import 'package:condui_app/ui/util/massage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';



import 'bottomnavigationar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void validation() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return AllArticlePage();
      }));
    }
  }

  var log = "islogin";
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('login', log);
  }

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
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoadingState) {
              testmassage.showdialogue();
            }
            if (state is LoginLoadedState) {
              testmassage.dismiss();
              isLoggedIn();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "${state.msg}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
                elevation: 10,
                backgroundColor: Colors.green,
              ));

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return BottomNavigation(
                  index: 0,
                );
              }));
            }
            if (state is LoginErrorState) {
              testmassage.dismiss();
              emailCtr.clear();
              passwordCtr.clear();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "${state.error}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
                elevation: 10,
                backgroundColor: Colors.red[600],
              ));
            }
            if (state is LoginNoInternetState) {
              testmassage.dismiss();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  "${state.net}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                  ),
                ),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 2),
                elevation: 10,
                backgroundColor: Colors.green,
              ));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 65,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Column(
                        children: [
                          Text(
                            "conduit",
                            style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: AppColor.conduitgreen),
                          ),
                          Text(
                            "A place to share your knowledge.",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Log in to Conduit",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w700),
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                              "Email*",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                style: TextStyle(fontSize: 12),
                                keyboardType: TextInputType.emailAddress,
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: emailCtr,
                                inputFormatters: [
                                  FilteringTextInputFormatter.deny(RegExp(
                                      r'\s')), // Deny whitespace (spaces)
                                ],
                                validator: (value) {
                                  // Check if this field is empty
                                  if (value == null || value.isEmpty) {
                                    return 'Enter email';
                                  }

                                  // using regular expression
                                  if (!RegExp(r'\S+@\S+\.\S+')
                                      .hasMatch(value)) {
                                    return "Please enter a valid email address";
                                  }

                                  // the email is valid
                                  return null;
                                },
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
                                    hintText: "Email",
                                    hintStyle: TextStyle(fontSize: 12)),
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              "Password*",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TextFormField(
                                style: TextStyle(fontSize: 12),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: passwordCtr,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(16),
                                  FilteringTextInputFormatter.deny(RegExp(
                                      r'\s')), // Deny whitespace (spaces)
                                ],
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Enter password";
                                  } else {
                                    return null;
                                  }
                                },
                                obscureText: _obscureText,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                    suffixIcon: SizedBox(
                                      child: InkWell(
                                          onTap: toggleObscureText,
                                          child: _obscureText
                                              ? Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Icon(
                                                    Icons.visibility_off,
                                                    color:
                                                        AppColor.conduitgreen,
                                                  ),
                                                )
                                              : Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Icon(
                                                    Icons.visibility,
                                                    color:
                                                        AppColor.conduitgreen,
                                                  ),
                                                )),
                                    ),
                                    filled: true,
                                    fillColor: AppColor.conduittextfieldcolor,
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.2)),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.2)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color: Colors.black, width: 1.2)),
                                    contentPadding: EdgeInsets.all(12),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.2),
                                    ),
                                    hintText: "Password",
                                    hintStyle: TextStyle(fontSize: 12)),
                              ),
                            ),
                            SizedBox(
                              height: 26,
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
                                      context.read<LoginBloc>()
                                        ..add(
                                          LoginsubmitEvent(
                                            requestModel: AuthModel(
                                                email: emailCtr.text,
                                                password: passwordCtr.text),
                                          ),
                                        );
                                    }
                                  },
                                  child: Text(
                                    "Sign in",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.white),
                                  )),
                            )
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUpPage();
                      }));
                    },
                    child: Text(
                      "Sign up for Conduit",
                      style: TextStyle(
                          color: AppColor.conduitgreen,
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColor.conduitgreen),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
