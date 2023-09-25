import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

class LocalAuthService {
  static final _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    try {
      if (!await _canAuthenticate()) return false;
      return await _auth.authenticate(
          authMessages: const [
            AndroidAuthMessages(
                signInTitle: 'Sign In', cancelButton: 'No thanks'),
            IOSAuthMessages(cancelButton: 'No thanks')
          ],
          localizedReason: 'Use Face Id to authenticate',
          options: const AuthenticationOptions(
              stickyAuth: true, useErrorDialogs: true));
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
