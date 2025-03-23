import 'package:flutter/cupertino.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leadingWidget;
  final Widget mainWidget;
  final Widget trailingWidget;

  const CustomAppBar({
    super.key,
    required this.leadingWidget,
    required this.mainWidget,
    required this.trailingWidget,
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
          leadingWidget,
          mainWidget,
          trailingWidget,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(84);
}
