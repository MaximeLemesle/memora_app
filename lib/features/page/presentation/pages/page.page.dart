import 'package:flutter/material.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/core/widgets/custom_app_bar.widget.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/presentation/widgets/page_editors/image_page_editor.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/page_editors/text_page_editor.widget.dart';

class PagePage extends StatelessWidget {
  const PagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final page = ModalRoute.of(context)!.settings.arguments as PageEntity;

    return Scaffold(
      appBar: _buildAppBar(context, page),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 24,
          children: [
            /// Add the editor for the page type
            _buildEditorPageType(page),

            /// Separator
            Container(
              height: 1,
              width: 300,
              color: Theme.of(context).colorScheme.outline,
            ),

            /// Save button
            ButtonWidget(
              label: 'Valider la page',
              variant: ButtonVariant.primary,
              size: ButtonSize.big,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

/// Build the editor page type
Widget _buildEditorPageType(PageEntity page) {
  switch (page.type) {
    case 'text':
      return TextPageEditorWidget(page: page);
    case 'image':
      return ImagePageEditorWidget(page: page);
    default:
      return Center(child: Text("Type de page inconnu : ${page.type}"));
  }
}

/// Build the app bar
PreferredSizeWidget _buildAppBar(BuildContext context, PageEntity page) {
  final pageType = page.type[0].toUpperCase() + page.type.substring(1);

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
