import 'package:json_annotation/json_annotation.dart';
part 'sign_up_model.g.dart';

@JsonSerializable()
class SignUpModel{

  final String userId;
  final String userName;
  final String userEmail;
  final String userPassWord;
  final String userConfirmPassWord;


  SignUpModel({
    this.userId = "",
    this.userName = "",
    this.userEmail = "",
    this.userPassWord = "",
    this.userConfirmPassWord = "",
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => _$SignUpModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);

}