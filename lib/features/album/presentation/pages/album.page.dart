import 'package:flutter/material.dart';
import 'package:memora_app/config/theme/app_theme.dart';
import 'package:memora_app/core/widgets/custom_app_bar.widget.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/user/presentation/widgets/avatar.widget.dart';

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    final album = ModalRoute.of(context)!.settings.arguments as AlbumEntity;
    return Scaffold(
      appBar: _buildAppBar(context, album),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          /// BACKGROUND IMAGE
          Image.network(
            album.backgroundImage,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CustomColors.neutral900.withValues(alpha: .5),
                  Colors.transparent
                ],
                stops: [0, 0.3],
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, AlbumEntity album) {
    return CustomAppBar(
      leadingWidget: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 16,
        ),
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            const EdgeInsets.all(8),
          ),
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context)
                .colorScheme
                .surfaceContainer
                .withValues(alpha: 0.7),
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
        onPressed: () => Navigator.of(context).pop(),
      ),
      mainWidget: Expanded(
        child: SizedBox(
          height: 32,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: album.members!.asMap().entries.map((entry) {
              final index = entry.key;
              return Transform.translate(
                offset: Offset(index * 20.0, 0),
                child: AvatarWidget(size: 'medium'),
              );
            }).toList(),
          ),
        ),
      ),
      trailingWidget: IconButton(
        icon: Icon(
          Icons.delete_outlined,
          size: 16,
          color: Theme.of(context).colorScheme.error,
        ),
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            const EdgeInsets.all(8),
          ),
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context)
                .colorScheme
                .surfaceContainer
                .withValues(alpha: 0.7),
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
        onPressed: () {},
      ),
    );
  }
}
