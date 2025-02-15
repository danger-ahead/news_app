import 'package:dio/dio.dart';
import 'package:logging/logging.dart';
import 'package:news_app/core/network/connectivity.dart';
import 'package:news_app/core/notifications/toast.dart';

class CustomDio {
  final Dio _dio;

  final _logger = Logger('CustomDio');

  CustomDio([BaseOptions? options]) : _dio = Dio(options) {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        final bool hasConnection = await Connectivity().hasConnection();

        if (!hasConnection) {
          throw DioException(
            requestOptions: options,
            error: 'No internet connection',
          );
        }

        _logger.info(
            '${options.method} - ${options.path} ${options.queryParameters.isEmpty ? '' : '- ${options.queryParameters}'}');
        if (options.method == 'POST' || options.method == 'PUT') {
          if (options.data is FormData) {
            _logger.info(options.data.fields);
          } else {
            _logger.info(options.data);
          }
        }

        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        _logger.info('${response.statusCode} - ${response.data}');
        return handler.next(response);
      },
      onError: (DioException error, ErrorInterceptorHandler handler) {
        _handleError(error);
        return handler.next(error);
      },
    ));
  }

  void _handleError(DioException error) {
    if (error.response != null && error.response!.statusCode != null) {
      if (error.response!.statusCode! >= 500) {
        _logger.warning('Server error');
        ShowToast.error('Server error occurred');
      } else {
        _logger.warning(error.response?.statusCode);
        _logger.warning(error.response?.data);
        ShowToast.error('An error occurred. Please try again');
      }
    } else {
      if (error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.receiveTimeout ||
          error.type == DioExceptionType.sendTimeout) {
        _logger.warning("Slow internet connection. Try again later");
      } else {
        _logger.warning("Unexpected error: ${error.message}");
        ShowToast.error('Unexpected error occurred');
      }
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.get(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> post(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  Future<Response> put(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) {
    return _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }
}
