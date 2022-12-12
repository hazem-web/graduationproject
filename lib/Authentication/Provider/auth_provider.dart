import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graduationproject/Home_Screen/Screens/homepage.dart';
import 'package:quickalert/quickalert.dart';
import '../Models/usermodel.dart';
import '../Screens/Login_Screen.dart';

class AuthProvider extends ChangeNotifier{
  FirebaseAuth loginAuth = FirebaseAuth.instance;
  FirebaseFirestore database = FirebaseFirestore.instance;
  GoogleSignIn googleSignIn=GoogleSignIn();
  UserModel user = UserModel(name: '', email: "", userId: "",image: "");
  bool obscure = true;

  void login({ required String email ,required String password,required context})async{
    try{
      await loginAuth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(const HomePage());
    }
    catch(e) {
      Get.dialog(await QuickAlert.show(context: context, type: QuickAlertType.error,text: e.toString()));
    }
  }

  void register({required String email ,required String password,required String name})async{
    try{
      await loginAuth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
        saveUser(value, name,email);
      });
      Get.offAll(const HomePage());
    }
    catch(e){
      Get.snackbar("Sign up error", e.toString(),snackPosition: SnackPosition.BOTTOM,backgroundColor: Colors.red);

    }
  }

  void logout()async{
    await loginAuth.signOut();
    Get.to(LoginScreen());
  }

  void googleSign()async{
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

    GoogleSignInAuthentication google = await googleUser!.authentication;

    var credintal=GoogleAuthProvider.credential(idToken:google.idToken ,accessToken: google.accessToken);
    await loginAuth.signInWithCredential(credintal).then((value) {
      saveUser(value, "","");
      Get.offAll(const HomePage());
    });
  }

  void saveUser(UserCredential user,String name,String email)async{
    UserModel userModel = UserModel(name: name==""?user.user!.displayName!:name,email:user.user!.email!,image: "", userId: user.user!.uid);
    database.collection("users").doc(user.user!.uid).set(userModel.toJson()).then((value) {
    }).catchError((error){print(error);});
  }
  getUser()async{
    await database.collection('users').doc(loginAuth.currentUser!.uid).get().then((value) {
      user = UserModel.fromJson(value.data()!);
      notifyListeners();
    });
  }

  void password(){
    obscure=!obscure;
    notifyListeners();
  }
}