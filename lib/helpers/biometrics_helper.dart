import 'package:local_auth/local_auth.dart';

class BiometricsHelper {
  final LocalAuthentication auth = LocalAuthentication();
  Future<bool> hasEnrolledBiometrics() async {
    final List<BiometricType> availableBiometrics =
        await auth.getAvailableBiometrics();

    if (availableBiometrics.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<bool> authenticate() async {
    final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to show account balance',
        options: const AuthenticationOptions(biometricOnly: true));
    return didAuthenticate;
  }
}
