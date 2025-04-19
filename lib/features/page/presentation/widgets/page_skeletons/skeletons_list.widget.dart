import 'package:flutter/material.dart';
import 'package:memora_app/features/page/presentation/widgets/add_new.widget.dart';

class SkeletonsListWidget extends StatelessWidget {
  const SkeletonsListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      // Add the good skeletons here
      AddNewWidget(text: Text('test'), onPressed: () {}),
      AddNewWidget(text: Text('test'), onPressed: () {}),
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
    //   return SizedBox(
    //     height: 450,
    //     width: MediaQuery.of(context).size.width,
    //     child: BlocBuilder<PageBloc, PageState>(
    //       builder: (context, state) {
    //         if (state is PageLoading || state is PageInitial) {
    //           return const Center(child: CircularProgressIndicator());
    //         } else if (state is PageLoaded) {
    //           final pages = state.pages;

    //           return PageView.builder(
    //             controller: PageController(viewportFraction: 0.85),
    //             padEnds: false,
    //             itemCount: pages.length + 1,
    //             itemBuilder: (context, index) {
    //               Widget child;

    //               if (index < pages.length) {
    //                 /// Fetch the pages in the album
    //                 final page = pages[index];
    //                 child = PageRendererWidget(page: page);
    //               } else {
    //                 /// Add the button to create a new page
    //                 child = AddNewWidget(
    //                   text: Text(
    //                     'Créer une nouvelle page',
    //                     style: Theme.of(context).textTheme.titleSmall?.copyWith(
    //                           color:
    //                               Theme.of(context).colorScheme.surfaceContainer,
    //                         ),
    //                   ),
    //                   onPressed: () {
    //                     /// Get page with the type 'cover'
    //                     final page =
    //                         pages.firstWhere((page) => page.type == 'cover');

    //                     Navigator.of(context).pushNamed(
    //                       '/new_page_page',
    //                       arguments: page,
    //                     );
    //                   },
    //                 );
    //               }

    //               /// Add padding between each pages
    //               final isFirst = index == 0;
    //               final isLast = index == pages.length + 1;

    //               return Padding(
    //                 padding: EdgeInsets.only(
    //                   left: isFirst ? 24 : 8,
    //                   right: isLast ? 24 : 8,
    //                 ),
    //                 child: child,
    //               );
    //             },
    //           );
    //         } else if (state is PageError) {
    //           return Center(child: Text(state.message));
    //         } else {
    //           return const Center(child: CircularProgressIndicator());
    //         }
    //       },
    //     ),
    //   );
    // }
  }
}
