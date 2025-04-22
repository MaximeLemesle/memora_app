import 'package:flutter/material.dart';
import 'package:memora_app/config/theme/app_theme.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/core/widgets/custom_app_bar.widget.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/presentation/widgets/skeletons_list.widget.dart';

class NewPagePage extends StatelessWidget {
  const NewPagePage({super.key});

  @override
  Widget build(BuildContext context) {
    final coverPage = ModalRoute.of(context)!.settings.arguments as PageEntity;
    return Scaffold(
      // appBar: _buildAppBar(context, album),
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
          Padding(
            padding: const EdgeInsets.only(top: 112),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADINGS
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 6,
                    children: [
                      /// TITLE
                      Text(
                        coverPage.title!,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ],
                  ),
                ),

                /// LIST OF PAGES
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 16,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        'Choisir un template',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),

                    /// TEMPLATES LIST
                    SkeletonsListWidget(),
                  ],
                ),

                const SizedBox(height: 24),

                Center(
                  child: ButtonWidget(
                    label: 'Sélectionner une page',
                    variant: ButtonVariant.secondary,
                    size: ButtonSize.big,
                    onPressed: () {},
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
      leadingWidget: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 16,
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
        onPressed: () => Navigator.of(context).pop(),
      ),

      /// TODO: Create a dynamic display
      trailingWidget: Text(
        '24 pages restantes',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}
