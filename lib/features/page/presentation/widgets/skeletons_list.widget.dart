import 'package:flutter/material.dart';

class SkeletonsListWidget extends StatelessWidget {
  final List<Widget> pages;
  final int? selectedIndex;

  final ValueChanged<int> onPageTap;

  const SkeletonsListWidget({
    super.key,
    required this.pages,
    required this.selectedIndex,
    required this.onPageTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: pages.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onPageTap(index),
            child: Stack(
              children: [
                pages[index],
                if (isSelected)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.primary,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
