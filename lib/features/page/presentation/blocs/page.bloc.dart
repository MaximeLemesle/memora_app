import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/domain/usecases/create_new_page.usecase.dart';
import 'package:memora_app/features/page/domain/usecases/delete_page.usecase.dart';
import 'package:memora_app/features/page/domain/usecases/get_page_count_by_album.usecase.dart';
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

class PageCountLoaded extends PageState {
  final int count;
  PageCountLoaded(this.count);
}

class PageDeleted extends PageState {}

class PageBloc extends Cubit<PageState> {
  final GetPagesByAlbumUsecase getPagesByAlbumUsecase;
  final CreateNewPageUsecase createNewPageUsecase;
  final UpdatePageUsecase updatePageUsecase;
  final GetPageCountByAlbumUsecase getPageCountByAlbumUsecase;
  final DeletePageUsecase deletePageUsecase;

  PageBloc(
    this.getPagesByAlbumUsecase,
    this.createNewPageUsecase,
    this.updatePageUsecase,
    this.getPageCountByAlbumUsecase,
    this.deletePageUsecase,
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

  Future<int?> getPageCountByAlbum(String albumId) async {
    emit(PageLoading());
    try {
      final int count = await getPageCountByAlbumUsecase(albumId);
      emit(PageCountLoaded(count));
      return count;
    } catch (e) {
      emit(PageError("Error: $e"));
      return null;
    }
  }

  Future<void> deletePage(PageEntity page) async {
    try {
      await deletePageUsecase(page);
      emit(PageDeleted());
    } catch (e) {
      emit(PageError(e.toString()));
    }
  }
}
