import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/domain/repository/page.repository.dart';

class DeletePageUsecase {
  final PageRepository repository;

  DeletePageUsecase(this.repository);

  Future<void> call(PageEntity page) async {
    await repository.deletePage(page);
  }
}
