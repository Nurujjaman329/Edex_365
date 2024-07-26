class InputValidator {
  final String _value;
  final String _field;
  String? _message;

  InputValidator(this._value, this._field);

  InputValidator isEmpty() {
    if (_value.isEmpty) _message = "$_field is required";
    return this;
  }

  InputValidator checkLength(int length) {
    if (_message != null) return this;
    if (_value.length < length)
      _message = "$_field be at least $length characters.";
    return this;
  }

  InputValidator isValidBDPhone() {
    RegExp regex = RegExp(r"^(?:\+?88)?01[13-9]\d{8}$");
    if (!regex.hasMatch(_value)) _message = "Phone number not correct";
    return this;
  }

  InputValidator isValidEmail() {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(_value)) _message = "Email Address not correct";
    return this;
  }

  InputValidator isNumeric() {
    if (_message != null) return this;

    if (double.tryParse(_value) == null) {
      _message = 'Not a valid number';
    }

    return this;
  }

  String? validate() {
    return _message;
  }
}
