import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skripskuy_web/app/models/custom_user/custom_user_model.dart';
import 'package:skripskuy_web/app/models/custom_user/providers/custom_user_provider.dart';

class AuthController extends GetxController {
  CustomUserProvider customUserProvider = CustomUserProvider();

  CustomUser user;

  Stream<User> get getAuthStatus => FirebaseAuth.instance.authStateChanges();

  String get getCurrentFirebaseId => FirebaseAuth.instance.currentUser.uid;

  @override
  Future<void> onInit() async {
    super.onInit();
    user = await initUser();
  }

  Future<CustomUser> initUser() async {
    user = CustomUser();
    if (FirebaseAuth.instance.currentUser != null) {
      await customUserProvider
          .getUser(firebaseId: FirebaseAuth.instance.currentUser.uid)
          .then((user) async {
        this.user = user;
        await customUserProvider.updateUser(
            firebaseId: FirebaseAuth.instance.currentUser.uid,
            json: {
              'firebase_token': await FirebaseMessaging.instance.getToken()
            });
      });
    }
    return user;
  }

  Future<bool> login({String email, String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser != null) {
        await customUserProvider
            .getUser(
          firebaseId: FirebaseAuth.instance.currentUser.uid,
        )
            .then((user) async {
          this.user = user;
          await customUserProvider
              .updateUser(
                  firebaseId: FirebaseAuth.instance.currentUser.uid,
                  json: {
                    'firebase_token':
                        await FirebaseMessaging.instance.getToken()
                  })
              .then((userObj) => this.user = userObj)
              .onError((error, stackTrace) => Future.error(error));
        }, onError: (err) async {
          Get.snackbar("Terdapat kesalahan",
              "Permintaan tidak dapat di proses (Kesalahan Sistem)",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.white,
              borderRadius: 20);
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'unknown') {
        Get.snackbar('Terdapat kesalahan', 'Email dan password harus di isi',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      } else if (e.code == 'invalid-email') {
        Get.snackbar('Terdapat kesalahan',
            'Harap masukan email dengan format yang benar',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      } else if (e.code == 'user-not-found') {
        Get.snackbar('Terdapat kesalahan',
            'Tidak ditemukan akun dengan email yang diberikan',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Terdapat kesalahan', 'Password yang diberikan salah',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      }
      return false;
    } catch (e) {
      print(e);
      await FirebaseAuth.instance.signOut();
      Get.snackbar("Terdapat kesalahan", "Mohon untuk mengulangi nya kembali",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
      return false;
    }
    return true;
  }

  Future<bool> register({
    String fullName,
    String phoneNumber,
    String email,
    String password,
  }) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await customUserProvider
          .createUser(
            firebase_id: userCredential.user.uid,
            firebase_token: await FirebaseMessaging.instance.getToken(),
            fullName: fullName,
            phoneNumber: phoneNumber,
            email: email,
          )
          .then((userObj) => this.user = userObj)
          .onError((error, stackTrace) async {
        await FirebaseAuth.instance.signOut();
        return Future.error(error);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        Get.snackbar('Terdapat kesalahan',
            'Harap masukan email dengan format yang benar',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      } else if (e.code == 'weak-password') {
        Get.snackbar(
            'Terdapat kesalahan', 'Password yang diberikan terlalu lemah',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
            'Terdapat kesalahan', 'Email yang diberikan telah digunakan',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      }
      return false;
    } catch (e) {
      Get.snackbar("Terdapat kesalahan",
          "Permintaan tidak dapat di proses (Kesalahan Sistem)",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
      return false;
    }
    return true;
  }

  Future<bool> resetPassword({String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
            'Terdapat kesalahan', 'Alamat email yang diberikan tidak terdaftar',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      }
      return false;
    } catch (e) {
      Get.snackbar("Terdapat kesalahan",
          "Permintaan tidak dapat di proses (Kesalahan Sistem)",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
      return false;
    }
    Get.snackbar('Sukses', 'Email untuk reset password telah dikirimkan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white,
        borderRadius: 20);
    return true;
  }

  Future<bool> updatePassword({String oldPassword, String newPassword}) async {
    final credential = EmailAuthProvider.credential(
      email: FirebaseAuth.instance.currentUser.email,
      password: oldPassword,
    );
    try {
      await FirebaseAuth.instance.currentUser
          .reauthenticateWithCredential(credential)
          .then((_) async {
        await FirebaseAuth.instance.currentUser
            .updatePassword(newPassword)
            .then((_) => true);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        Get.snackbar(
            "Terdapat kesalahan", "Password lama yang anda berikan salah",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      } else if (e.code == 'weak-password') {
        Get.snackbar(
            'Terdapat kesalahan', 'Password baru yang diberikan terlalu lemah',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            borderRadius: 20);
      }
      print(e);
      return false;
    }
    return true;
  }

  Future<bool> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      Get.snackbar("Terdapat kesalahan",
          "Permintaan tidak dapat di proses (Kesalahan Sistem)",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          borderRadius: 20);
      return false;
    }
    this.user = CustomUser();
    return true;
  }
}
