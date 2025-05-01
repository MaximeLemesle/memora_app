import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/domain/usecases/create_new_page.usecase.dart';
import 'package:memora_app/features/page/domain/usecases/get_pages_by_album.usecase.dart';
import 'package:memora_app/features/page/domain/usecases/update_page.usecase.dart';

abstract class PageState {}

class PageInitial extends PageState {}

class PageLoading extends PageState {}

class PageLoaded extends PageState {
  final List<PageEntity> pages;

  PageLoaded(this.pages);
}

class PageSuccess extends PageState {}

class PageUpdated extends PageState {}

class PageError extends PageState {
  final String message;
  PageError(this.message);
}

class PageBloc extends Cubit<PageState> {
  final GetPagesByAlbumUsecase getPagesByAlbumUsecase;
  final CreateNewPageUsecase createNewPageUsecase;
  final UpdatePageUsecase updatePageUsecase;

  PageBloc(
    this.getPagesByAlbumUsecase,
    this.createNewPageUsecase,
    this.updatePageUsecase,
  ) : super(PageInitial());

  Future<void> fetchPages(String owner) async {
    emit(PageLoading());
    try {
      final pages = await getPagesByAlbumUsecase(owner);
      emit(PageLoaded(pages));
    } catch (e) {
      emit(PageError("Error: $e"));
    }
  }

  Future<void> createPage(PageEntity page) async {
    try {
      await createNewPageUsecase(page);
      emit(PageSuccess());
    } catch (e) {
      emit(PageError(e.toString()));
    }
  }

  Future<void> updatePage(PageEntity newPage) async {
    try {
      await updatePageUsecase(newPage);
      emit(PageUpdated());
    } catch (e) {
      emit(PageError(e.toString()));
    }
  }
}
