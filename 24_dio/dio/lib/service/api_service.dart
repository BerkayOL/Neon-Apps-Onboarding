import 'package:dio/dio.dart';
import 'package:melody_maker/model/track_model.dart';

class ApiService {
  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com/',
        connectTimeout: const Duration(seconds: 5),
      ),
    );
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.next(options),
        onError: (error, handler) async {
          final retries =
              (error.requestOptions.extra['retryCount'] ?? 0) as int;
          if (_shouldRetry(error) && retries < 3) {
            final requestOptions = error.requestOptions;
            requestOptions.extra['retryCount'] = retries + 1;
            try {
              final response = await _dio.fetch(requestOptions);
              return handler.resolve(response);
            } on DioException catch (e) {
              return handler.next(e);
            }
          }
          return handler.next(error);
        },
      ),
    );
    _dio.interceptors.add(
      LogInterceptor(requestBody: false, responseBody: false),
    );
  }

  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  late final Dio _dio;

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout;
  }

  Future<List<TrackModel>> fetchTracks({String? query}) async {
    try {
      final hasQuery = query != null && query.trim().isNotEmpty;
      final response = await _dio.get(
        hasQuery ? 'products/search' : 'products',
        queryParameters: hasQuery ? {'q': query!.trim()} : null,
      );
      if (response.statusCode == 200) {
        List<TrackModel> tracks = (response.data['products'] as List)
            .map((json) => TrackModel.fromJson(json))
            .toList();
        return tracks;
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
