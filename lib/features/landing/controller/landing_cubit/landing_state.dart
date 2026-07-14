part of 'landing_cubit.dart';

sealed class LandingState extends Equatable {
  const LandingState();

  @override
  List<Object> get props => [];
}

final class LandingInitial extends LandingState {}

final class LandingLoading extends LandingState {}

final class LandingSuccess extends LandingState {
  final String role;
  const LandingSuccess({required this.role});
}

final class LandingFailure extends LandingState {
  final String message;
  const LandingFailure({required this.message});
}
