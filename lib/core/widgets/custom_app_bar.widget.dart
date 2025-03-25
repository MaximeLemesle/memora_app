import 'package:flutter/cupertino.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leadingWidget;
  final Widget? mainWidget;
  final Widget? trailingWidget;

  const CustomAppBar({
    super.key,
    this.leadingWidget,
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
          leadingWidget ?? Container(),
          mainWidget ?? Container(),
          trailingWidget ?? Container(),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(84);
}
