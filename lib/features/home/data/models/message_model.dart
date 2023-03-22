import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'generated_models/message_model.freezed.dart';
part 'generated_models/message_model.g.dart';

@JsonSerializable(createToJson: true)
@freezed

class MessageModel with _$MessageModel{
  const factory MessageModel({
    List<dynamic>? attachments,
    String? id,
    bool? isSeen,
    String? senderId,
    String? text,
    String? type,
    DateTime? createdAt,
    }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json){
    json['createdAt'] = (json['createdAt'] as Timestamp).toDate();

    return _$MessageModelFromJson(json);
  }

}

enum MessageType{
  text,
  image,
  video,
  voice,
  textAndImage,
  textAndVideo
}