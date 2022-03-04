import 'package:carespot/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationService {

  AuthenticationService(){
    init();
  }

  Future<void> init() async{
    if (kDebugMode) {
      print('initializing');
    }
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  }

  //Check if the state of authentication has changed
  void authenticationStateChanged() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          print('User is signed in');
        }
      }
    });
  }

  //Check if the signing token has changed
  void tokenChanged() {
    FirebaseAuth.instance.idTokenChanges().listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out!');
        }
      } else {
        if (kDebugMode) {
          print('User is signed in');
        }
      }
    });
  }

  //Check if the signed in user has changed
  void userChanged() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        if (kDebugMode) {
          print('User is currently signed out');
        }
      } else {
        if (kDebugMode) {
          print('user is signed in');
        }
      }
    });
  }

  //Registration of user
  Future<void> registerUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
      } else if (e.code == 'email-already-in-use') {
        if (kDebugMode) {
          print('The account already exists for that email');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //Signing in of user
  Future<void> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print('No user found for that email.');
        }
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print('Wrong password provided for that user.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //Verify user email
  Future<void> verifyUserEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user!=null && !user.emailVerified){
      await user.sendEmailVerification();
    }
  }

  //Signing out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }


  //Sign in with google
  Future<UserCredential> signInWithGoogle() async {
    //Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    //Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    //Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken
    );

    //Once signed in, return the user credentials
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
