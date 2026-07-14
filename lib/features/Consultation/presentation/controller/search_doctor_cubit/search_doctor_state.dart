part of 'search_doctor_cubit.dart';

sealed class SearchDoctorState extends Equatable {
  const SearchDoctorState();

  @override
  List<Object> get props => [];
}

final class SearchDoctorInitial extends SearchDoctorState {}

final class SearchDoctorLoading extends SearchDoctorState {}

final class SearchDoctorSuccess extends SearchDoctorState {
  final List<DoctorEntity> doctors;
  final SearchDoctorRequest request;
  final bool isLastPage;

  const SearchDoctorSuccess({
    required this.request,
    required this.doctors,
    required this.isLastPage,
  });

  // SearchDoctorSuccess copyWith({
  //   List<DoctorEntity>? doctors,
  //   SearchDoctorRequest? request,
  //   bool? isLastPage,
  // }) {
  //   return SearchDoctorSuccess(
  //     request: request ?? this.request,
  //     doctors: doctors ?? this.doctors,
  //     isLastPage: isLastPage ?? this.isLastPage,
  //   );
  // }

  @override
  List<Object> get props => [doctors, isLastPage];
}

final class SearchDoctorFailure extends SearchDoctorState {
  final String message;
  const SearchDoctorFailure({required this.message});
  @override
  List<Object> get props => [message];
}
