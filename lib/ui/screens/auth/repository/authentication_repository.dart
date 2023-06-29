import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myfundsuthm/ui/screens/auth/exception/signup_email_password_failure.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<User?> firebaseUser = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 1), () {
      firebaseUser.bindStream(_auth.userChanges());
    });
    ever<User?>(firebaseUser, _setInitialScreen);
  }

  void _setInitialScreen(User? user) {
    user == null ? Get.offAllNamed('/welcome') : Get.offAllNamed('/tab');
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.code(e.code);
    } catch (e) {
      throw SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.code(e.code);
    } catch (e) {
      throw SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  bool isUserLoggedIn() {
    return firebaseUser.value != null;
  }
}
