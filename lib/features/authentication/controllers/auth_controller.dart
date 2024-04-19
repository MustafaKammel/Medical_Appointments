// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graduateproject/common/widgets/Doctors/doctor_card_vertical.dart';
import 'package:graduateproject/navigation_menu.dart';
import 'package:graduateproject/features/authentication/screens/onboarding/onboarding.dart';
import 'package:graduateproject/utils/consts/consts.dart';
import 'package:graduateproject/features/authentication/screens/login/login_view.dart';
import 'package:graduateproject/utils/helpers/helper_functions.dart';
import 'package:graduateproject/utils/localStorage/storage_utility.dart';

import '../../App/screens/Schedule/views/upcoming_schedule.dart';

class AuthController extends GetxController {
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  UserCredential? userCredential;

  //Doctor Controllers
  var aboutController = TextEditingController();
  var addressController = TextEditingController();
  var servicesController = TextEditingController();
  var timingController = TextEditingController();
  var salaryController = TextEditingController();
  var phoneController = TextEditingController();
  var categoryController = TextEditingController();

  static isUserAlreadyLoggedIn() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        var data = await FirebaseFirestore.instance
            .collection('doctors')
            .doc(user.uid)
            .get();
        var isDoc = data.data()?.containsKey('docName') ?? false;
        if (isDoc) {
          Get.offAll(() => const Upcomingschedule());
        } else {
          // await TlocalStorage.init(user.uid);
          Get.offAll(() => const NavigationMenu());
        }
      } else {
        Get.offAll(() => const OnboardingScreen());
      }
    });
  }

  loginUser() async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
    } catch (e) {
      THelperFunctions.showSnackBar("No user found for that email");
    }
  }

  // loginUser() async {
  //   if (emailController.text.isEmpty || passwordController.text.isEmpty) {
  //     THelperFunctions.showSnackBar("Please fill in all fields");
  //     return;
  //   }

  //   try {
  //     userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       THelperFunctions.showSnackBar("No user found for that email");
  //     } else if (e.code == 'wrong-password') {
  //       THelperFunctions.showSnackBar("Wrong password provided for that email");
  //     } else {
  //       THelperFunctions.showSnackBar("An error occurred during sign in");
  //     }
  //   } catch (e) {
  //     print('Error during sign in: $e');
  //     THelperFunctions.showSnackBar("An error occurred during sign in");
  //   }
  // }

  signupUser(bool isDoctor) async {
    if (fullnameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      THelperFunctions.showSnackBar("Please fill in all fields");
      return;
    }

    // Add additional validation checks if necessary

    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      await storeUserData(userCredential!.user!.uid, fullnameController.text,
          emailController.text, isDoctor);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        THelperFunctions.showSnackBar("The email address is already in use");
      } else {
        THelperFunctions.showSnackBar("An error occurred during sign up");
      }
    } catch (e) {
      print('Error during sign up: $e');
      THelperFunctions.showSnackBar("An error occurred during sign up");
    }
  }

  storeUserData(
      String uid, String fullname, String email, bool isDoctor) async {
    var store = FirebaseFirestore.instance
        .collection(isDoctor ? 'doctors' : 'users')
        .doc(uid);
    if (isDoctor) {
      await store.set({
        'docAbout': aboutController.text,
        'docAddress': addressController.text,
        'docCategory': categoryController.text,
        'docName': fullname,
        'docPhone': phoneController.text,
        'docService': servicesController.text,
        'docTiming': timingController.text,
        'docSalary': salaryController.text,
        'docId': FirebaseAuth.instance.currentUser?.uid,
        'docRating': 1,
        'docEmail': email
      });
    } else {
      await store.set({
        'name': fullname,
        'email': email,
        'id': uid,
        'about': 'i am new at this app',
        'image': '',
        'created_at': DateTime.now().toString(),
        'last_activated': DateTime.now().toString(),
        'puch_token': '',
        'online': false,
      });
    }
  }

  //   Future<List <DoctorCardVertical>>getfavoriteDoctor(List<String>doctors)async{
  //   try {
  //     var db =  FirebaseFirestore.instance;

  //     final snapshot=await db.collection('doctors').where(FieldPath.documentId,whereIn: doctors).get();
  //     return snapshot.docs.map((querysnapshot) => ,).toList();

  //   }on FirebaseAuthException catch (e) {

  //   }on PlatformException catch (e) {

  //   }on catch (e) {

  //   }
  // }

  signout() async {
    await FirebaseAuth.instance.signOut().then((value) => const LoginView());
  }
}
