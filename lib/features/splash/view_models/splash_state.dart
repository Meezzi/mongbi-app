import 'package:mongbi_app/features/setting/data/dtos/user_dto.dart';
import 'package:mongbi_app/features/splash/view_models/splash_status.dart';

class SplashState {
  const SplashState({this.status = SplashStatus.initial, this.userList});
  final SplashStatus status;
  final List<UserDto>? userList;

  SplashState copyWith({SplashStatus? status, List<UserDto>? userList}) {
    return SplashState(
      status: status ?? this.status,
      userList: userList ?? this.userList,
    );
  }
}
