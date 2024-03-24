extension InputValidation on String {
  bool get isValidName {
    final nameRegExp = RegExp(r"^[a-zA-Z]+(?: [a-zA-Z0-9]+)*$");
    return nameRegExp.hasMatch(this);
  }
}
