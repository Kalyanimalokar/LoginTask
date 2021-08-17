import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController with ChangeNotifier {
  var _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleAccount;
  Map? userData;

  googlelogin() async {
    this.googleAccount = await _googleSignIn.signIn();
    notifyListeners();
  }

  facebooklogin() async {
    var result = await FacebookAuth.i.login(
      permissions: ["public_profile", "email"],
    );

    if (result.status == LoginStatus.success) {
      final requestData = await FacebookAuth.i.getUserData(
        fields: "email,name,picture",
      );

      userData = requestData;
      notifyListeners();
    }
  }

  logOut() async {
    this.googleAccount = await _googleSignIn.signOut();
    await FacebookAuth.i.logOut();
    userData = null;
    notifyListeners();
  }
}
