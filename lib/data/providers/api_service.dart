import 'package:news_app/constants/strings.dart';
import 'package:news_app/core/network/custom_dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  static final _dio = CustomDio();

  factory ApiService() {
    return _instance;
  }

  ApiService._internal();

  Future<dynamic> fetchNews(
    String topic, {
    int page = 1,
  }) async {
    final response = await _dio.get(
        'https://newsapi.org/v2/everything?apiKey=$newsApiKey&q=$topic&sortBy=publishedAt&pageSize=20&page=$page');

    return response.data;
  }
}
