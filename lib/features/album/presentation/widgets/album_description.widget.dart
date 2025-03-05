import 'package:flutter/material.dart';
import 'package:memora_app/features/user/presentation/widgets/avatar.widget.dart';

class AlbumDescription extends StatelessWidget {
  final String owner;
  final String description;
  final int totalPages;
  final int usedPages;

  const AlbumDescription(
      {super.key,
      required this.owner,
      required this.description,
      required this.totalPages,
      required this.usedPages});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        // Information
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          spacing: 12,
          children: [
            AvatarWidget(
              size: 'big',
              person: owner,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Crée par ${owner[0].toUpperCase()}${owner.substring(1)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                Text(
                  '${totalPages - usedPages} pages restantes',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
              ],
            )
          ],
        ),

        // Description
        SizedBox(
          width: 300,
          child: Text(
            description,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
