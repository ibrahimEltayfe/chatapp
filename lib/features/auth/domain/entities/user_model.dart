import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part '../../data/models/user_model.freezed.dart';
part '../../data/models/user_model.g.dart';

@unfreezed
class UserModel with _$UserModel{

 factory UserModel({
    String? uid,
    String? name,
    String? email,
    String? image,
    String? state,
    List<String?>? groupId,
  }) = _UserModel;

 factory UserModel.fromJson(Map<String, dynamic> json)
 => _$UserModelFromJson(json);
}