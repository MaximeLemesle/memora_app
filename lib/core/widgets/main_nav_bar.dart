import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainNavBar extends StatelessWidget {
  const MainNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(
                Theme.of(context).colorScheme.primary,
              ),
              padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 12, horizontal: 6)),
              fixedSize: WidgetStateProperty.all(Size(56, 56)),
              shape: WidgetStateProperty.all<OutlinedBorder>(
                CircleBorder(),
              ),
              elevation: WidgetStateProperty.all(2),
            ),
            child: SvgPicture.asset(
              'assets/logo/logo-light-icon.svg',
              width: 28,
              height: 28,
            ),
          )
        ],
      ),
    );
  }
}
