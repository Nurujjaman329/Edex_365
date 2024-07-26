import '../entities/page.dart';

class PageModel extends Page {
  final int currentPage;
  final int size;
  final int totalPages;
  final int totalElements;

  const PageModel(
      {required this.currentPage,
      required this.size,
      required this.totalPages,
      required this.totalElements})
      : super(
          currentPage: currentPage,
          size: size,
          totalPages: totalPages,
          totalElements: totalElements,
        );

  factory PageModel.fromJson(dynamic json) {
    return PageModel(
      currentPage: json['currentPage'],
      size: json['size'],
      totalPages: json['totalPages'],
      totalElements: json['totalElements'],
    );
  }
}
