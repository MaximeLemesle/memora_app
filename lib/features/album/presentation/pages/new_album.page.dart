import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memora_app/core/services/image_picker.service.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/features/user/presentation/widgets/avatar.widget.dart';

class NewAlbumPage extends StatefulWidget {
  const NewAlbumPage({super.key});

  @override
  State<NewAlbumPage> createState() => _NewAlbumPageState();
}

class _NewAlbumPageState extends State<NewAlbumPage> {
  File? _selectedImage;
  final _imagePickerService = ImagePickerService();

  Future<void> _pickImageFromGallery() async {
    final image = await _imagePickerService.pickImageFromGallery();

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  // Select start and end date
  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now().add(Duration(days: 7));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// BACKGROUND IMAGE
          Container(
            decoration: BoxDecoration(
              image: _selectedImage != null
                  ? DecorationImage(
                      image: FileImage(_selectedImage!), fit: BoxFit.cover)
                  : const DecorationImage(
                      // TODO: Add a default image
                      image: AssetImage('assets/images/default_cover.jpg'),
                      fit: BoxFit.cover,
                    ),
            ),
          ),

          /// CONTENT
          SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 42),
                  child: Column(
                    spacing: 16,
                    children: [
                      /// HEADER OF THE PAGE
                      Container(
                        padding: const EdgeInsets.fromLTRB(24, 58, 24, 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 24,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    size: 20),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Création d\'un album',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                              ),
                            ),
                            const AvatarWidget(size: 'big'),
                          ],
                        ),
                      ),

                      /// SELECT BACKGROUND PHOTO
                      GestureDetector(
                        onTap: () => _pickImageFromGallery(),
                        child: SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _selectedImage != null
                                  ? Container(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.edit,
                                        size: 40,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(8),
                                      child: Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 40,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                    ),
                              Text(
                                _selectedImage != null
                                    ? 'Modifier l\'image'
                                    : 'Ajouter une photo de couverture',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// SELECT TITLE OF THE ALBUM
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainer
                              .withValues(alpha: 0.7),
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: TextField(
                                style: Theme.of(context).textTheme.titleSmall,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Ajouter une titre à mon album',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// SELECT DATE OF THE ALBUM
                      Container(
                        height: 80,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  /// START DATE
                                  CupertinoButton(
                                    child: Text(
                                      '${startDateTime.day} ${DateFormat('MMM', 'fr').format(startDateTime)} ${startDateTime.year}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: 350,
                                                width: double.infinity,
                                                child: CupertinoDatePicker(
                                                  initialDateTime:
                                                      startDateTime,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                  onDateTimeChanged:
                                                      (DateTime newDateTime) {
                                                    setState(() {
                                                      startDateTime =
                                                          newDateTime;
                                                    });
                                                  },
                                                  mode: CupertinoDatePickerMode
                                                      .date,
                                                  dateOrder:
                                                      DatePickerDateOrder.dmy,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),

                                  /// END DATE
                                  CupertinoButton(
                                    child: Text(
                                      '${endDateTime.day} ${DateFormat('MMM', 'fr').format(endDateTime)} ${endDateTime.year}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: 350,
                                                width: double.infinity,
                                                child: CupertinoDatePicker(
                                                  initialDateTime: endDateTime,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .surface,
                                                  onDateTimeChanged:
                                                      (DateTime newDateTime) {
                                                    setState(() {
                                                      endDateTime = newDateTime;
                                                    });
                                                  },
                                                  mode: CupertinoDatePickerMode
                                                      .date,
                                                  dateOrder:
                                                      DatePickerDateOrder.dmy,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// SEPARATOR
                      Container(
                        height: 1,
                        width: 200,
                        color: Theme.of(context).colorScheme.outline,
                      ),

                      /// ADD DESCRPTION OF THE ALBUM
                      Text(
                        'Ajouter une description (optionnel)',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                        textAlign: TextAlign.start,
                      ),
                      Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceContainer,
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: TextField(
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.w500),
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText:
                                      'Expliquer votre voyage, avec qui vous étiez ou encore ce que vous avez visitez...',
                                ),
                                maxLines: null,
                                keyboardType: TextInputType.multiline,
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// SEPARATOR
                      Container(
                        height: 1,
                        width: 200,
                        color: Theme.of(context).colorScheme.outline,
                      ),

                      /// ADD BUTTON
                      ButtonWidget(
                        label: 'Créer mon album',
                        variant: ButtonVariant.primary,
                        size: ButtonSize.big,
                        fullWidth: true,
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
