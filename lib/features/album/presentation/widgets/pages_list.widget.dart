import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';
import 'package:memora_app/features/page/presentation/blocs/page.bloc.dart';
import 'package:memora_app/features/page/presentation/widgets/add_new.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/page_renderer.widget.dart';

class PagesListWidget extends StatefulWidget {
  final String albumId;

  const PagesListWidget({super.key, required this.albumId});

  @override
  State<PagesListWidget> createState() => _PagesListWidgetState();
}

class _PagesListWidgetState extends State<PagesListWidget> {
  @override
  void initState() {
    super.initState();
    context.read<PageBloc>().fetchPages(widget.albumId);
    context.read<AlbumBloc>().fetchAlbumById(widget.albumId);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: MediaQuery.of(context).size.width,
      child: BlocBuilder<PageBloc, PageState>(
        builder: (context, state) {
          if (state is PageLoading || state is PageInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PageLoaded) {
            final pages = state.pages;

            return PageView.builder(
              controller: PageController(viewportFraction: 0.85),
              padEnds: false,
              itemCount: pages.length + 1,
              itemBuilder: (context, index) {
                Widget child;

                if (index < pages.length) {
                  /// Fetch the pages in the album
                  final page = pages[index];
                  child = GestureDetector(
                    child: PageRendererWidget(page: page),
                    onTap: () {
                      if (page.type == 'cover') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Impossible de modifier cette page"),
                          ),
                        );
                        return;
                      }
                      Navigator.of(context).pushNamed(
                        '/page_page',
                        arguments: page,
                      );
                    },
                  );
                } else {
                  /// Add the button to create a new page
                  child = AddNewWidget(
                    text: Text(
                      'Créer une nouvelle page',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.surfaceContainer,
                          ),
                    ),
                    onPressed: () {
                      /// Get page with the type 'cover'
                      final page =
                          pages.firstWhere((page) => page.type == 'cover');

                      Navigator.of(context).pushNamed(
                        '/new_page_page',
                        arguments: page,
                      );
                    },
                  );
                }

                /// Add padding between each pages
                final isFirst = index == 0;
                final isLast = index == pages.length + 1;

                return Padding(
                  padding: EdgeInsets.only(
                    left: isFirst ? 24 : 8,
                    right: isLast ? 24 : 8,
                  ),
                  child: child,
                );
              },
            );
          } else if (state is PageError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
