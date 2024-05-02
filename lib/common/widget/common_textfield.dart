import 'package:flutter/material.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';

class CommonTextField extends StatelessWidget {
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final VoidCallback? suffixIconOnTap;
  final bool? obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged? onChanged;
  final int? maxLine;
  final String? hintText;
  // final String? prefixImagePath;
  final Color? borderColor;
  final Color? cursorColor;

  const CommonTextField({
    super.key,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconOnTap,
    this.obscureText,
    this.onChanged,
    this.validator,
    this.maxLine = 1,
    required this.controller,
    this.hintText,
    // this.prefixImagePath = "",
    this.borderColor,
    this.cursorColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText ?? false,
      style: const TextStyle(
        color: CommonColor.black,
        fontWeight: FontWeight.w400,
      ),
      cursorColor: cursorColor,
      // cursorWidth: Spacing.xSmall - 1.7,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
            color: CommonColor.grey, fontWeight: FontWeight.bold),
        hintText: hintText,
        /*filled: true,
        fillColor: CommonColor.white.withOpacity(0.2),*/
        // prefixIcon: prefixImagePath == ""
        //     ? null
        //     : Image.asset(
        //         prefixImagePath ?? "",
        //         scale: Spacing.medium + Spacing.xSmall,
        //       ),
        // prefixIcon: Icon(prefixIcon),
        suffixIcon: GestureDetector(
          onTap: suffixIconOnTap,
          child: Icon(
            suffixIcon,
            color: CommonColor.black.withOpacity(0.5),
          ),
        ),
        contentPadding: const EdgeInsetsDirectional.only(
          start: Spacing.large,
          bottom: Spacing.large,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.medium),
          borderSide: BorderSide(color: borderColor ?? CommonColor.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.medium),
          borderSide: BorderSide(color: borderColor ?? CommonColor.black),
        ),
      ),
    );
  }
}
