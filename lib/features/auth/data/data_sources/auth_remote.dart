import 'dart:developer';
import 'dart:io';

import 'package:chatapp/core/constants/end_points.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/user_model.dart';
import 'package:path/path.dart';


class AuthRemote{
  final _storage = FirebaseStorage.instance;
  final _fireStore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<bool> searchIfUserExists(String uid) async {
    final dynamic user = await _fireStore.collection(EndPoints.users).where('uid',isEqualTo: uid).get();
    if(user == null || user.docs.isEmpty){
      return false;
    }
    return true;
  }

  Future saveUserData(UserModel userModel, File imageFile) async{
    await _fireStore.runTransaction((transaction) async{
      final image = await _saveImageToFirebase(imageFile);
      userModel.image = image;

      transaction.set(
          _fireStore.collection(EndPoints.users).doc(userModel.uid),
          userModel.toJson()
      );
    });
  }

  Future<String> _saveImageToFirebase(File file) async{
    final image = await _storage.ref().child('${EndPoints.storageProfileImages}/${basename(file.path)}').putFile(file);
    return await image.ref.getDownloadURL();
  }
}