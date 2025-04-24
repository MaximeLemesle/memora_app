import 'package:flutter/material.dart';
import 'package:memora_app/features/page/presentation/widgets/page_skeletons/image_page_skeleton.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/page_skeletons/text_page_skeleton.widget.dart';

class SkeletonsListWidget extends StatelessWidget {
  const SkeletonsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Add the good skeletons here
      const TextPageSkeletonWidget(),
      const ImagePageSkeletonWidget(),
    ];

    return SizedBox(
      // Find a solution to have the scroll snap here
      height: 450,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        itemCount: pages.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) => pages[index],
      ),
    );
  }
}
