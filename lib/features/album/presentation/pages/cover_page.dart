import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CoverPage extends StatelessWidget {
  final String title;
  final String backgroundImage;
  final Timestamp dateStart;
  final Timestamp dateEnd;
  // final List<String> members;

  const CoverPage({
    super.key,
    required this.title,
    required this.backgroundImage,
    required this.dateStart,
    required this.dateEnd,
    // required this.members,
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
              'assets/albums/italie/$backgroundImage',
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
                      "${DateFormat('dd MMM').format(DateFormat('yyyy-MM-dd').parse(dateStart as String))} - ${DateFormat('dd MMM').format(DateFormat('yyyy-MM-dd').parse(dateEnd as String))}",
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
                    children: [
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.surfaceContainer,
                          radius: 16,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/avatar/mathilde.png'),
                            radius: 15,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 20,
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.surfaceContainer,
                          radius: 16,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/avatar/jean.png'),
                            radius: 15,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 40,
                        child: CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.surfaceContainer,
                          radius: 16,
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/avatar/marie.png'),
                            radius: 15,
                          ),
                        ),
                      ),
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
