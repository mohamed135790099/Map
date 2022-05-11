import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/provider/auth_provider.dart';
import '../../resources/mystring.dart';
import '../../routes/routes.dart';
import '../../widget/auth/auth_button.dart';
import '../../widget/auth/auth_text_field_form.dart';

class SignUP extends StatelessWidget {
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  SignUP({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Form(
              key:_formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const Image(
                      alignment: Alignment.center,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/logo.png'),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Create a Rider's account",
                      style: TextStyle(fontSize: 25, fontFamily: "Brand-Bold"),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          AuthTextFromField(
                              controller: _fullName,
                              textInputType: TextInputType.name,
                              obscureText: false,
                              hintText: "Full Name",
                              validator: (value) {
                                if (!RegExp(validationName).hasMatch(value)) {
                                  return 'Enter valid Name';
                                }
                                else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          AuthTextFromField(
                              controller: _emailAddress,
                              textInputType: TextInputType.emailAddress,
                              obscureText: false,
                              hintText: "Email Address",
                              validator: (value) {
                                if (!RegExp(validationEmail).hasMatch(value)) {
                                  return 'Enter valid Email';
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          AuthTextFromField(
                              controller: _phoneNumber,
                              textInputType: TextInputType.phone,
                              obscureText: false,
                              hintText: "Phone Number",
                              validator: (value) {
                                if (value.toString().length>12||!RegExp(validationPhone).hasMatch(value)) {
                                  return 'Enter valid Phone ';
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          AuthTextFromField(
                              controller: _password,
                              textInputType: TextInputType.name,
                              obscureText: true,
                              hintText: "Password",
                              validator: (value) {
                                if (value.toString().length < 7) {
                                  return 'Enter valid password';
                                } else {
                                  return null;
                                }
                              }),
                          const SizedBox(
                            height: 40,
                          ),
                          AuthButton(onPressed: () async{
                            var connectivityResult = await (Connectivity().checkConnectivity());
                            if (connectivityResult != ConnectivityResult.mobile&&connectivityResult != ConnectivityResult.wifi) {
                              Provider.of<AuthProvider>(context,listen:false).snackBar(title: "No Internet Connectivity ", context: context);
                              return;
                            }
                            final invalid = _formKey.currentState!.validate();
                            if(invalid){
                              FocusScope.of(context).unfocus();
                              Provider.of<AuthProvider>(context,listen:false)
                                  .singUpUsingFirebase(
                                  name:_fullName.text,
                                  email: _emailAddress.text.trim(),
                                  phone:_phoneNumber.text.trim(),
                                  password: _password.text.trim(),
                                  context: context);
                            }
                          }, text: 'REGISTER',),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                const TextSpan(
                                  text: "Already have a Rider account? ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontFamily: "Brand-Regular"),
                                ),
                                TextSpan(
                                  text: "login",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontFamily: "Brand-Regular",
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
                                    },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
