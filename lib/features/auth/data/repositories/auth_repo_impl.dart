import 'dart:developer';
import 'package:chatapp/core/error/exceptions.dart';
import 'package:chatapp/core/error/failures.dart';
import 'package:chatapp/features/auth/domain/entities/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/constants/app_errors.dart';
import '../../../../core/utils/cache_image_manager.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote.dart';

class AuthRepositoryImpl implements AuthRepository{
  final AuthRemote _authRemote;
  final ImageCacheManager _imageCacheManager;
  AuthRepositoryImpl(this._authRemote,this._imageCacheManager);

  @override
  Future<Either<Failure, Unit>> loginWithGoogle(UserModel userModel) async{
    try{
      final UserCredential userCredential = await _authRemote.signInWithGoogle();

      if(userCredential.user == null){
        throw UIDException(AppErrors.noUID);
      }

      userModel.uid = userCredential.user!.uid;
      userModel.email = userCredential.user!.email;
      userModel.name = userCredential.user!.displayName ?? '';

      //search if user already exists
      final bool isUserExist = await _authRemote.searchIfUserExists(userCredential.user!.uid);

      //save data if user is not exist.
      if(!isUserExist){
        //cache image and upload to firebase storage
        await _saveDataToFirebase(
            userCredential.user!.photoURL,
            userModel
        );
      }

      return const Right(unit);

    }catch(e){
      log(e.toString());
      return Left(ExceptionHandler.handle(e).failure);
    }
  }

  Future _saveDataToFirebase(String? photoUrl, UserModel userModel) async{
    if(photoUrl != null && photoUrl.isNotEmpty){

      final imageFile = await _imageCacheManager.downloadGoogleProfileImage(photoUrl);

      imageFile.fold(
        (failure) => Fluttertoast.showToast(msg: failure.message),
        (results) async{
            await _authRemote.saveUserData(userModel, results);
            _imageCacheManager.clearCache();
          }
      );
    }
  }

}