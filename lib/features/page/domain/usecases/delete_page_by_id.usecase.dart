import 'package:memora_app/features/page/domain/repository/page.repository.dart';

class DeletePageByIdUsecase {
  final PageRepository repository;

  DeletePageByIdUsecase(this.repository);

  Future<void> call(String id) async {
    await repository.deletePageById(id);
  }
}
