import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memora_app/core/widgets/button.widget.dart';

class AddPageWidget extends StatelessWidget {
  const AddPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: 300,
      padding: const EdgeInsets.all(16),
      constraints: BoxConstraints(maxWidth: 300),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).colorScheme.outline,
          ),
          color: Theme.of(context)
              .colorScheme
              .surfaceContainer
              .withValues(alpha: .5)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 16,
        children: [
          ButtonWidget(
            label: '',
            variant: ButtonVariant.tertiary,
            size: ButtonSize.big,
            iconPosition: ButtonIcon.only,
            icon: CupertinoIcons.add,
            onPressed: () {},
          ),
          Text(
            "Créer une nouvelle page",
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
          ),
        ],
      ),
    );
  }
}
