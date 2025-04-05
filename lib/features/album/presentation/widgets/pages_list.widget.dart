import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/album/presentation/blocs/album.bloc.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/presentation/blocs/page.bloc.dart';
import 'package:memora_app/features/page/presentation/widgets/add_new.widget.dart';
import 'package:memora_app/features/page/presentation/widgets/cover_page.widget.dart';

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
        builder: (context, pageState) {
          if (pageState is PageLoading || pageState is PageInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (pageState is PageLoaded) {
            final pages = pageState.pages;

            return PageView.builder(
              controller: PageController(viewportFraction: 0.85),
              padEnds: false,
              itemCount: pages.length + 2,
              itemBuilder: (context, index) {
                Widget child;

                if (index == 0) {
                  /// Add the album cover page
                  child = _AlbumCoverPage(albumId: widget.albumId);
                } else if (index < pages.length + 1) {
                  /// Fetch the pages in the album
                  final page = pages[index - 1];
                  child = _PageItemWidget(page: page);
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
                    onPressed: () {},
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
          } else if (pageState is PageError) {
            return Center(child: Text(pageState.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class _AlbumCoverPage extends StatelessWidget {
  final String albumId;

  const _AlbumCoverPage({required this.albumId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      builder: (context, state) {
        if (state is AlbumLoaded) {
          final album = state.album;

          debugPrint(album.toString());

          return CoverPageWidget(
            title: album.title,
            backgroundImage: album.backgroundImage,
            startDate: album.startDate,
            endDate: album.endDate,
            members: album.members ?? [],
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _PageItemWidget extends StatelessWidget {
  final PageEntity page;

  const _PageItemWidget({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: SizedBox(
        height: 450,
        width: 300,
        child: Center(
          child: Text(
            page.title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
      ),
    );
  }
}
