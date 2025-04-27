import 'package:flutter/material.dart';
import 'package:memora_app/core/widgets/custom_app_bar.widget.dart';
import 'package:memora_app/core/widgets/input.widget.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';

class PagePage extends StatelessWidget {
  const PagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final page = ModalRoute.of(context)!.settings.arguments as PageEntity;

    final pageType = page.type[0].toUpperCase() + page.type.substring(1);

    return Scaffold(
      appBar: _buildAppBar(context, pageType),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            /// Title of the page
            InputWidget(
              type: InputType.title,
              placeholder:
                  page.title!.isNotEmpty ? page.title! : 'Titre de la page',
              controller: TextEditingController(),
              hintStyle: Theme.of(context).textTheme.titleLarge,
              maxLines: 2,
              keyboardType: TextInputType.multiline,
            ),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context, String pageType) {
  return CustomAppBar(
    mainWidget: Expanded(
      child: Center(
        child: Text(
          '$pageType page',
          style: Theme.of(context).textTheme.labelSmall,
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
          Theme.of(context).colorScheme.surfaceContainer.withValues(alpha: 0.7),
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
