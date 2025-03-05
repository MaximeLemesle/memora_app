import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memora_app/features/user/presentation/widgets/avatar.widget.dart';

class CoverPage extends StatelessWidget {
  final String title;
  final String backgroundImage;
  final Timestamp dateStart;
  final Timestamp dateEnd;
  final List<String> members;

  const CoverPage({
    super.key,
    required this.title,
    required this.backgroundImage,
    required this.dateStart,
    required this.dateEnd,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.transparent,
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/albums/$backgroundImage/$backgroundImage-bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                    ),
                    Text(
                      "${formatDate(dateStart)} - ${formatDate(dateEnd)}",
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: members
                        .asMap()
                        .map((index, member) {
                          return MapEntry(
                            index,
                            Positioned(
                              right: index * 20,
                              child: AvatarWidget(
                                size: 'medium',
                                person: member,
                              ),
                            ),
                          );
                        })
                        .values
                        .toList(),
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

String formatDate(Timestamp timestamp) {
  final DateTime dateTime = timestamp.toDate();
  return DateFormat('dd MMM').format(dateTime);
}
