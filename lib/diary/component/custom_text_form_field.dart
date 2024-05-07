import 'package:emoshare_diary/common/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final ValueKey? valueKey;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool filled;
  final TextEditingController? textEditingController;
  final int? maxLines;
  final int? minLines;
  final String? initialValue;
  final bool autofocus;
  final FocusNode? focusNode;
  final void Function(String)? onChanged;
  final InputBorder inputBorder;

  const CustomTextFormField({
    super.key,
    this.valueKey,
    this.validator,
    this.onSaved,
    this.hintText,
    this.inputFormatters,
    this.keyboardType,
    this.initialValue,
    this.readOnly = false,
    this.filled = false,
    this.textEditingController,
    this.maxLines = 1,
    this.minLines = 1,
    this.autofocus = false,
    this.focusNode,
    this.onChanged,
    this.inputBorder = InputBorder.none,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: valueKey,
      validator: validator,
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      keyboardType: keyboardType,
      initialValue: initialValue,
      readOnly: readOnly,
      autofocus: autofocus,
      focusNode: focusNode,
      onChanged: onChanged,
      controller: textEditingController,
      style: const TextStyle(decorationThickness: 0),
      cursorColor: PRIMARY_COLOR,
      maxLines: maxLines,
      minLines: minLines,
      decoration: InputDecoration(
        enabledBorder: inputBorder,
        focusedBorder: inputBorder,
        errorBorder: inputBorder,
        focusedErrorBorder: inputBorder,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14, color: Colors.grey),
        contentPadding: const EdgeInsets.all(10.0),
        fillColor: Colors.grey.shade300,
        filled: filled,
      ),
    );
  }
}
