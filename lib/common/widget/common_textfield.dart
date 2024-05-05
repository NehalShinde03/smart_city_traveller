import 'package:flutter/material.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';

class CommonTextField extends StatelessWidget {
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final VoidCallback? suffixIconOnTap;
  final bool? obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final int maxLine;
  final String hintText;
  // final String? prefixImagePath;
  final Color borderColor;
  final Color cursorColor;
  final bool isSuffixIconSet;
  // final FocusNode? focusNode;


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
    this.hintText = "",
    this.borderColor = CommonColor.black,
    this.cursorColor = CommonColor.black,
    this.isSuffixIconSet = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
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
      cursorWidth: Spacing.xSmall - 1.7,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
            color: CommonColor.grey, fontWeight: FontWeight.bold),
        hintText: hintText,
        suffixIcon: suffixIcon,
        //  ? GestureDetector(
        //   onTap: suffixIconOnTap,
        //   child: Container(
        //     padding: PaddingValue.zero,
        //     color: CommonColor.green,
        //       width: 5,
        //       height: 5,
        //       child: suffixIcon,
        //   ),
        // )
        //  : Container(
        //   width: 5,
        //   height: 5,
        //   color: Colors.red,
        // ),
        /* suffixIcon: GestureDetector(
          onTap: suffixIconOnTap,
          child: Icon(
            suffixIcon,
            color: CommonColor.black.withOpacity(0.5),
          ),
        ),*/
        contentPadding: const EdgeInsetsDirectional.only(
          start: Spacing.large,
          bottom: Spacing.large,
          end: Spacing.medium
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.medium),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.medium),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}



/*import 'package:flutter/material.dart';
import 'package:smart_city_traveller/common/common_colors.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';

class CommonTextField extends StatelessWidget {
  final Widget? suffixIcon;
  final IconData? prefixIcon;
  final VoidCallback? suffixIconOnTap;
  final bool? obscureText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final int maxLine;
  final String hintText;
  // final String? prefixImagePath;
  final Color borderColor;
  final Color cursorColor;
  final bool isSuffixIconSet;
  // final FocusNode? focusNode;


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
    this.hintText = "",
    this.borderColor = CommonColor.black,
    this.cursorColor = CommonColor.black,
    this.isSuffixIconSet = false
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
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
      cursorWidth: Spacing.xSmall - 1.7,
      decoration: InputDecoration(
        hintStyle: const TextStyle(
            color: CommonColor.grey, fontWeight: FontWeight.bold),
        hintText: hintText,
        suffixIcon: isSuffixIconSet
         ? GestureDetector(
          onTap: suffixIconOnTap,
          child: Container(
            padding: PaddingValue.zero,
            color: CommonColor.green,
              width: 5,
              height: 5,
              child: suffixIcon,
          ),
        )
         : Container(
          width: 5,
          height: 5,
          color: Colors.red,
        ),
        /* suffixIcon: GestureDetector(
          onTap: suffixIconOnTap,
          child: Icon(
            suffixIcon,
            color: CommonColor.black.withOpacity(0.5),
          ),
        ),*/
        contentPadding: const EdgeInsetsDirectional.only(
          start: Spacing.large,
          bottom: Spacing.large,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.medium),
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Spacing.medium),
          borderSide: BorderSide(color: borderColor),
        ),
      ),
    );
  }
}
*/