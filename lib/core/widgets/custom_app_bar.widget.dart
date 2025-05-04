import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingWidget;
  final VoidCallback? onPressedBackButton;
  final Widget? mainWidget;
  final Widget? trailingWidget;

  const CustomAppBar({
    super.key,
    this.leadingWidget,
    this.onPressedBackButton,
    this.mainWidget,
    this.trailingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 58, 24, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 24,
        children: [
          leadingWidget ?? _buildBackButton(context, onPressedBackButton),
          mainWidget ?? Container(),
          trailingWidget ?? Container(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(84);
}

Widget _buildBackButton(
  BuildContext context,
  VoidCallback? onPressedBackButton,
) {
  return IconButton(
    icon: const Icon(
      Icons.arrow_back_ios_new_rounded,
      size: 16,
    ),
    style: ButtonStyle(
      padding: WidgetStatePropertyAll(
        const EdgeInsets.all(8),
      ),
      backgroundColor: WidgetStatePropertyAll(
        Theme.of(context).colorScheme.surfaceContainer.withValues(alpha: 0.7),
      ),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
      ),
    ),
    onPressed: () => onPressedBackButton ?? Navigator.of(context).pop(),
  );
}
