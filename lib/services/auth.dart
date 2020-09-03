import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  //Sign in with email and pwd

  //Sign in with Google

  Future<FirebaseUser> signInWithGoogle() async {
    Future<FirebaseUser> user;

    try {
      //await _auth.signInWithEmailAndPassword(email: null, password: null);
      bool isSignedIn = await _googleSignIn.isSignedIn();

      if (isSignedIn) {
        user = _auth.currentUser();
      }
    } catch (e) {
      return null;
    }

    return user;
  }

  //Sign in with Facebook
}
