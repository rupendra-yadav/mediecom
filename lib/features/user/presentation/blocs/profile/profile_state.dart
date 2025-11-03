part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;

  const ProfileLoaded({required this.user});

  @override
  List<Object> get props => [user];
}

class ProfileUpdated extends ProfileState {
  final UserEntity user;

  const ProfileUpdated({required this.user});

  @override
  List<Object> get props => [user];
}

class ProfileError extends ProfileState {
  final int statusCode;
  final String message;

  const ProfileError({required this.statusCode, required this.message});

  @override
  List<Object> get props => [statusCode, message];
}

class ProfileImageUpdated extends ProfileState {
  final UserEntity user;

  const ProfileImageUpdated({required this.user});

  @override
  List<Object> get props => [user];
}

// class ProfileImageRemoved extends ProfileState {
//
// }
