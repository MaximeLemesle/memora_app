import 'package:memora_app/features/page/domain/entities/page.entity.dart';
import 'package:memora_app/features/page/domain/repository/page.repository.dart';

class GetPagesByAlbum {
  final PageRepository repository;

  GetPagesByAlbum(this.repository);

  Future<List<PageEntity>> call(String albumUid) async {
    return await repository.getPagesByAlbum(albumUid);
  }
}
