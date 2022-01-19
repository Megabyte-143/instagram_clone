import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/models/user.dart' as model;
import 'package:instagram_clone/resources/storage_method.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sign Up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String bio,
    required String userName,
    required Uint8List file,
  }) async {
    String result = "Some Error Occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          userName.isNotEmpty ||
          bio.isNotEmpty) {
        //register the User
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        //image Url
        String photoUrl = await StorageMethods().uploadImageToStorage(
            childName: 'profilePics', file: file, isPost: false);

        //add User to the Firestore

        model.User user = model.User(
          bio: bio,
          email: email,
          followers: [],
          following: [],
          photoUrl: photoUrl,
          uid: cred.user!.uid,
          userName: userName,
        );

        await _firestore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());

        result = "Success";
      }
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  //Login User
  Future<String> logInUser({
    required String email,
    required String pass,
  }) async {
    String res = "Some Error Occured";
    try {
      if (email.isNotEmpty || pass.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
        res = "Success";
      } else {
        res = "Please Enter All the Fields";
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
