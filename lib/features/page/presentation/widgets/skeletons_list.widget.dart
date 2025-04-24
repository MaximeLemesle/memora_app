import 'package:flutter/material.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/page_skeletons/image_page_skeleton.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/page_skeletons/text_page_skeleton.widget.dart';

class SkeletonsListWidget extends StatefulWidget {
  const SkeletonsListWidget({super.key});

  @override
  State<SkeletonsListWidget> createState() => _SkeletonsListWidgetState();
}

class _SkeletonsListWidgetState extends State<SkeletonsListWidget> {
  int selectedIndex = 0;
  final List<Widget> pages = [
    const TextPageSkeletonWidget(),
    const ImagePageSkeletonWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 24,
      children: [
        SizedBox(
          height: 450,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: pages.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
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
        ),
        Center(
          child: ButtonWidget(
            label: 'Ajouter la page',
            variant: ButtonVariant.primary,
            size: ButtonSize.big,
            onPressed: () {},
          ),
        )
      ],
    );
  }
}
