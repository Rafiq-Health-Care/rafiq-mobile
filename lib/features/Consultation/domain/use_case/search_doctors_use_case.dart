import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/Consultation/domain/entity/paginated_doctors_entity.dart';
import 'package:rafiq/features/Consultation/domain/params/search_doctors_params.dart';
import 'package:rafiq/features/Consultation/domain/repository/repository.dart';

class SearchDoctorsUseCase {
  final Repository repository;

  SearchDoctorsUseCase(this.repository);

  Future<Either<Failure, PaginatedDoctorsEntity>> call(
    SearchDoctorsParams params,
  ) {
    return repository.searchDoctors(
      page: params.page,
      size: params.size,
      filterBody: params.filterBody,
    );
  }
}
