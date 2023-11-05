import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:grass_hugs/helper/failure.dart';
import 'package:grass_hugs/helper/firebase_constants.dart';
import 'package:grass_hugs/helper/type_deft.dart';
import 'package:grass_hugs/models/user_model.dart';
import 'package:grass_hugs/providers/firebase_provider.dart';

//? We don't want to create Instance of the class everytime so creating a Provider for it.
final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    firebaseAuth: ref.read(authProvider),
    firebaseFirestore: ref.read(firestoreProvider),
  ),
);

class AuthRepository {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseAuth _firebaseAuth;

  AuthRepository({
    required FirebaseAuth firebaseAuth,
    required FirebaseFirestore firebaseFirestore,
  })  : _firebaseAuth = firebaseAuth,
        _firebaseFirestore = firebaseFirestore;

  CollectionReference get _user =>
      _firebaseFirestore.collection(FirebaseConstants.userCollection);

  //? It will be used to check if the user is logged in or not.
  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  FutureEither<Map<dynamic, dynamic>> signInWithPhone(
      String countryCode, String phoneNumber) async {
    try {
      Completer<Map> verifcationData = Completer<Map<dynamic, dynamic>>();

      //? Sign in with Phone.
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Auto verification when on Android device
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          // Handle verification failure
          if (e.code == "invalid-phone-number") {
            verifcationData.completeError("Invalid Phone Number!");
          } else {
            verifcationData.completeError("Authentication failed!");
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          verifcationData.complete({
            "phoneNumber": countryCode + phoneNumber,
            "verificationId": verificationId,
            "resendToken": resendToken
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Handle timeout
          verifcationData.completeError("Phone verification timeout!");
        },
      );

      //? In case of success we are returning the verifcationData to the controller.
      return right(await verifcationData.future);
    } on FirebaseAuthException catch (e) {
      //? Throws the error to the next catch block.
      throw e.message!;
    } catch (e) {
      //? returns the error to the controller.
      return left(Failure("Authentication failed!"));
    }
  }

  FutureEither<UserModel> verifiyPhone(
      String verificationId, String smsCode) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );

      UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      //? Storing the user data in firestore.
      UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            name: "",
            email: "",
            about: "",
            uid: userCredential.user!.uid,
            isAuthenticated: false);
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      //? In case of success we are returning the userModel to the controller.
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      print(e);

      //? Throws the error to the next catch block.
      return left(Failure(e.message!));
    } catch (e) {
      print(e);
      //? returns the error to the controller.
      return left(Failure("Authentication failed!"));
    }
  }

  FutureEither<UserModel> createAccount(Map<String, dynamic> userData) async {
    try {
      //? Storing the user data in firestore.
      UserModel userModel;
      userModel = UserModel(
          name: userData["name"],
          email: userData["email"],
          about: userData["about"],
          uid: userData["uid"],
          isAuthenticated: true);
      await _user.doc(userData["uid"]).set(userModel.toMap());

      //? In case of success we are returning the userModel to the controller.
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      print(e);

      //? Throws the error to the next catch block.
      return left(Failure(e.message!));
    } catch (e) {
      print(e);
      //? returns the error to the controller.
      return left(Failure("Authentication failed!"));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _user.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }
}
