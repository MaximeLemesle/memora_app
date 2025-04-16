import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:memora_app/config/theme/app_theme.dart';
import 'package:memora_app/features/user/presentation/widgets/avatar.widget.dart';

class AlbumCoverWidget extends StatelessWidget {
  final String title;
  final String backgroundImage;
  final Timestamp startDate;
  final Timestamp endDate;
  final List<String> members;

  const AlbumCoverWidget({
    super.key,
    required this.title,
    required this.backgroundImage,
    required this.startDate,
    required this.endDate,
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
            child: Image.network(
              backgroundImage,
              fit: BoxFit.cover,
              height: 450,
            ),
          ),
          // Add a gradient to make the text more readable
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  CustomColors.neutral900.withValues(alpha: .8),
                  Colors.transparent
                ],
                stops: [0, 0.5],
              ),
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
                      "${formatDate(startDate)} - ${formatDate(endDate)}",
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
