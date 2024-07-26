import 'package:equatable/equatable.dart';

class Page extends Equatable {
  final int currentPage;
  final int size;
  final int totalPages;
  final int totalElements;

  const Page(
      {required this.currentPage,
      required this.size,
      required this.totalPages,
      required this.totalElements});

  @override
  List<Object> get props => [];
}
