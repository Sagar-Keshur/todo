import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as fb_ath;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/models/auth_result.dart';

class SocialAuthRepository with AuthError {
  //
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final fb_ath.FacebookAuth _facebookAuth = fb_ath.FacebookAuth.instance;

  Future<AuthResult> signInWithGoogle() async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return AuthResult(status: true, user: userCredential.user);
      //
    } on FirebaseAuthException catch (e) {
      return AuthResult(status: false, message: e.message);
    } catch (e) {
      return const AuthResult(status: false, message: 'Please try again!');
    }
  }

  Future<AuthResult> signInWithFacebook() async {
    try {
      final fb_ath.LoginResult loginResult = await _facebookAuth.login();
      if (loginResult.status == fb_ath.LoginStatus.success) {
        final fb_ath.AccessToken accessToken = loginResult.accessToken!;

        final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);

        UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
        return AuthResult(status: true, user: userCredential.user);
      } else {
        return AuthResult(status: false, message: loginResult.message);
      }
    } on FirebaseAuthException catch (e) {
      return exception(e);
    } catch (e) {
      return AuthResult(status: false, message: e.toString());
    }
  }

  Future<void> signOutWithGoogle() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}

mixin AuthError {
  AuthResult exception(FirebaseAuthException e) {
    late String message;
    switch (e.code) {
      case 'account-exists-with-different-credential':
        message = 'Account is already registered with different credential.';
        break;
      case 'invalid-credential':
        message = 'Invalid Credentials.';
        break;
      case 'user-disabled':
        message = 'Your account has been blocked or disabled. Contact our support team to unlock it, then try again.';
        break;
      case 'wrong-password':
        message = 'Password is incorrect.';
        break;
      case 'email-already-in-use':
        message = 'This email address already used by another account';
        break;
      case 'user-not-found':
      case 'auth/user-not-found':
        message = 'Account not found';
        break;
      default:
        message = nullOrValue<String>(e.message);
        break;
    }
    return AuthResult(status: false, message: message);
  }
}

T nullOrValue<T>(dynamic value) => value;
