import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memora_app/core/services/image.service.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/core/widgets/input.widget.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/presentation/blocs/page.bloc.dart';
import 'package:uuid/uuid.dart';

class ImagePageEditorWidget extends StatefulWidget {
  final PageEntity page;
  const ImagePageEditorWidget({super.key, required this.page});

  @override
  State<ImagePageEditorWidget> createState() => _ImagePageEditorWidgetState();
}

class _ImagePageEditorWidgetState extends State<ImagePageEditorWidget> {
  final TextEditingController _titleController = TextEditingController();
  XFile? _selectedImage;
  final TextEditingController _descriptionController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedImage = await ImageService().pickImageFromGallery();
    setState(() {
      _selectedImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 32,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              spacing: 12,
              children: [
                /// Title of the page
                InputWidget(
                  type: InputType.title,
                  placeholder: widget.page.title!.isNotEmpty
                      ? widget.page.title!
                      : 'Titre de la page',
                  controller: _titleController,
                  hintStyle: Theme.of(context).textTheme.titleLarge,
                  onChanged: (value) {
                    setState(() {});
                  },
                  maxLength: 32,
                ),

                /// Image of the page
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    height: 300,
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
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ),

                /// TODO: Fix design error in the page list of the album

                /// Description
                InputWidget(
                  type: InputType.text,
                  placeholder: 'Ajouter une description ici...',
                  controller: _descriptionController,
                  hintStyle: Theme.of(context).textTheme.titleLarge,
                  onChanged: (value) {
                    setState(() {});
                  },
                  maxLength: 150,
                ),
              ],
            ),
          ),
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
          onPressed: () => _updatePage(page: widget.page),
        ),
      ],
    );
  }

  void _updatePage({required PageEntity page}) async {
    /// Check if the title is empty
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir le titre.")),
      );
      return;
    }

    /// Check if the image is empty
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez sélectionner une image.")),
      );
      return;
    }

    /// Check if the description is empty
    if (_descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez remplir la description.")),
      );
      return;
    }

    /// Upload the image to Firebase Storage
    String filePath =
        'albums/${page.albumId}/pages/page_${page.uid}/image_${Uuid().v4()}.png';

    final downloadUrl = await ImageService().saveImageToFirebaseStorage(
      _selectedImage!,
      filePath,
    );

    /// Create the new page
    final newPage = PageEntity(
      uid: page.uid,
      albumId: page.albumId,
      type: page.type,
      texts: [_descriptionController.text],
      images: [downloadUrl],
    );

    try {
      // Add the page in the album
      if (!mounted) return;
      final pageBloc = context.read<PageBloc>();
      await pageBloc.updatePage(newPage);

      // Get the album
      if (!mounted) return;
      final albumBloc = context.read<AlbumBloc>();
      final album = await albumBloc.getAlbumById(page.albumId);

      if (!mounted) return;
      Navigator.of(context).pushNamed(
        '/album_page',
        arguments: album,
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : $e")),
      );
    }
  }
}
