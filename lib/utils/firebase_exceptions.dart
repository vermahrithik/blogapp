
class FirebaseExceptionHandler {
  static String handleException(String code) {
    switch (code) {
      // Login Exceptions :
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'user-disabled':
        return 'This user has been disabled.';
      case 'user-not-found':
        return 'No user found for this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'The email is already in use by another account.';
      case 'operation-not-allowed':
        return 'This sign-in method is not allowed.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'network-request-failed':
        return 'Network error occurred. Please check your internet connection.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different credential.';
      case 'invalid-credential':
        return 'The credential is invalid or has expired.';
      case 'invalid-verification-code':
        return 'The verification code is invalid.';
      case 'invalid-verification-id':
        return 'The verification ID is invalid.';
      case 'session-expired':
        return 'The session has expired. Please try again.';
      case 'credential-already-in-use':
        return 'This credential is already associated with a different user.';
      case 'invalid-api-key':
        return 'The provided API key is invalid.';
      case 'quota-exceeded':
        return 'Quota exceeded. Please try again later.';
      /// database exceptions :
      case 'unavailable':
        return 'The service is unavailable.';
      case 'write-cancelled':
        return 'The write was canceled locally.';
      case 'disconnected':
        return 'The operation had to be aborted due to a network disconnect.';
      case 'invalid-token':
        return 'The specified authentication token is invalid.';
      case 'expired-token':
        return 'The supplied auth token has expired.';
      case 'permission-denied':
        return 'This client does not have permission to perform this operation.';
      case 'unknown-error':
        return 'An unknown error occurred.';
      case 'network-error':
        return 'The operation could not be performed due to a network error.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}





// class FirebaseExceptionsHandler{
//
//   static const String splashScreenRouteName = 'splashscreen';
//   static const String homeRouteName = 'home';
//   static const String loginRouteName = 'login';
//   static const String signUpRouteName = 'signup';
//   static const String mainRouteName = 'main';
//   static const String addBlogRouteName = 'addBlog';
//   static const String editBlogRouteName = 'edit/';
//   static const String detailsRouteName = 'details';
//   static const String phoneRouteName = 'loginwithphone';
//   static const String verifyRouteName = 'verifyphone';
//
//   static
//
// }