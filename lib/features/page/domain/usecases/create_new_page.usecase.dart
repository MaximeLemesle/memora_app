import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/domain/repository/page.repository.dart';

class CreateNewPage {
  final PageRepository repository;

  CreateNewPage(this.repository);

  Future<void> call(PageEntity page) async {
    await repository.createPage(page);
  }
}
