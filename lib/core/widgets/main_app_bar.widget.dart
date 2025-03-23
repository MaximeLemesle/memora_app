import 'package:flutter/material.dart';
import 'package:memora_app/features/user/presentation/widgets/avatar.widget.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final String title;

  const MainAppBar({
    super.key,
    this.username = 'Invité',
    this.title = 'Page title',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(24, 58, 24, 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bonjour',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              Row(
                children: [
                  Text(
                    username,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  const SizedBox(width: 6),
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14159),
                    child: const Text(
                      "👋",
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const AvatarWidget(size: 'big'),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(84);
}
