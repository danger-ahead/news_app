import 'dart:io';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:news_app/core/network/custom_dio.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> cacheImage(String url) async {
  final logger = Logger();

  try {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/${Uri.parse(url).pathSegments.last}';
    final file = File(filePath);
    final dio = CustomDio();

    if (await file.exists()) {
      return file;
    } else {
      final response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200 && response.data != null) {
        await file.writeAsBytes(response.data!);
        return file;
      }
    }
  } catch (e) {
    logger.e('Error caching image: $e');
  }

  return null;
}
