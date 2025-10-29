part of 'verify_otp_bloc.dart';

sealed class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object> get props => [];
}

class VerifyOtpInitial extends VerifyOtpState {}

class VerifyOtpLoading extends VerifyOtpState {}

class VerifyOtpSuccess extends VerifyOtpState {
  final UserEntity user;

  const VerifyOtpSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class VerifyOtpError extends VerifyOtpState {
  final int statusCode;
  final String message;

  const VerifyOtpError({required this.statusCode, required this.message});

  @override
  List<Object> get props => [statusCode, message];
}
