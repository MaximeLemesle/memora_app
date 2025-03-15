// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:memora_app/config/theme/app_theme.dart';

enum ButtonVariant {
  primary,
  secondary,
  ghost,
  tertiary,
}

enum ButtonSize {
  big,
  medium,
}

enum ButtonIcon {
  none,
  right,
  left,
  only,
}

enum ButtonState {
  normal,
  hover,
  active,
  disabled,
}

class ButtonWidget extends StatelessWidget {
  final String label;
  final ButtonVariant variant;
  final ButtonSize size;
  final VoidCallback onPressed;
  final ButtonIcon iconPosition;
  final ButtonState state;
  final IconData icon;
  final bool fullWidth;

  const ButtonWidget({
    super.key,
    required this.label,
    required this.variant,
    required this.size,
    required this.onPressed,
    this.iconPosition = ButtonIcon.none,
    this.state = ButtonState.normal,
    this.icon = Icons.add,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    // Button style
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    late Color backgroundColor;
    late Color foregroundColor;
    late Color borderColor;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = colorScheme.primary;
        foregroundColor = colorScheme.onPrimary;
        borderColor = colorScheme.primary;
        break;
      case ButtonVariant.secondary:
        backgroundColor = CustomColors.primary50;
        foregroundColor = colorScheme.primary;
        borderColor = colorScheme.primary;
        break;
      case ButtonVariant.ghost:
        backgroundColor = Colors.transparent;
        foregroundColor = colorScheme.onPrimary;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.tertiary:
        backgroundColor = colorScheme.surfaceContainer.withValues(alpha: 0.7);
        foregroundColor = colorScheme.onSurface;
        borderColor = Theme.of(context).colorScheme.outline;
        break;
    }

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0,
        padding: iconPosition == ButtonIcon.only
            ? EdgeInsets.all(size == ButtonSize.big ? 18 : 16)
            : EdgeInsets.symmetric(
                vertical: size == ButtonSize.big ? 16 : 12,
                horizontal: size == ButtonSize.big ? 24 : 16,
              ),
        minimumSize: fullWidth ? Size(double.infinity, 0) : Size(0, 0),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            fullWidth ? MainAxisAlignment.center : MainAxisAlignment.start,
        spacing: 8,
        children: [
          if (iconPosition == ButtonIcon.left ||
              iconPosition == ButtonIcon.only)
            Icon(
              icon,
              color: foregroundColor,
              size: size == ButtonSize.big ? 24 : 20,
            ),
          if (iconPosition != ButtonIcon.only)
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: variant == ButtonVariant.ghost
                    ? Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: foregroundColor,
                          decoration: TextDecoration.underline,
                          decorationColor: foregroundColor,
                          decorationThickness: 2,
                        )
                    : size == ButtonSize.big
                        ? Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: foregroundColor,
                            )
                        : Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: foregroundColor,
                            ),
              ),
            ),
          if (iconPosition == ButtonIcon.right)
            Icon(
              icon,
              color: foregroundColor,
            ),
        ],
      ),
    );
  }
}
