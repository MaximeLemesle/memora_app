import 'package:flutter/material.dart';
import 'package:memora_app/config/theme/app_theme.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool obscureText;
  final TextEditingController? controller;
  final IconData? icon;
  final bool isRelatedText;
  final String? relatedText;

  const InputWidget({
    super.key,
    required this.label,
    required this.placeholder,
    this.obscureText = false,
    this.controller,
    this.icon,
    this.isRelatedText = false,
    this.relatedText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            hintText: placeholder,
            hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: CustomColors.neutral500,
                ),
          ),
        ),
      ],
    );
  }
}
