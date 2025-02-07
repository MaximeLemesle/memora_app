import 'package:flutter/material.dart';
import 'package:memora_app/core/widgets/avatar.widget.dart';

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
      children: [
        // Information
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AvatarWidget(
              size: 'big',
              person: owner,
            ),
            SizedBox(width: 12),
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

        SizedBox(height: 8),

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
