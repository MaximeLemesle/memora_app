import 'package:flutter/material.dart';

class CoverPage extends StatelessWidget {
  final String title;
  final String date;

  const CoverPage({super.key, required this.title, required this.date});

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
              'assets/albums/italie/italie-1.png',
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
                      date,
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
