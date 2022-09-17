import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../themes/colors.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.formKey,
    this.radius = const BorderRadius.all(Radius.circular(10.0)),
    this.textColor = Colors.red,
    this.maxLength = 16,
    this.hintText = "",
    this.hintTextStyle = const TextStyle(fontSize: 13),
    this.obscureText = false,
    this.onChanged,
    this.validator
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final BorderRadius radius;
  final Color textColor;
  final int maxLength;
  final String hintText;
  final TextStyle hintTextStyle;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  @override
  State<CustomTextField> createState() => _CustomTextField();
}

class _CustomTextField extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
        key: widget.formKey,
        child: TextFormField(
          onChanged: widget.onChanged,
          validator: widget.validator,
          inputFormatters: [
            LengthLimitingTextInputFormatter(widget.maxLength),
          ],
          decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorLightBlue, width: 3),
                  borderRadius: widget.radius),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 3),
                  borderRadius: widget.radius),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red, width: 3),
                  borderRadius: widget.radius),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorGrey, width: 1),
              ),
              hintText: widget.hintText,
              hintStyle: widget.hintTextStyle,
              contentPadding: const EdgeInsets.all(10)),
          obscureText: widget.obscureText,
        ));
  }
}
