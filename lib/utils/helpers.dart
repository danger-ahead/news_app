import 'dart:io';
import 'package:news_app/core/network/custom_dio.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> cacheImage(String url) async {
  final directory = await getTemporaryDirectory();
  final filePath = '${directory.path}/${Uri.parse(url).pathSegments.last}';
  final file = File(filePath);
  final dio = CustomDio();

  if (await file.exists()) {
    return file;
  } else {
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      await file.writeAsBytes(response.data);
      return file;
    }
  }

  return null;
}
