import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/core/widgets/custom_app_bar.widget.dart';
import 'package:memora_app/core/widgets/custom_modal.widget.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/presentation/blocs/page.bloc.dart';
import 'package:memora_app/features/page/presentation/widgets/page_editors/image_page_editor.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/page_editors/text_page_editor.widget.dart';

class PagePage extends StatefulWidget {
  const PagePage({super.key});

  @override
  State<PagePage> createState() => _PagePageState();
}

class _PagePageState extends State<PagePage> {
  @override
  Widget build(BuildContext context) {
    final page = ModalRoute.of(context)!.settings.arguments as PageEntity;

    return Scaffold(
      appBar: _buildAppBar(page),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _buildEditorPageType(page),
      ),
    );
  }

  /// Build the app bar
  PreferredSizeWidget _buildAppBar(PageEntity page) {
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
        onPressed: () async {
          /// Afficher le dialogue de confirmation
          final confirm = await showDialog<bool>(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return CustomModalWidget(
                title: 'Supprimer la page ?',
                description: 'Es-tu sûr de vouloir supprimer cette page ?\n'
                    'Cette action est irréversible.',
              );
            },
          );

          if (confirm != true || !mounted) return;

          /// Delete the page
          await context.read<PageBloc>().deletePage(page);

          /// Get the album without the page and pop the page
          if (!mounted) return;
          final album =
              await context.read<AlbumBloc>().getAlbumById(page.albumId);

          if (!mounted) return;
          Navigator.of(context).pushNamed(
            '/album_page',
            arguments: album,
          );
        },
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
