import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study_app/firebase_ref/refrences.dart';
import 'package:flutter_study_app/screens/home/home_screen.dart';
import 'package:flutter_study_app/screens/login/login_screen.dart';
import 'package:flutter_study_app/widgets/dialoges/dialogue_widget.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController{
  @override
  void onReady() {
    initAuth();
    super.onReady();
  }
  //set variable for authentication
late FirebaseAuth _auth;
  final _user=Rxn<User>();
  late Stream<User?> authStatesChanges;

  void initAuth()async {
   await  Future.delayed(const Duration(seconds: 3));
   _auth=FirebaseAuth.instance;
   authStatesChanges=_auth.authStateChanges();
   authStatesChanges.listen((User? user) {
     _user.value=user;
   });

    navigateToIntroduction();

  }
  //method for google signIn
  signInWithGoogle()async{
    final GoogleSignIn _googleSignIn=GoogleSignIn();

    try{
      GoogleSignInAccount? account= await _googleSignIn.signIn();
      if(account!=null){
        final _authAccount= await account.authentication;
       final _credential= GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );
       await _auth.signInWithCredential(_credential);
       await saveUser(account);
       navigateToHomeScreen();
      }

    }on Exception catch(err){
      return err;

    }

  }
  User? getUser(){
    _user.value= _auth.currentUser;
    return _user.value;

  }
  saveUser(GoogleSignInAccount account){
    userRF.doc(account.email).set({
      'email':account.email,
      'name':account.displayName,
      'profilePic':account.photoUrl,
    });

  }
 Future<void> signOut()async{
    try{
      await _auth.signOut();
      navigateToHomeScreen();

    }
    on FirebaseException catch(err){
       err;
    }
  }
  void navigateToHomeScreen(){
    Get.offAllNamed(HomeScreen.routeName);
  }




  void navigateToIntroduction(){
    Get.offAllNamed('/introduction');
  }
  void showLoginAlertDialogue(){
    Get.dialog(Dialogs.questionStartDialogue(onTap: (){
      Get.back();
      //navigate to login screen method
      navigateToLoginScreen();

    }),
    barrierDismissible: false
    );


  }
  navigateToLoginScreen(){
    Get.toNamed(LoginScreen.routeName);
  }
  bool isLoggedIn(){
    return _auth.currentUser != null;
  }
}