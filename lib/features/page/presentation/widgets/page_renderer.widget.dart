import 'package:flutter/material.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/presentation/widgets/page_types/cover_page.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/page_types/description_page.widget.dart';

class PageRendererWidget extends StatelessWidget {
  final PageEntity page;

  const PageRendererWidget({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    switch (page.type) {
      case 'cover':
        return CoverPageWidget(page: page);
      case 'description':
        return DescriptionPageWidget(page: page);
      default:
        return Text('Unknown page type: ${page.type}');
      //   return UnknownPageWidget(page: page);
    }
  }
}
