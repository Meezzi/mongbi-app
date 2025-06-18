// import 'package:dio/dio.dart';
// import 'package:mongbi_app/data/data_sources/user_data_source.dart';
// import 'package:mongbi_app/data/dtos/user_dto.dart';
// import 'package:mongbi_app/domain/entities/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class RemoteGetUserDataSource implements UserDataSource{
//   RemoteGetUserDataSource(this.dio);
//   final Dio dio;

//   @override
//   Future<List<UserDto>> fetchUserData() async{
//     final prefs = await SharedPreferences.getInstance();
//     final userIDX = prefs.getString('')
//     final response = await dio.get('/users/$userIDX');
//   }

// }