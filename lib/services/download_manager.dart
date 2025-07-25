import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:revanced_manager/app/app.locator.dart';
import 'package:revanced_manager/services/manager_api.dart';
import 'package:revanced_manager/services/toast.dart';

@lazySingleton
class DownloadManager {
  final ManagerAPI _managerAPI = locator<ManagerAPI>();
  late final String _userAgent;

  final _cacheOptions = CacheOptions(
    store: MemCacheStore(),
    maxStale: const Duration(days: 1),
    priority: CachePriority.high,
  );

  Future<void> initialize() async {
    _userAgent =
        'RVX-Manager/${await _managerAPI.getCurrentManagerVersion()}';
  }

  Dio initDio(String url) {
    var dio = Dio();
    try {
      dio = Dio(
        BaseOptions(
          baseUrl: url,
          headers: {
            'User-Agent': _userAgent,
          },
        ),
      );
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));
    dio.interceptors.add(_ShowToastInterceptor());
    return dio;
  }

  Future<void> clearAllCache() async {
    try {
      await _cacheOptions.store!.clean();
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<File> getSingleFile(String url) async {
    return DefaultCacheManager().getSingleFile(
      url,
      headers: {
        'User-Agent': _userAgent,
      },
    );
  }

  Stream<FileResponse> getFileStream(String url) {
    return DefaultCacheManager().getFileStream(
      url,
      withProgress: true,
      headers: {
        'User-Agent': _userAgent,
      },
    );
  }
}

class _ShowToastInterceptor extends Interceptor {
  final Toast _toast = locator<Toast>();
  bool _noConnection = false;
  _ShowToastInterceptor() {
    final Future connectivityResult = Connectivity().checkConnectivity();
    connectivityResult.then((result) {
      _noConnection = result.contains(ConnectivityResult.none);
    });
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;
    if (response != null) {
      // Check if the error is rate limit
      if (response.headers['x-ratelimit-remaining']?[0] == '0') {
        final resetUnixTime =
            int.parse(response.headers['x-ratelimit-reset']?[0] ?? '0');
        final resetDateTime =
            DateTime.fromMillisecondsSinceEpoch(resetUnixTime * 1000);
        final remainingMinutes =
            resetDateTime.difference(DateTime.now()).inMinutes;
        _toast.showBottom(
            'GitHub API rate limit exceeded. Change the network or wait $remainingMinutes minutes.');
      } else {
        _toast.showBottom(
            '${response.statusCode} ${response.statusMessage}: ${err.requestOptions.uri}');
      }
    } else {
      // Show errors only when connected to network
      if (!_noConnection) {
        // The "DioException" text is unnecessary for users, so remove it to simplify
        _toast.showBottom(err.requestOptions.uri.host +
            err.toString().replaceFirst('DioException', ''));
      }
    }
    super.onError(err, handler);
  }
}
