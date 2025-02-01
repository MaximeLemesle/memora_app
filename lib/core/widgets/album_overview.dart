import 'package:flutter/material.dart';
import 'package:memora_app/features/album/presentation/album_description.dart';
import 'package:memora_app/features/album/presentation/album_pages/cover_page.dart';

class AlbumOverview extends StatelessWidget {
  const AlbumOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final albumData = {
      "title": "Voyage en Italie",
      "date_start": "2024-01-12",
      "date_end": "2024-01-24",
    };

    return SizedBox(
      height: 450,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CoverPage(
            title: albumData['title']!,
            date: '${albumData['date_start']} - ${albumData['date_end']}',
          ),
          SizedBox(height: 24),
          AlbumDescription(),
        ],
      ),
    );
  }
}
