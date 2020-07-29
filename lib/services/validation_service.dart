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
        '$fieldName must be an correct email address.';
    }
  }

  void isStrongPassword(){
    String pwd = 'the password must have';
    if(_errorResult!=null) return;
    validateStructure(r'(?=.*?[A-Z])', '$pwd at least 1 uppercase.');
    if(_errorResult!=null) return;
    validateStructure(r'(?=.*?[a-z])', '$pwd at least 1 lowercase.');
    if(_errorResult!=null) return;
    validateStructure(r'(?=.*?[0-9])', '$pwd at least 1 numeric.');
    if(_errorResult!=null) return;
    validateStructure(r'(?=.*?[!@#\$&*~])', '$pwd  at least 1 special Character like ( ! @ # \$ & * ~ \')');
    if(_errorResult!=null) return;
  }
  /// validate if the text match the given [pattern] and set the error message with the corresponding [errorText].
  void validateStructure(String pattern, String errorText){
//    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    _errorResult = regExp.hasMatch(textToValidate) ? null: errorText;
  }
  void hasNoWhiteSpaces(){
    if(_errorResult!=null) return;
    RegExp regExp = RegExp(r'(?=.*[-\s])');
    _errorResult = !regExp.hasMatch(textToValidate) ? null: 'No whitespaces allowed.';
  }
   String errorResult() {
    return _errorResult;
  }
}
