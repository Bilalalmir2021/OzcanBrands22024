import 'package:flutter_almirtech_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_almirtech_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_almirtech_ecommerce/data/model/api_response.dart';
import 'package:flutter_almirtech_ecommerce/utill/app_constants.dart';

class TopSellerRepo {
  final DioClient? dioClient;
  TopSellerRepo({required this.dioClient});

  Future<ApiResponse> getTopSeller() async {
    try {
      final response = await dioClient!.get(AppConstants.topSeller);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}