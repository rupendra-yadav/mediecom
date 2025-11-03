import 'package:dartz/dartz.dart';
import 'package:mediecom/core/common/error/app_failures.dart';
import 'package:mediecom/features/notification/domain/entities/notif_entity.dart';
import 'package:mediecom/features/user/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> fetchUserDetails(String mobile);

  Future<Either<Failure, UserEntity>> updateProfile(
    String userId,
    Map<String, String> profileData,
  );

  Future<Either<Failure, UserEntity>> updatePhoto(
    String userId,
    String photoPath,
  );

  Future<Either<Failure, void>> updateFcm(String userId, String fcmToken);

  Future<Either<Failure, List<NotifEntity>>> getNotifications(String userId);
}
