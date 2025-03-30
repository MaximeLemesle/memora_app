import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/core/widgets/button.widget.dart';
import 'package:memora_app/features/page/presentation/blocs/page.bloc.dart';

class PagesList extends StatelessWidget {
  final String albumId;
  const PagesList({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 24),
      child: BlocBuilder<PageBloc, PageState>(
        builder: (context, state) {
          if (state is PageInitial) {
            context.read<PageBloc>().fetchPages(albumId);
            return const Center(child: CircularProgressIndicator());
          } else if (state is PageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PageLoaded) {
            final pages = state.pages;

            return PageView.builder(
              controller: PageController(
                viewportFraction: 0.85,
                initialPage: 0,
              ),
              padEnds: false,
              itemCount: pages.length + 1,
              itemBuilder: (context, index) {
                if (index < pages.length) {
                  final page = pages[index];

                  // Fetch the pages in the album
                  return Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 24,
                      children: [
                        SizedBox(
                          height: 450,
                          width: 300,
                          child: Center(
                            child: Text(
                              page.title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  // Add the button to create a new page
                  return Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        height: 450,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.outline,
                          ),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          spacing: 16,
                          children: [
                            ButtonWidget(
                              label: '',
                              variant: ButtonVariant.tertiary,
                              size: ButtonSize.big,
                              iconPosition: ButtonIcon.only,
                              icon: CupertinoIcons.add,
                              onPressed: () {},
                            ),
                            Text(
                              "Créer une nouvelle page",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
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
