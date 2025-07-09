import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:mongbi_app/presentation/splash/view_models/splash_status.dart';

class SplashState {
  const SplashState({
    this.status = SplashStatus.initial,
    this.user,
  });

  final SplashStatus status;
  final UserDto? user;

  SplashState copyWith({
    SplashStatus? status,
    UserDto? user,
  }) {
    return SplashState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
