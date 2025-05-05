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
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  XFile? _selectedImage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.page.title ?? '');
    _descriptionController = TextEditingController(
      text: widget.page.texts != null && widget.page.texts!.isNotEmpty
          ? widget.page.texts!.first
          : '',
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
                  placeholder: 'Titre de la page',
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
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: _selectedImage != null
                            ? FileImage(File(_selectedImage!.path))
                            : widget.page.images!.isNotEmpty
                                ? NetworkImage(widget.page.images?.first)
                                : const AssetImage(
                                    'assets/images/default_cover.jpg'),
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

                /// Description
                InputWidget(
                  type: InputType.text,
                  placeholder: 'Ajouter une description ici...',
                  controller: _descriptionController,
                  hintStyle: Theme.of(context).textTheme.titleLarge,
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
    if (_selectedImage == null && widget.page.images == null) {
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
    String? downloadUrl;
    if (_selectedImage != null) {
      String filePath =
          'albums/${page.albumId}/pages/page_${page.uid}/image_${Uuid().v4()}.png';

      downloadUrl = await ImageService().saveImageToFirebaseStorage(
        _selectedImage!,
        filePath,
      );
    } else {
      downloadUrl = widget.page.images?.first;
    }

    /// Create the new page
    final updatedPage = PageEntity(
      uid: page.uid,
      albumId: page.albumId,
      type: page.type,
      pageNumber: page.pageNumber,
      title: _titleController.text,
      texts: [_descriptionController.text],
      images: [downloadUrl],
    );

    try {
      // Add the page in the album
      if (!mounted) return;
      final pageBloc = context.read<PageBloc>();
      await pageBloc.updatePage(updatedPage);

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
