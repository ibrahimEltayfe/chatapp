import 'dart:developer';
import 'dart:io';
import 'package:chatapp/core/constants/app_errors.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error/failures.dart';

final imageCacheManagerProvider = Provider.autoDispose<ImageCacheManager>((ref) {
  return ImageCacheManager();
});

class ImageCacheManager {
  Future<Either<Failure,File>> downloadGoogleProfileImage(imageUrl) async {
    try{
      final FileInfo fileInfo = await DefaultCacheManager().downloadFile(imageUrl);

      // Put the image file in the cache
      File cachedImageFile = await _cacheImageInFile(fileInfo);

      if(cachedImageFile.path.isEmpty){
        return const Left(ImageCacheFailure(AppErrors.fetchedProfileImageIsNull));
      }

      return Right(cachedImageFile);
    }catch(e){
      log(e.toString());
      return const Left(ImageCacheFailure(AppErrors.fetchedProfileImageIsNull));
    }

  }

  Future<File> _cacheImageInFile(FileInfo fileInfo) async{
   return await DefaultCacheManager().putFile(
      fileInfo.originalUrl,
      fileInfo.file.readAsBytesSync(),
      fileExtension: "png",
    );
  }

  Future clearCache() async{
    await DefaultCacheManager().emptyCache();
  }
}