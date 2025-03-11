import 'package:flutter/material.dart';
import 'package:memora_app/features/user/presentation/widgets/avatar.widget.dart';

enum AppBarVariant { mainAppBar, actionAppBar }

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String username;
  final AppBarVariant variant;

  const MainAppBar({
    super.key,
    this.username = 'Invité',
    this.variant = AppBarVariant.mainAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return variant == AppBarVariant.mainAppBar
        ? _buildMainAppBar(context)
        : _buildActionAppBar(context);
  }

  Widget _buildMainAppBar(BuildContext context) {
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

  Widget _buildActionAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 58, 24, 6),
      color: Theme.of(context).colorScheme.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(84);
}
