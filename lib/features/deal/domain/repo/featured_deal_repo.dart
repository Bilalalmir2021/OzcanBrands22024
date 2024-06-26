import 'package:flutter_almirtech_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_almirtech_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_almirtech_ecommerce/data/model/api_response.dart';
import 'package:flutter_almirtech_ecommerce/utill/app_constants.dart';

class FeaturedDealRepo {
  final DioClient? dioClient;
  FeaturedDealRepo({required this.dioClient});

  Future<ApiResponse> getFeaturedDeal() async {
    try {
      final response = await dioClient!.get(AppConstants.featuredDealUri
      );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}