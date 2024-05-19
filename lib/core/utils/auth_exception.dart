import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/auth_result.dart';

///Auth Exception
class AuthException {
  AuthException._();

  static AuthResult signInException(FirebaseAuthException e) {
    AuthResult result = AuthResult(status: false, message: e.message);

    switch (e.code) {
      case 'invalid-email':
        result = result.copyWith(message: 'The email address is badly formatted.');
        break;
      case 'user-not-found':
        result = result.copyWith(message: 'Email address not registered with us.');
        break;
      case 'wrong-password':
        result = result.copyWith(message: 'Password is incorrect.');
        break;
      case 'invalid-credential':
        result = result.copyWith(message: 'Invalid Credentials');
        break;
      default:
    }
    return result;
  }

  static AuthResult signUpException(FirebaseAuthException e) {
    AuthResult result = AuthResult(status: false, message: e.message);

    switch (e.code) {
      case 'email-already-in-use':
        result = result.copyWith(message: 'This email address already registered.');
        break;
      default:
    }
    return result;
  }

  static AuthResult changePasswordException(FirebaseAuthException e) {
    AuthResult result = AuthResult(status: false, message: e.message);

    switch (e.code) {
      case 'user-not-found':
        result = result.copyWith(message: 'Email address not registered with us.');
        break;
      case 'wrong-password':
        result = result.copyWith(message: 'Old password is incorrect.');
        break;
      default:
    }
    return result;
  }

  static AuthResult resetPasswordException(FirebaseAuthException e) {
    AuthResult result = AuthResult(status: false, message: e.message);

    switch (e.code) {
      case 'user-not-found':
        result = result.copyWith(message: 'No user found with this email.');

        break;
      case 'invalid-email':
        result = result.copyWith(message: 'Invalid email address.');
        break;
      default:
        result = result.copyWith(
          message: 'Something went wrong. Please try again later.',
        );
    }
    return result;
  }
}
