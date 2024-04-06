// ignore_for_file: empty_catches

import 'package:dio/dio.dart';
import 'package:do_an/net_working/responstory/url.dart';

class HttpService {
  final Dio _dio = Dio();
  Future<Response?> request(String url,
      {APIMethod method = APIMethod.Get}) async {
    try {
      switch (method) {
        case APIMethod.Get:
          {
            return _dio.get(url,
                options: Options(
                  headers: {
                    'X-RapidAPI-Key':
                        '152022dccamsh730dc3f3b8248a6p18bb1djsnc35439081222',
                    'X-RapidAPI-Host': 'deezerdevs-deezer.p.rapidapi.com',
                  },
                ));
          }
        case APIMethod.Post:
          return _dio.post(url);
        case APIMethod.Delete:
          return _dio.delete(url);

        default:
          return _dio.put(url);
      }
    } catch (e) {}
    return null;
  }
}

class HttpServiceSearch {
  final Dio _dio = Dio();
  Future<Response?> request(
      {required String url,
      required String query,
      APIMethod method = APIMethod.Get}) async {
    try {
      switch (method) {
        case APIMethod.Get:
          {
            return _dio.get(url,
                queryParameters: {'q': query},
                options: Options(
                  headers: {
                    'X-RapidAPI-Key':
                        '152022dccamsh730dc3f3b8248a6p18bb1djsnc35439081222',
                    'X-RapidAPI-Host': 'deezerdevs-deezer.p.rapidapi.com',
                  },
                ));
          }
        case APIMethod.Post:
          return _dio.post(url);
        case APIMethod.Delete:
          return _dio.delete(url);

        default:
          return _dio.put(url);
      }
    } catch (e) {}
    return null;
  }
}
