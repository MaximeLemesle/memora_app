import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/core/widgets/main_app_bar.widget.dart';

class NewAlbumPage extends StatefulWidget {
  const NewAlbumPage({super.key});

  @override
  State<NewAlbumPage> createState() => _NewAlbumPageState();
}

class _NewAlbumPageState extends State<NewAlbumPage> {
  DateTime startDateTime = DateTime.now();
  DateTime endDateTime = DateTime.now().add(Duration(days: 7));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        variant: AppBarVariant.actionAppBar,
        title: 'Création d\'un album',
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
              child: Column(
                spacing: 16,
                children: [
                  /// SELECT BACKGROUND PHOTO
                  Container(
                    height: 250,
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
                      spacing: 12,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            border: Border.all(
                              width: 1,
                              color: Theme.of(context).colorScheme.outline,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.add_rounded,
                            size: 40,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        Text(
                          'Ajouter une photo de couverture',
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  /// SELECT TITLE OF THE ALBUM
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              /// START DATE
                              CupertinoButton(
                                child: Text(
                                  '${startDateTime.day} ${DateFormat('MMM', 'fr').format(startDateTime)} ${startDateTime.year}',
                                  style: Theme.of(context).textTheme.titleSmall,
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
                                              initialDateTime: startDateTime,
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              onDateTimeChanged:
                                                  (DateTime newDateTime) {
                                                setState(() {
                                                  startDateTime = newDateTime;
                                                });
                                              },
                                              mode:
                                                  CupertinoDatePickerMode.date,
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
                                  style: Theme.of(context).textTheme.titleSmall,
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
                                              backgroundColor: Theme.of(context)
                                                  .colorScheme
                                                  .surface,
                                              onDateTimeChanged:
                                                  (DateTime newDateTime) {
                                                setState(() {
                                                  endDateTime = newDateTime;
                                                });
                                              },
                                              mode:
                                                  CupertinoDatePickerMode.date,
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

                  Text(
                    'Ajouter une description (optionnel)',
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.start,
                  ),

                  /// ADD DESCRPTION OF THE ALBUM

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
                                    color:
                                        Theme.of(context).colorScheme.outline,
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
    );
  }
}
