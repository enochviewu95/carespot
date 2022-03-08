import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthenticationApi {
  /*Abstract methods for authentication service*/
  void tokenChanged(); //Check changes in token
  void userChanged(); //check for changes in user
  Future<UserCredential?> registerUser({required String email, required String password}); //register user
  Future<UserCredential?> signIn({required String email, required String password}); //sign user in
  Future<void> verifyUserEmail(); //Verify user email
  Future<void> signOut(); //sign out user
  Future<UserCredential?> signInWithGoogle(); //sign user in with google
  Future<String?> currentUserUid(); //get user uid
  FirebaseAuth? getFirebaseAuth();
}
