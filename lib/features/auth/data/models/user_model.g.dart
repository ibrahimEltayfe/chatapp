// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../domain/entities/user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      image: json['image'] as String?,
      state: json['state'] as String?,
      groupId: (json['groupId'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'email': instance.email,
      'image': instance.image,
      'state': instance.state,
      'groupId': instance.groupId,
    };
