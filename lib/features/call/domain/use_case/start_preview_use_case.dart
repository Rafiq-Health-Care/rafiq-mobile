import 'package:dartz/dartz.dart';
import 'package:rafiq/core/errors/failure.dart';
import 'package:rafiq/features/call/domain/repository/call_repo.dart';

class StartPreviewUseCase {
  final CallRepository repository;
  const StartPreviewUseCase(this.repository);

  Future<Either<Failure, void>> call() {
    return repository.startPreview();
  }
}
