import 'package:dio/dio.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/data_sources/user_info_data_source.dart';
import 'package:mongbi_app/data/dtos/user_dto.dart';

class RemoteUserInfoGetDataSource implements GetUserInfoDataSource {
  RemoteUserInfoGetDataSource(this.dio);
  final Dio dio;

  @override
  Future<List<UserDto>> fetchGetUserInfo() async {
    final userId = await SecureStorageService().getUserIdx();
    final response = await dio.get('/users/$userId');

    if (response.statusCode == 200 && response.data != null) {
      final userDto = UserDto.fromJson(response.data);
      return [userDto];
    } else {
      throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
    }
  }
}
