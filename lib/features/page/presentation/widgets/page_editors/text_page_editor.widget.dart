import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memora_app/core/services/pick_image.service.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/core/widgets/input.widget.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';

class TextPageEditorWidget extends StatefulWidget {
  final PageEntity page;
  const TextPageEditorWidget({super.key, required this.page});

  @override
  State<TextPageEditorWidget> createState() => _TextPageEditorWidgetState();
}

//TODO: Find why I got on error on setState

class _TextPageEditorWidgetState extends State<TextPageEditorWidget> {
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final pickedImage = await PickImage().pickImageFromGallery();
    setState(() {
      _selectedImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      children: [
        /// Title of the page
        InputWidget(
          type: InputType.title,
          placeholder: widget.page.title!.isNotEmpty
              ? widget.page.title!
              : 'Titre de la page',
          controller: TextEditingController(),
          hintStyle: Theme.of(context).textTheme.titleLarge,
          maxLines: 2,
        ),

        /// Image of the page
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              image: _selectedImage == null
                  ? const DecorationImage(
                      image: AssetImage('assets/images/default_cover.jpg'),
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

        /// Description
        InputWidget(
          type: InputType.text,
          placeholder: 'Ajouter une description ici...',
          controller: TextEditingController(),
          hintStyle: Theme.of(context).textTheme.titleLarge,
          maxLines: 4,
        ),
      ],
    );
  }
}
