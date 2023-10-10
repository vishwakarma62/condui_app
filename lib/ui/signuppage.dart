import 'package:condui_app/ui/util/massage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../Bloc/signupbloc/bloc/sign_up_bloc.dart';
import '../intl/appcolor.dart';
import '../model/authmodel.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailCtr = TextEditingController();
  TextEditingController usernameCtr = TextEditingController();
  TextEditingController bioCtr = TextEditingController();
  TextEditingController passwordCtr = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool stepone = true;
  bool steptwo = false;
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
        body: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpLoading) {
              testmassage.showdialogue();
            }
            if (state is SignUpErrorState) {
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
            if (state is SignUpLoaded) {
              testmassage.dismiss();
              Navigator.popUntil(context, (route) => route.isFirst);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return LoginPage();
              }));
              Fluttertoast.showToast(
                  msg: "${state.masg}",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
            if (state is SignUponNoInternet) {
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
          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
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
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 95.0),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  stepone = true;
                                  steptwo = false;
                                });
                              },
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: stepone
                                      ? AppColor.conduitgreen
                                      : Colors.grey,
                                ),
                                child: Center(
                                  child: Text(
                                    "1",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                thickness: 2,
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    stepone = false;
                                    steptwo = true;
                                  });
                                }
                              },
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: steptwo
                                      ? AppColor.conduitgreen
                                      : Colors.grey,
                                ),
                                child: Center(
                                  child: Text(
                                    "2",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
                                      "Sign up to Conduit",
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
                                if (steptwo)
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Password*",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: TextFormField(
                                          obscureText: _obscureText,
                                          style: TextStyle(fontSize: 12),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(
                                                16),
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
                                          controller: passwordCtr,
                                          cursorColor: Colors.blue,
                                          decoration: InputDecoration(
                                              suffixIcon: SizedBox(
                                                height: 10,
                                                width: 10,
                                                child: InkWell(
                                                    onTap: toggleObscureText,
                                                    child: _obscureText
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: Icon(
                                                              Icons
                                                                  .visibility_off,
                                                              color: AppColor
                                                                  .conduitgreen,
                                                            ),
                                                          )
                                                        : Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                            child: Icon(
                                                              Icons.visibility,
                                                              color: AppColor
                                                                  .conduitgreen,
                                                            ),
                                                          )),
                                              ),
                                              filled: true,
                                              fillColor: AppColor
                                                  .conduittextfieldcolor,
                                              contentPadding:
                                                  EdgeInsets.all(12),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: Colors.black,
                                                          width: 1.2)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 1.2)),
                                              hintText: "Password",
                                              hintStyle:
                                                  TextStyle(fontSize: 12)),
                                        ),
                                      ),
                                    ],
                                  ),
                                SizedBox(
                                  height: 14,
                                ),
                                if (stepone)
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "username*",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 12),
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(
                                                RegExp(r'[0-9]')),
                                            FilteringTextInputFormatter.deny(RegExp(
                                                r'\s')), // Deny whitespace (spaces)
                                          ],
                                          // onChanged: _updateNameValidity,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Enter name";
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: usernameCtr,
                                          cursorColor: Colors.blue,
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: AppColor
                                                  .conduittextfieldcolor,
                                              contentPadding:
                                                  EdgeInsets.all(12),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              hintText: "username",
                                              hintStyle:
                                                  TextStyle(fontSize: 12)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Email*",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 12),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.deny(RegExp(
                                                r'\s')), // Deny whitespace (spaces)
                                          ],
                                          validator: (value) {
                                            // Check if this field is empty
                                            if (value == null ||
                                                value.isEmpty) {
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
                                          // onChanged: _updateEmailValidity,
                                          controller: emailCtr,
                                          cursorColor: Colors.blue,
                                          decoration: InputDecoration(
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      borderSide: BorderSide(
                                                          color: Colors.black)),
                                              errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              filled: true,
                                              fillColor: AppColor
                                                  .conduittextfieldcolor,
                                              contentPadding:
                                                  EdgeInsets.all(12),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.2),
                                              ),
                                              hintText: "Email",
                                              hintStyle:
                                                  TextStyle(fontSize: 12)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      SizedBox(
                                        height: 14,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Bio(optional)",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          Spacer(),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: TextFormField(
                                          style: TextStyle(fontSize: 12),

                                          controller: bioCtr,
                                          maxLines: 3,
                                          cursorColor: Colors.blue,
                                          textAlign: TextAlign
                                              .left, // Set text alignment to left
                                          textAlignVertical: TextAlignVertical
                                              .center, // Center text vertically
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                AppColor.conduittextfieldcolor,
                                            contentPadding: EdgeInsets.all(12),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide: BorderSide(
                                                        color: Colors.black)),
                                            errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.2),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.2),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1.2),
                                            ),
                                            hintText: "Bio",
                                            hintStyle: TextStyle(fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                SizedBox(
                                  height: 26,
                                ),
                                if (stepone)
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 44,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          backgroundColor:
                                              AppColor.conduitgreen,
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            setState(() {
                                              stepone = false;
                                              steptwo = true;
                                            });
                                          }
                                        },
                                        child: Text(
                                          "Next",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white),
                                        )),
                                  ),
                                if (steptwo)
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 44,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          backgroundColor:
                                              AppColor.conduitgreen,
                                        ),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            FocusScopeNode currentFocus =
                                                FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                            context.read<SignUpBloc>()
                                              ..add(
                                                SignUPSubmitEvent(
                                                  signup: AuthModel(
                                                      email: emailCtr.text,
                                                      username:
                                                          usernameCtr.text,
                                                      password:
                                                          passwordCtr.text,
                                                      bio: bioCtr.text),
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
                        "Already have an account?",
                        style: TextStyle(fontSize: 14),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign In",
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back)),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
