import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/routes.dart';
import '../../widget/auth/progress_dialog.dart';

class AuthProvider extends ChangeNotifier {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool signIn=false;

  void snackBar({required String title, required BuildContext context}) {
    final snackBar = SnackBar(
      duration:const Duration(seconds:5),
      content: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: "Brand-Bold",
        fontWeight:FontWeight.w500
      ),
        textAlign:TextAlign.center,
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void singUpUsingFirebase(
      {required String name,
      required String email,
      required String phone,
      required String password,
      required BuildContext context
      }) async {
    try {
      showDialog(context: context, builder: (BuildContext context)=>const ProgressDialog(status:'Registering You .....',));
      await auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
         var userId =auth.currentUser!.uid;
         if(userId.isNotEmpty){
           DatabaseReference ref=  FirebaseDatabase.instance.refFromURL('https://uber-app-ae2b4-default-rtdb.firebaseio.com/').child("Users/$userId");
           Map userData={
             'fullName':name,
             'email':email,
             'phone':phone,
             'password':password,
           };
           ref.set(userData);
         }
     });
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
      signIn=true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('Login', signIn);
      Navigator.of(context).pop();
      notifyListeners();
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.mainScreen, (route) => false);

    } on FirebaseAuthException catch (e) {
      String message = 'error Occurred';
      String title = e.code;
      if (title == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (title == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      } else {
        message = e.message.toString();
      }
      Navigator.of(context).pop();
      snackBar(title: message, context: context);
    } catch (e) {
      Navigator.of(context).pop();
      snackBar(title: "Error:$e", context: context);
    }
  }

  void singInUsingFirebase({required String email, required String password,required BuildContext context}) async {
    try {
      showDialog(context: context, builder: (BuildContext context)=>const ProgressDialog(status:'Logging You In ',));
      await auth.signInWithEmailAndPassword(email: email, password: password);

      /*
       .then((value)  async {
        var userId =auth.currentUser!.uid;
        if(userId.isNotEmpty){
          DatabaseReference ref=  FirebaseDatabase.instance.refFromURL('https://uber-app-ae2b4-default-rtdb.firebaseio.com/').child("Users/$userId");
          final snapshot = await ref.get();
          if (snapshot.value != null) {
            Navigator.of(context).pop();
            Navigator.of(context).pushNamedAndRemoveUntil(Routes.mainScreen, (route) => false);
          }
        }
      });
       */
      AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      await FirebaseAuth.instance.currentUser!.reauthenticateWithCredential(credential);
      signIn=true;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('Login', signIn);
      Navigator.of(context).pop();
      notifyListeners();
      Navigator.of(context).pushNamedAndRemoveUntil(Routes.mainScreen, (route) => false);

    } on FirebaseAuthException catch (e) {
      String message = 'error Occurred';
      String title = e.code;
      if (title == 'user-not-found') {
        message = 'No user found for that $email.';
      } else if (title == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      } else {
        message = e.message.toString();
      }
      Navigator.of(context).pop();
      snackBar(title: message, context: context);
    } catch (e) {
      Navigator.of(context).pop();
      snackBar(title: "Error:$e", context: context);
    }
  }

  Future<void> signOutFromApp(BuildContext context) async {
    try {
      showDialog(context: context, builder: (BuildContext context)=>const ProgressDialog(status:'You Logout From App .....',));
      await auth.signOut();
      signIn = false;
      Navigator.pushNamedAndRemoveUntil(context,Routes.loginScreen, (route) => false);
      notifyListeners();
    } catch (e) {
      snackBar(title: "Error:$e", context: context);
    }
  }
}
