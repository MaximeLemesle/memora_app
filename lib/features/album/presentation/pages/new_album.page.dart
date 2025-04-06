import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memora_app/config/theme/app_theme.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/features/album/domain/entities/album.entity.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';
import 'package:memora_app/features/user/presentation/widgets/avatar.widget.dart';
import 'package:uuid/uuid.dart';

class NewAlbumPage extends StatefulWidget {
  const NewAlbumPage({super.key});

  @override
  State<NewAlbumPage> createState() => _NewAlbumPageState();
}

class _NewAlbumPageState extends State<NewAlbumPage> {
  XFile? _selectedImage;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  // Pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    // Actualise the background image
    setState(() {
      _selectedImage = pickedFile;
    });
  }

  // Save the album
  void _saveAlbum() async {
    // Check if the title is empty
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Veuillez ajouter un titre à l'album.")),
      );
      return;
    }

    // Check if the background image is not selected
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez ajouter une photo de couverture."),
        ),
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
      // Upload the background image to Firebase Storage
      final firebaseStorage = FirebaseStorage.instance;
      File file = File(_selectedImage!.path);
      String albumId = const Uuid().v4();
      String filePath = 'albums/$albumId/${albumId}_background.png';

      final bytes = await file.readAsBytes();

      final uploadTask = await firebaseStorage.ref(filePath).putData(
            bytes,
            SettableMetadata(contentType: 'image/jpeg'),
          );

      final downloadUrl = await uploadTask.ref.getDownloadURL();

      // Build the album entity
      final album = AlbumEntity(
        uid: albumId,
        title: _titleController.text,
        description: _descriptionController.text,
        ownerId: FirebaseAuth.instance.currentUser!.uid,
        backgroundImage: downloadUrl,
        startDate: startDateTime,
        endDate: endDateTime,
        members: [],
      );

      // Create the album
      if (!mounted) return;
      final albumBloc = context.read<AlbumBloc>();
      await albumBloc.createAlbum(album);

      // Success message
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Album créé avec succès !")),
      );

      Navigator.pop(context); // Close the loader
      Navigator.pop(context, true);
    } catch (e) {
      Navigator.pop(context); // Close the loader
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur : $e")),
      );
    }
  }

  // Select start and end date
  Timestamp startDateTime = Timestamp.now();
  Timestamp endDateTime = Timestamp.fromDate(
    Timestamp.now().toDate().add(const Duration(days: 7)),
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<AlbumBloc, AlbumState>(
      listener: (context, state) {
        if (state is AlbumSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Album créé avec succès !")),
          );
        } else if (state is AlbumError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            /// BACKGROUND IMAGE
            Container(
              decoration: BoxDecoration(
                image: _selectedImage != null
                    ? DecorationImage(
                        image: FileImage(File(_selectedImage!.path)),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: AssetImage('assets/images/default_cover.jpg'),
                        fit: BoxFit.cover,
                      ),
              ),
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
                          padding: const EdgeInsets.only(top: 58),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 24,
                            children: [
                              IconButton(
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                      ),
                                    ),
                                  ),
                                ),
                                onPressed: () => Navigator.of(context).pop(),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 96,
                            horizontal: 64,
                          ),
                          child: ButtonWidget(
                            label: _selectedImage != null
                                ? 'Modifier'
                                : 'Ajouter une photo de couverture',
                            variant: ButtonVariant.tertiary,
                            size: ButtonSize.medium,
                            iconPosition: ButtonIcon.left,
                            icon: _selectedImage != null
                                ? Icons.edit
                                : Icons.add_photo_alternate_outlined,
                            onPressed: () {
                              _pickImageFromGallery();
                            },
                          ),
                        ),

                        /// SELECT TITLE OF THE ALBUM
                        Container(
                          constraints: const BoxConstraints(minHeight: 80),
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
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                child: TextField(
                                  controller: _titleController,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Ajouter un titre',
                                  ),
                                  maxLength: 25,
                                  maxLines: null,
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    /// START DATE
                                    CupertinoButton(
                                      child: Text(
                                        '${startDateTime.toDate().day} ${DateFormat('MMM', 'fr').format(startDateTime.toDate())} ${startDateTime.toDate().year}',
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
                                                        startDateTime.toDate(),
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    onDateTimeChanged:
                                                        (DateTime newDateTime) {
                                                      setState(() {
                                                        startDateTime =
                                                            Timestamp.fromDate(
                                                                newDateTime);
                                                      });
                                                    },
                                                    mode:
                                                        CupertinoDatePickerMode
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
                                        '${endDateTime.toDate().day} ${DateFormat('MMM', 'fr').format(endDateTime.toDate())} ${endDateTime.toDate().year}',
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
                                                        endDateTime.toDate(),
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .surface,
                                                    onDateTimeChanged:
                                                        (DateTime newDateTime) {
                                                      setState(() {
                                                        endDateTime =
                                                            Timestamp.fromDate(
                                                                newDateTime);
                                                      });
                                                    },
                                                    mode:
                                                        CupertinoDatePickerMode
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

                        /// ADD DESCRIPTION OF THE ALBUM
                        Container(
                          constraints: const BoxConstraints(minHeight: 150),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Ajouter une description',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    Text(
                                      ' (optionnel)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall
                                          ?.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surfaceContainerHighest,
                                          ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 106,
                                  child: TextField(
                                    controller: _descriptionController,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(fontStyle: FontStyle.italic),
                                    textAlign: TextAlign.start,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText:
                                          'Expliquer votre voyage, avec qui vous étiez ou encore ce que vous avez visitez...',
                                      // counterText:
                                      //     '${_descriptionController.text.length}/150',
                                    ),
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    maxLength: 150,
                                    onChanged: (value) {
                                      setState(() {});
                                    },
                                    expands: true,
                                  ),
                                ),
                              ],
                            ),
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
                          onPressed: _saveAlbum,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
