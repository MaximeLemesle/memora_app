import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memora_app/config/theme/app_theme.dart';
import 'package:memora_app/core/widgets/custom_app_bar.widget.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/presentation/widgets/pages_list.widget.dart';
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
          Padding(
            padding: const EdgeInsets.only(top: 112),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADINGS
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      /// TITLE
                      Text(
                        album.title,
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),

                      /// DATES
                      Text(
                        '${_formatDate(album.startDate)} - ${_formatDate(album.endDate)}',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ],
                  ),
                ),

                /// LIST OF PAGES
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Pages',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),

                    /// PAGES LIST
                    PagesList(albumId: album.uid),
                  ],
                ),
              ],
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

String _formatDate(Timestamp timestamp) {
  DateTime date = timestamp.toDate();
  return DateFormat('dd MMM').format(date);
}
