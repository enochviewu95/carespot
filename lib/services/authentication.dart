import 'package:carespot/firebase_options.dart';
import 'package:carespot/services/authentication_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationService  implements AuthenticationApi{

  //Initialize the firebase auth
  FirebaseAuth? _firebaseAuth;

  AuthenticationService(){
    init();
  }

  @override
  FirebaseAuth? getFirebaseAuth(){
    return _firebaseAuth;
  }

  @override
  Future<void> init() async{
    if (kDebugMode) {
      print('initializing');
    }
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    ).then((value) => _firebaseAuth = FirebaseAuth.instance);
  }

  //Get current User uid
  @override
  Future<String?> currentUserUid() async {
    User? user = _firebaseAuth?.currentUser;
    return user?.uid;
  }


  //Check if the signing token has changed
  @override
  void tokenChanged() {
    _firebaseAuth?.idTokenChanges().listen((User? user) {
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
  @override
  void userChanged() {
    _firebaseAuth?.userChanges().listen((User? user) {
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
  @override
  Future<UserCredential?> registerUser(
      {required String email, required String password}) async {
    UserCredential? userCredential;
    try {
        userCredential = await _firebaseAuth?.createUserWithEmailAndPassword(
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
    return userCredential;
  }

  //Signing in of user
  @override
  Future<UserCredential?> signIn({required String email, required String password}) async {

    UserCredential? userCredential;

    try {
      userCredential = await _firebaseAuth?.signInWithEmailAndPassword(
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

    return userCredential;
  }

  //Verify user email by sending verification email
  @override
  Future<void> verifyUserEmail() async {
    User? user = _firebaseAuth?.currentUser;
    if(user!=null && !user.emailVerified){
      await user.sendEmailVerification();
    }
  }

  //check if the email is verified
  bool? isEmailVerified()  {
    User? user = _firebaseAuth?.currentUser;
    return user?.emailVerified;
  }

  //Signing out
  @override
  Future<void> signOut() async {
    await _firebaseAuth?.signOut();
  }


  //Sign in with google
  @override
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
