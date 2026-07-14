import 'package:equatable/equatable.dart';

class AllGroupsRequest extends Equatable {
  final String? sort;
  final int page;
  final int? size;
  final String? direction;

  const AllGroupsRequest({this.sort, this.page = 0, this.size, this.direction});

  Map<String, dynamic> toJson() {
    return {'sort': sort, 'page': page, 'size': size, 'direction': direction};
  }

  AllGroupsRequest copyWith({
    String? sort,
    int? page,
    int? size,
    String? direction,
  }) {
    return AllGroupsRequest(
      sort: sort ?? this.sort,
      page: page ?? this.page,
      size: size ?? this.size,
      direction: direction ?? this.direction,
    );
  }

  @override
  List<Object?> get props => [sort, page, size, direction];
}
