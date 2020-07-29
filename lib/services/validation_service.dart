import 'package:email_validator/email_validator.dart';

class ValidationService {
  String textToValidate;
  String _errorResult;
  String fieldName;
  ValidationService(String textToValidate,{this.fieldName = 'This field'}){
    this.textToValidate = textToValidate;

  }
//  check if the text to validate is not empty.
  bool isNotNull() {
    if(this.textToValidate == null){
      _errorResult = '$fieldName cannot be empty.';
      return false;
    }
    return true;
  }

  void minLength(int minLength) {
    if (isNotNull() && _errorResult == null) {
      if (minLength < 0) throw Exception();
      _errorResult = textToValidate.length < minLength
          ? '$fieldName must be more than $minLength character${minLength < 2 ? '' : 's'}.'
          : null;
    }
  }

  void maxLength(int maxLength) {
    if (isNotNull() && _errorResult == null) {
      if (maxLength < 0) throw Exception();
      _errorResult = textToValidate.length > maxLength
          ? '$fieldName cannot be more than $maxLength character${maxLength < 2 ? '' : 's'}.'
          : null;
    }
  }

  void isEmail() {
    if (isNotNull() && _errorResult == null) {
      _errorResult = EmailValidator.validate(textToValidate)? null:
        '$fieldName must be an correct email address';
    }
  }
   String errorResult() {
    return _errorResult;
  }
}
