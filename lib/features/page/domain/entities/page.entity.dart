class PageEntity {
  final String uid;
  final String albumId;
  final int pageNumber;
  final String type;
  final String title;
  final List<String>? descriptions;
  final List<String>? images;

  const PageEntity({
    required this.uid,
    required this.albumId,
    required this.pageNumber,
    required this.title,
    required this.type,
    this.descriptions,
    this.images,
  });
}
