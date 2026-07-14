class SearchDoctorsParams {
  final int page;
  final int size;
  final Map<String, dynamic> filterBody;

  SearchDoctorsParams({
    required this.page,
    this.size = 10,
    required this.filterBody,
  });
}