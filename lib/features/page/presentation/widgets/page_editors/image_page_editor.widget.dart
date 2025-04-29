import 'package:flutter/material.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';

class ImagePageEditorWidget extends StatelessWidget {
  final PageEntity page;
  const ImagePageEditorWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Cette page permet d’ajouter une image !',
        style: TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }
}
