import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/domain/repository/page.repository.dart';

class UpdatePageUsecase {
  final PageRepository repository;

  UpdatePageUsecase(this.repository);

  Future<void> call(PageEntity newPage) async {
    await repository.updatePage(newPage);
  }
}
