import 'package:dio/dio.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';
import 'package:mongbi_app/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<User> updateNickname({
    required int userId,
    required String nickname,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {

  UserRemoteDataSourceImpl(this.dio);
  final Dio dio;

  @override
  Future<User> updateNickname({
    required int userId,
    required String nickname,
  }) async {
    try {
      final response = await dio.patch(
        '/users/$userId/nickname',
        data: {'nickname': nickname},
      );

      if (response.statusCode == 200 && response.data['user'] != null) {
        final userDto = UserDto.fromJson(response.data['user']);
        return userDto.toEntity();
      } else {
        throw Exception(response.data['message'] ?? '닉네임 변경 실패');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? '네트워크 오류';
      throw Exception(errorMessage);
    } catch (e) {
      rethrow;
    }
  }
}
