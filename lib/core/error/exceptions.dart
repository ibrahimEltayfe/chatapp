import 'package:firebase_auth/firebase_auth.dart';
import '../constants/app_errors.dart';
import 'failures.dart';

class ExceptionHandler implements Exception{
  late final Failure failure;

  ExceptionHandler.handle(dynamic e){
    if(e is FirebaseAuthException){
      failure = AuthFailure(getGoogleLoginErrorMsg(e.code));
    }else if(e is FirebaseException){
      failure = UnExpectedFailure(e.message??AppErrors.unKnownError);
    }else if(e is UIDException){
      failure = NoUIDFailure(e.message);
    }else if(e is SharedPrefSetDataException){
      failure = SaveUIDLocallyFailure(e.message);
    } else{
      failure = const UnExpectedFailure(AppErrors.unKnownError);
    }
  }
}

String getGoogleLoginErrorMsg(String code) {
  switch (code) {
    case 'account-exists-with-different-credential':
      return 'Account exists with different credentials.';
    case 'invalid-credential':
      return 'The credential received is malformed or has expired.';
    case 'operation-not-allowed':
      return 'Operation is not allowed.  Please contact support.';
    case 'user-disabled':
      return 'This user has been disabled. Please contact support for help.';
    case 'user-not-found':
      return 'Email is not found, please create an account.';
    case 'wrong-password':
      return 'Incorrect password, please try again.';
    case 'invalid-verification-code':
      return 'The credential verification code received is invalid.';
    case 'invalid-verification-id':
      return 'The credential verification ID received is invalid.';
    default:
      return "Google Login Error.. please try again";
  }
}

class UIDException implements Exception{
  final String message;
  UIDException(this.message);
}

class SharedPrefSetDataException implements Exception{
  final String message;
  SharedPrefSetDataException(this.message);
}