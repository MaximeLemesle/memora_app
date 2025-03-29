import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/domain/repository/page.repository.dart';

class CreatePage {
  final PageRepository repository;

  CreatePage(this.repository);

  Future<void> call(String albumId, PageEntity page) async {
    await repository.createPage(albumId, page);
  }
}
