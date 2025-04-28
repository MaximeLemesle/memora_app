import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/core/widgets/custom_app_bar.widget.dart';
import 'package:memora_app/core/widgets/input.widget.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';

class PagePage extends StatefulWidget {
  const PagePage({super.key});

  @override
  State<PagePage> createState() => _PagePageState();
}

class _PagePageState extends State<PagePage> {
  XFile? _selectedImage;

  // Pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // Actualise the background image
    setState(() {
      _selectedImage = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    final page = ModalRoute.of(context)!.settings.arguments as PageEntity;

    final pageType = page.type[0].toUpperCase() + page.type.substring(1);

    return Scaffold(
      appBar: _buildAppBar(context, pageType),
      body: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          spacing: 32,
          children: [
            /// Title of the page
            InputWidget(
              type: InputType.title,
              placeholder:
                  page.title!.isNotEmpty ? page.title! : 'Titre de la page',
              controller: TextEditingController(),
              hintStyle: Theme.of(context).textTheme.titleLarge,
              maxLines: 2,
            ),

            Column(
              spacing: 24,
              children: [
                /// Image of the page
                GestureDetector(
                  child: Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: _selectedImage == null
                          ? const DecorationImage(
                              image:
                                  AssetImage('assets/images/default_cover.jpg'),
                              fit: BoxFit.cover,
                            )
                          : DecorationImage(
                              image: FileImage(File(_selectedImage!.path)),
                              fit: BoxFit.cover,
                            ),
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: ButtonWidget(
                        label: '',
                        variant: ButtonVariant.tertiary,
                        size: ButtonSize.medium,
                        iconPosition: ButtonIcon.only,
                        icon: Icons.edit,
                        onPressed: () {
                          _pickImageFromGallery();
                        },
                      ),
                    ),
                  ),
                  onTap: () {
                    _pickImageFromGallery();
                  },
                ),

                /// Description
                InputWidget(
                  type: InputType.text,
                  placeholder: 'Ajouter une description ici...',
                  controller: TextEditingController(),
                  hintStyle: Theme.of(context).textTheme.titleLarge,
                  maxLines: 4,
                ),
              ],
            ),

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

/// Build the app bar
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
