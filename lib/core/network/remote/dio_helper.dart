import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_app/core/network/remote/api_endpoints.dart';
import 'package:news_app/core/util/constants/constants.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    if (dio != null) {
      return;
    }

    dio = Dio(
      BaseOptions(
        baseUrl: '$baseUrl$apiVersion',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
      ),
    );
  }

  static Dio getDio() {
    if (dio != null) {
      return dio!;
    }

    init();

    return dio!;
  }

  // static Future<Response> get({
  //   required String path,
  //   Map<String, dynamic>? params,
  //   String? search,
  // }) {
  //   // will be some logic here before call get method directly from dio package
  //   return getDio().get(
  //     path,
  //     queryParameters: {
  //       if(search != null) 'q': search,
  //       ...?params,
  //     },
  //     options: Options(
  //       headers: {
  //         'Authorization': 'Bearer $apiKey',
  //       },
  //     ),
  //   );
  // }

  static Future<Either<String, Map<String, dynamic>>> get({
    required String path,
    Map<String, dynamic>? params,
    String? search,
  }) async {
    // will be some logic here before call get method directly from dio package
    try {
      Response response = await getDio().get(
        path,
        queryParameters: {
          if(search != null) 'q': search,
          ...?params,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $apiKey',
          },
        ),
      );

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.response?.data['message'] ?? 'something went wrong, please try again later');
    } catch (e) {
      debugPrint('DioHelper.get error: $e');
      return Left('something went wrong, please try again later');
    }
  }
}







