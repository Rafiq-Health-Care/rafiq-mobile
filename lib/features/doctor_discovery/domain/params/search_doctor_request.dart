import 'package:equatable/equatable.dart';

class SearchDoctorRequest extends Equatable {
  final int page;
  final int size;
  final List<String>? specialities;
  final String? availability;
  final double? rating;
  final double? minPrice;
  final double? maxPrice;

  const SearchDoctorRequest({
    this.page = 0,
    this.size = 10,
    this.specialities,
    this.availability,
    this.rating,
    this.minPrice,
    this.maxPrice,
  });

  SearchDoctorRequest copyWith({int? page, int? size}) {
    return SearchDoctorRequest(
      page: page ?? this.page,
      size: size ?? this.size,
      specialities: specialities,
      availability: availability,
      rating: rating,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
  }

  Map<String, dynamic> toBodyJson() {
    return {
      "specialities": specialities,
      "availability": availability,
      "rating": rating,
      "minPrice": minPrice,
      "maxPrice": maxPrice,
    };
  }

  @override
  List<Object?> get props => [
    page,
    size,
    specialities,
    availability,
    rating,
    minPrice,
    maxPrice,
  ];
}
