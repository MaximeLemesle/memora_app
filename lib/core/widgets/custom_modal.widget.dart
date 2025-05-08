import 'package:flutter/material.dart';
import 'package:memora_app/core/widgets/button.widget.dart';

class CustomModalWidget extends StatelessWidget {
  final String title;
  final String? description;

  const CustomModalWidget({
    super.key,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      content: description != null
          ? Text(
              description!,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            )
          : null,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonWidget(
              label: 'Annuler',
              variant: ButtonVariant.secondary,
              size: ButtonSize.medium,
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ButtonWidget(
              label: 'Supprimer',
              variant: ButtonVariant.danger,
              size: ButtonSize.medium,
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
