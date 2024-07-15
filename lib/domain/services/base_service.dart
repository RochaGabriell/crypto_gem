import 'package:dio/dio.dart';

abstract class BaseService {
  final Dio dio;

  BaseService(this.dio);

  Future<Object> handleException(DioException e, StackTrace stackTrace) async {
    if (DioExceptionType.connectionError == e.type) {
      return {'message': 'Sem conexão com a internet', 'statusCode': 503};
    } else if (DioExceptionType.connectionTimeout == e.type ||
        DioExceptionType.receiveTimeout == e.type ||
        DioExceptionType.sendTimeout == e.type) {
      return {
        'message':
            'Suas solicitações estão demorando muito para responder. Verifique sua conexão e tente novamente',
        'statusCode': 504,
      };
    } else if (DioExceptionType.badResponse == e.type) {
      return e.response!.data;
    } else {
      return 'Algo deu errado. Tente novamente mais tarde';
    }
  }

  Future<Response> performHttpOperation(
    String method,
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    try {
      final response = await dio.request(
        url,
        options: Options(method: method, headers: headers),
        queryParameters: queryParameters,
        data: data,
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else if (response.statusCode! == 400 || response.statusCode! == 401) {
        return response;
      } else {
        throw (
          'Erro ao realizar a operação HTTP $method em $url com status ${response.statusCode}',
        );
      }
    } on DioException catch (e, stackTrace) {
      throw await handleException(e, stackTrace);
    } catch (e) {
      throw ('Ocorreu um erro inesperado. Por favor, tente novamente mais tarde. Se o problema persistir, entre em contato com o suporte.');
    }
  }
}
