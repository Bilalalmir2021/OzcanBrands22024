import 'package:flutter_almirtech_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_almirtech_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_almirtech_ecommerce/data/model/api_response.dart';
import 'package:flutter_almirtech_ecommerce/utill/app_constants.dart';

class BrandRepository {
  final DioClient? dioClient;
  BrandRepository({required this.dioClient});

  Future<ApiResponse> getBrandList() async {

    try {
      final response = await dioClient!.get(AppConstants.brandUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getSellerWiseBrandList(int sellerId) async {

    try {
      final response = await dioClient!.get('${AppConstants.sellerWiseBrandList}$sellerId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}