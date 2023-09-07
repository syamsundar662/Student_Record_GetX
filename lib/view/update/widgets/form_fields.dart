import 'package:flutter/material.dart';
import 'package:student_record/constants/const.dart';
import 'package:student_record/utils/validation/validation.dart';

class EditFormFieldWidget extends StatelessWidget {
  const EditFormFieldWidget({
    super.key,
    required this.controllers,
    required this.hint,
    required this.function,  this.data,
  });
  final Function function;
  final String hint;
  final TextEditingController controllers;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sHeight*.07,
      child: TextFormField(
        controller: controllers,
        validator: (value) {
          if (value!.isEmpty) {
            return '$hint is required';
          } else if (!validateFunctions(function, value)) {
            return 'enter valid $hint';
          }
          return null;
        },
        keyboardType: function == isValidAge ||
                function == isValidMobileNumber ||
                function == isValidBatch
            ? TextInputType.number
            : null,
        decoration: InputDecoration(
            fillColor: const Color.fromARGB(59, 71, 71, 85),
            filled: true,
            hintText: hint,
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
