// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      attachmentUrl: json['attachmentUrl'] as String?,
      id: json['id'] as String?,
      isSeen: json['isSeen'] as bool?,
      senderId: json['senderId'] as String?,
      text: json['text'] as String?,
      type: json['type'] as String?,
      createdAt: json['createdAt'] as DateTime?,
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'attachmentUrl': instance.attachmentUrl,
      'id': instance.id,
      'isSeen': instance.isSeen,
      'senderId': instance.senderId,
      'text': instance.text,
      'type': instance.type,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
