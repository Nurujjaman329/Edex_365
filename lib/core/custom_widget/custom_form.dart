import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends FormField<String> {
  CustomFormField({
    Key? key,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String? labelText,
    String? hintText,
    Icon? prefixicon,
    IconButton? suffixIconButton,
    FocusNode? focusNode,
    final List<TextInputFormatter>? inputFormatters,
    final ValueChanged<String>? onFieldSubmitted,
    final TextEditingController? controller,
    final TextInputType? keyBoardType,
    String? initialValue,
    bool obscureText = false,
  }) : super(
    key: key,
    onSaved: onSaved,
    //validator: validator,
    initialValue: initialValue,
    builder: (FormFieldState<String> state) {
      return Padding(
        padding: const EdgeInsets.only(
          bottom: 10.0,
        ),
        child: TextFormField(
          inputFormatters: inputFormatters,
          keyboardType: keyBoardType,
          obscureText: obscureText,
          validator: validator,
          controller: controller,
          focusNode: focusNode,
          onChanged: state.didChange,
          onFieldSubmitted: onFieldSubmitted,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            prefixIcon: prefixicon,
            prefixIconConstraints:
            const BoxConstraints(minWidth: 40.0, minHeight: 40.0),
            prefixIconColor: Colors.blue,
            suffixIcon: suffixIconButton,
            errorText: state.errorText,
            border: OutlineInputBorder(),
          ),
        ),
      );
    },
  );

  @override
  FormFieldState<String> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends FormFieldState<String> {
  @override
  CustomFormField get widget => super.widget as CustomFormField;
}