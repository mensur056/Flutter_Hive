import 'package:dio/dio.dart';
import 'package:flutter_hive/service/user_model.dart';

abstract class IService {
  Future<List<UserModel>?> fetchItemFromApi();
}

class GeneralService implements IService {
  Dio dio = Dio(BaseOptions(baseUrl: 'https://jsonplaceholder.typicode.com/'));
  @override
  Future<List<UserModel>?> fetchItemFromApi() async {
    final response = await dio.get('users');
    if (response.statusCode == 200) {
      final jsonData = response.data;
      if (jsonData is List) {
        return jsonData.map((e) => UserModel.fromJson(e)).toList();
      }
    }
    return null;
  }
}
