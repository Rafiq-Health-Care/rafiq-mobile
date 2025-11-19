class LabTestGetAllRequest {
  final int page;
  final int size;
  final String sort;
  final String direction;

  const LabTestGetAllRequest({
    this.page = 0,
    this.size = 10,
    this.sort = 'name',
    this.direction = 'asc',
  });

  Map<String, dynamic> toMap() {
    return {'page': page, 'size': size, 'sort': sort, 'direction': direction};
  }
}
