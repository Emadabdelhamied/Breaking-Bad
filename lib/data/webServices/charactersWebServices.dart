import 'package:breakingbad/shared/constants.dart';
import 'package:dio/dio.dart';
class CharacterWebServices {
  Dio dio;
  CharacterWebServices() {
    BaseOptions options = BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000);
    dio = Dio(options);
  }
  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('characters');
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
  Future<List<dynamic>> getCharQuote(String charName) async {
    try {
      Response response = await dio.get('quote',queryParameters: {'author':charName});
      print(response.data.toString());
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
}
