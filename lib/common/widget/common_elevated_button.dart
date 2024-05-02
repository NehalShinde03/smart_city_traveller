import 'package:flutter/material.dart';
import 'package:smart_city_traveller/common/common_spacing.dart';
import 'package:smart_city_traveller/common/widget/common_text.dart';
class CommonElevatedButton extends StatelessWidget {

  final Color buttonColor;
  final Color textColor;
  final String text;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final EdgeInsetsDirectional? edgeInsetsDirectional;

  const CommonElevatedButton({
    super.key,
    this.buttonColor = Colors.teal,
    this.text = "",
    this.textColor = Colors.white,
    this.onPressed,
    this.borderRadius,
    this.edgeInsetsDirectional
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor,
        padding: edgeInsetsDirectional,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 20)
        ),
      ),
      child: CommonText(text: text, textColor: textColor, fontWeight: TextWeight.bold),
    );
  }
}
