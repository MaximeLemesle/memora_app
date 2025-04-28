import 'package:flutter/material.dart';
import 'package:memora_app/config/theme/app_theme.dart';

enum InputType {
  title,
  text,
}

class InputWidget extends StatelessWidget {
  final InputType type;
  final String placeholder;
  final TextEditingController controller;
  final String? label;
  final bool obscureText;
  final TextStyle? hintStyle;
  final int maxLines;

  const InputWidget({
    super.key,
    required this.type,
    required this.placeholder,
    required this.controller,
    this.label,
    this.obscureText = false,
    this.hintStyle,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    late final TextStyle? inputTextStyle;
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    final Color outlineColor = Theme.of(context).colorScheme.outline;
    final BorderRadius borderRadius = BorderRadius.circular(4.0);

    switch (type) {
      case InputType.title:
        inputTextStyle = Theme.of(context).textTheme.titleLarge;
        break;
      case InputType.text:
        inputTextStyle = Theme.of(context).textTheme.labelSmall;
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          maxLines: maxLines,
          style: inputTextStyle,
          decoration: InputDecoration(
            // input inactif
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide.none,
            ),

            // input actif
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: outlineColor),
            ),

            // input focus
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: primaryColor),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            hintText: placeholder,
            hintStyle: inputTextStyle?.copyWith(
              color: CustomColors.neutral500,
            ),
          ),
        ),
      ],
    );
  }
}
