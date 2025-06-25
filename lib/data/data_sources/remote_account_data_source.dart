import 'package:dio/dio.dart';
import 'package:mongbi_app/core/secure_storage_service.dart';
import 'package:mongbi_app/data/data_sources/account_data_source.dart';
import 'package:mongbi_app/presentation/remind/view_model/remind_time_setting_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteAccountDataSource implements AccountDataSource {
  const RemoteAccountDataSource(this.dio, this.secureStorageService);

  final Dio dio;
  final SecureStorageService secureStorageService;

  @override
  Future<bool> removeAccount() async {
    try {
      final userIndex = await secureStorageService.getUserIdx();
      final response = await dio.put(
        '/users/$userIndex/USER_CANCEL_STATE',
        data: {'USER_CANCEL_STATE': 'Y'},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if ((response.data['code'] == 201 || response.data['code'] == 200) &&
          response.data['success']) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        await secureStorageService.clearAll();
        await NotificationService().cancelAllNotifications();

        return true;
      } else {
        throw Exception(response.data['message'] ?? '알 수 없는 오류가 발생하였습니다.');
      }
    } catch (e) {
      return false;
    }
  }
}
