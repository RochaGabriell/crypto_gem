import 'package:dio/dio.dart';

import 'package:crypto_gem/constants/api_constants.dart';

const int secondsTimeout = 15;

/// Classe HttpService encapsula a lógica de comunicação HTTP utilizando o pacote Dio.
class HttpService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: secondsTimeout),
      receiveTimeout: const Duration(seconds: secondsTimeout),
      validateStatus: (_) => true,
      contentType: 'application/json',
    ),
  );

  /// Retorna a instância do cliente Dio configurado.
  get dio => _dio;
}