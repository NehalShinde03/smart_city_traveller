/*
String? validateEmailAndPhone(String? value) {
  if (value == null) return null;
  value = value.trim();
  if (value.isEmpty) return "please enter email or phoneNumber";
  if (isOnlyDigit(value)) return validatePhoneNumber(value);
  if (!isEmail(value) && !isPhone(value)) return "please enter valid email or phoneNumber";
  return null;
}
*/

String? validateEmail(String? value) {
  if (value == null) return null;
  value = value.trim();
  if (value.isEmpty) return "field is mandatory";
  if (!isEmail(value)) return "please enter valid email";
  return null;
}

/*
String? validatePhoneNumber(String? value) {
  if (value == null) return null;
  value = value.trim().replaceAll(" ", "");
  if (value.isEmpty) return "please enter phone number";
  if (value.length < 7 || value.length > 15) return "please enter valid phone number";
  return null;
}
*/

/*
bool isOnlyDigit(String input) => RegExp(kOnlyDigits).hasMatch(input);

const kOnlyDigits = r'^-?[0-9]+$';
*/

/*
bool isPhone(String input) => RegExp(kPhonePattern).hasMatch(input);
*/

bool isEmail(String input) => RegExp(kEmailPattern).hasMatch(input);

const kEmailPattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{3,}))$';

/*
const kPhonePattern = r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$';
*/
