// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpModel _$SignUpModelFromJson(Map<String, dynamic> json) => SignUpModel(
      userId: json['userId'] as String? ?? "",
      userName: json['userName'] as String? ?? "",
      userEmail: json['userEmail'] as String? ?? "",
      userPassWord: json['userPassWord'] as String? ?? "",
      userConfirmPassWord: json['userConfirmPassWord'] as String? ?? "",
    );

Map<String, dynamic> _$SignUpModelToJson(SignUpModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'userEmail': instance.userEmail,
      'userPassWord': instance.userPassWord,
      'userConfirmPassWord': instance.userConfirmPassWord,
    };
