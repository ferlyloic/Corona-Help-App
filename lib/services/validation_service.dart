import 'package:email_validator/email_validator.dart';

class ValidationService {
  static String minLength(String text, int minLength) {
    if (minLength < 0) throw Exception();
    return text.length < minLength
        ? 'This field must be more than $minLength charater${minLength < 2 ? '' : 's'}.'
        : null;
  }
  static String maxLength(String text, int maxLength) {
    if (maxLength < 0) throw Exception();
    return text.length > maxLength
        ? 'This field cannot be more than $maxLength charater${maxLength < 2 ? '' : 's'}.'
        : null;
  }
  static String isEmail(String text) {
    return EmailValidator.validate(text)? null:
        'This field must be a correct email address';
  }
  static String multipleValidation(List<String> validationResultList) {
    for (String result in validationResultList){
      if (result != null) return result;
    }
    return null;
  }
}
