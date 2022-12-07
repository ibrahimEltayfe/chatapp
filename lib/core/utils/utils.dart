

class Utils{
/*
  Future<File?> pickImage(bool isGallery) async{
    ImageSource source = isGallery ? ImageSource.gallery : ImageSource.camera;
    ImagePicker _picker = ImagePicker();
    // Pick multiple images
   // final List<XFile>? images = await _picker.pickMultiImage();

    try{
      final XFile? photo = await _picker.pickImage(source: source);

      if(photo != null){
        return File(photo.path);
      }else{
        return null;
      }

    }on PlatformException catch(e){
      log("Failed to pick image:$e");
      return null;
     }
  }

/*
  Future renameImage(bool isGallery) async{
    //todo:
    ImageSource source = isGallery ? ImageSource.gallery : ImageSource.camera;
    ImagePicker _picker = ImagePicker();

    final XFile? photo = await _picker.pickImage(source: source);
    String? originalPath = photo?.path;

    log('Original path: $originalPath');
    String dir = path.dirname(originalPath!);
    String newPath = path.join(dir, 'image1.jpg');
    log('NewPath: $newPath');

  }
*/

  Future saveImageToAppDirectory(bool isGallery,int id) async{
    ImageSource source = isGallery ? ImageSource.gallery : ImageSource.camera;
    ImagePicker _picker = ImagePicker();
    final XFile? photo = await _picker.pickImage(source: source);

    final String appDirectoryPath = await getApplicationDocumentsDirectory().then((value) => value.path);

    await photo!.saveTo("$appDirectoryPath/image$id.jpg");
    log('app directory path: ' + appDirectoryPath);

    return File("${appDirectoryPath}/image$id.jpg");
   // log("after saving to a new path: " + photo.path);

  }

  Future deleteImage(int id) async{
    final String appDirectoryPath = await getApplicationDocumentsDirectory().then((value) => value.path);
    await File("$appDirectoryPath/image$id.jpg").delete().then((value){log(value.path.toString());});
  }
*/
}