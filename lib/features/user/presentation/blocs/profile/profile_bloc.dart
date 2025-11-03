import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mediecom/core/common/error/app_failures.dart';
import 'package:mediecom/features/user/domain/entities/user_entity.dart';
import 'package:mediecom/features/user/domain/use_cases/fetch_user_details_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FetchUserDetailsUsecase _fetchUserDetailsUsecase;
  ProfileBloc(this._fetchUserDetailsUsecase) : super(ProfileInitial()) {
    on<GetProfileEvent>(_onGetProfile);
    // on<UpdateProfileEvent>(_onUpdateAccount);
    // on<UpdateImageEvent>(_onUpdateImage);
  }

  Future<void> _onGetProfile(
    GetProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final failureOrSuccess = await _fetchUserDetailsUsecase(event.userId);
    log(failureOrSuccess.toString());

    failureOrSuccess.fold(
      (failure) => emit(
        ProfileError(
          message: _mapFailureToMessage(failure),
          statusCode: failure.statusCode,
        ),
      ),
      (user) => emit(ProfileLoaded(user: user)),
    );
  }

  // Future<void> _onUpdateAccount(UpdateProfileEvent event, Emitter<ProfileState> emit) async {
  //   emit(ProfileLoading());
  //   final failureOrSuccess = await updateProfileUseCase(event.params);

  //   failureOrSuccess.fold(
  //     (failure) => emit(ProfileError(
  //         message: _mapFailureToMessage(failure),
  //         statusCode: failure.statusCode)),
  //     (user) => emit(ProfileUpdated(user: user)),
  //   );
  // }

  // Future<void> _onUpdateImage(UpdateImageEvent event, Emitter<ProfileState> emit) async {
  //   emit(ProfileLoading());
  //   final failureOrSuccess = await updateImageUseCase(event.params);

  //   failureOrSuccess.fold(
  //     (failure) => emit(ProfileError(
  //         message: _mapFailureToMessage(failure),
  //         statusCode: failure.statusCode)),
  //     (user) => emit(ProfileImageUpdated(user: user)),
  //   );
  // }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure():
        return 'Server Error: ${failure.message}';
      case NetworkFailure():
        return 'Network Error: ${failure.message}';
      default:
        return 'Unexpected Error';
    }
  }
}
