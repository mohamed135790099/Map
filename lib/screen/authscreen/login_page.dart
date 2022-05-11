import 'package:app_rider/routes/routes.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../logic/provider/auth_provider.dart';
import '../../resources/mystring.dart';
import '../../widget/auth/auth_button.dart';
import '../../widget/auth/auth_text_field_form.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);
  final TextEditingController _emailAddress = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


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
                    height: 120,
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
                    'Sign In as Rider',
                    style: TextStyle(fontSize: 25, fontFamily: "Brand-Bold"),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
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
                            controller: _password,
                            textInputType: TextInputType.name,
                            obscureText: true,
                            hintText: "Password",
                            validator: (value) {
                              if (value.toString().length < 7) {
                                return 'Enter valid Email';
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(
                          height: 40,
                        ),
                         AuthButton(text: 'LOGIN', onPressed: () async
                         
                         {
                           var connectivityResult = await (Connectivity().checkConnectivity());
                           if (connectivityResult != ConnectivityResult.mobile&&connectivityResult != ConnectivityResult.wifi) {
                             Provider.of<AuthProvider>(context,listen:false).snackBar(title: "No Internet Connectivity ", context: context);
                             // I am connected to a mobile network.
                             return;
                           }
                           final invalid = _formKey.currentState!.validate();
                           if(invalid){
                             FocusScope.of(context).unfocus();
                             Provider.of<AuthProvider>(context,listen:false)
                                 .singInUsingFirebase(
                                 email: _emailAddress.text.trim(),
                                 password: _password.text.trim(),
                                 context: context);
                           }
                         },),
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
                                text: "Don't have an account, ",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontFamily: "Brand-Regular"),
                              ),
                              TextSpan(
                                text: "Sign up here",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontFamily: "Brand-Regular",
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                  Navigator.of(context).pushReplacementNamed(Routes.singUpScreen);
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
