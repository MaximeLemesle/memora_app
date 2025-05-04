import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/config/theme/app_theme.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/core/widgets/custom_app_bar.widget.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/presentation/blocs/page.bloc.dart';
import 'package:memora_app/features/page/presentation/widgets/page_skeletons/image_page_skeleton.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/page_skeletons/text_page_skeleton.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/skeletons_list.widget.dart';
import 'package:uuid/uuid.dart';

class NewPagePage extends StatefulWidget {
  const NewPagePage({super.key});

  @override
  State<NewPagePage> createState() => _NewPagePageState();
}

class _NewPagePageState extends State<NewPagePage> {
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final coverPage = ModalRoute.of(context)!.settings.arguments as PageEntity;

    final skeletons = [
      const TextPageSkeletonWidget(),
      const ImagePageSkeletonWidget(),
    ];

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          /// BACKGROUND IMAGE
          Image.network(
            coverPage.backgroundImage!,
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

          /// CONTENT
          Padding(
            padding: const EdgeInsets.only(top: 112),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TITLE
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Text(
                    coverPage.title!,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),

                /// SUBTITLE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    'Choisir un template',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                  ),
                ),

                const SizedBox(height: 16),

                /// SKELETONS LIST
                SkeletonsListWidget(
                  pages: skeletons,
                  selectedIndex: selectedIndex,
                  onPageTap: (i) => setState(() => selectedIndex = i),
                ),

                const SizedBox(height: 24),

                /// BUTTON
                Center(
                  child: ButtonWidget(
                    label: 'Ajouter la page',
                    variant: ButtonVariant.primary,
                    size: ButtonSize.big,
                    onPressed: () => _createPage(albumId: coverPage.albumId),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // PreferredSizeWidget _buildAppBar(BuildContext context, AlbumEntity album) {
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      trailingWidget: Text(
        '24 pages restantes',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }

  void _createPage({required String albumId}) async {
    if (selectedIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner un template.")),
      );
      return;
    }

    // add a loader
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // Build the page entity
      final String pageType = selectedIndex == 0 ? 'text' : 'image';

      // Get the page number
      final pageBloc = context.read<PageBloc>();
      final int? pageCount = await pageBloc.getPageCountByAlbum(albumId);
      final int pageNumber;

      if (pageCount != null) {
        pageNumber = pageCount + 1;
      } else {
        return null;
      }

      final page = PageEntity(
        uid: const Uuid().v4(),
        albumId: albumId,
        type: pageType,
        pageNumber: pageNumber,
        title: '',
        texts: [],
        images: [],
      );

      // Add the page in the album
      await pageBloc.createPage(page);

      if (!mounted) return;
      Navigator.pop(context); // Close the loader
      Navigator.of(context).pushNamed(
        '/page_page',
        arguments: page,
      );
    } catch (e) {
      Navigator.pop(context); // Close the loader
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : $e")),
      );
    }
  }
}
