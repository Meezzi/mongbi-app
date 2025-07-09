import 'package:mongbi_app/domain/entities/user.dart';
import 'package:mongbi_app/presentation/splash/view_models/splash_status.dart';

class SplashState {
  const SplashState({this.status = SplashStatus.initial, this.userList});
  final SplashStatus status;
  final List<User>? userList;

  SplashState copyWith({SplashStatus? status, List<User>? userList}) {
    return SplashState(
      status: status ?? this.status,
      userList: userList ?? this.userList,
    );
  }
}
