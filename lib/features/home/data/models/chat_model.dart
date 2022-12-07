import 'package:freezed_annotation/freezed_annotation.dart';
import 'message_model.dart';
import 'package:flutter/foundation.dart';

part 'generated_models/chat_model.freezed.dart';
part 'generated_models/chat_model.g.dart';

@JsonSerializable(createToJson: true)
@freezed
class ChatModel with _$ChatModel{

  const factory ChatModel({
    String? chatId,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json)
  => _$ChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatModelToJson(this);
}
