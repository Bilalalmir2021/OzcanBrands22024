import 'package:flutter/material.dart';
import 'package:flutter_almirtech_ecommerce/data/model/api_response.dart';
import 'package:flutter_almirtech_ecommerce/features/loyaltyPoint/domain/model/loyalty_point_model.dart';
import 'package:flutter_almirtech_ecommerce/features/loyaltyPoint/domain/repo/loyalty_point_repo.dart';
import 'package:flutter_almirtech_ecommerce/helper/api_checker.dart';
import 'package:flutter_almirtech_ecommerce/localization/language_constrants.dart';
import 'package:flutter_almirtech_ecommerce/main.dart';
import 'package:flutter_almirtech_ecommerce/basewidget/show_custom_snakbar.dart';

class LoyaltyPointProvider extends ChangeNotifier {
  final LoyaltyPointRepo? loyaltyPointRepo;
  LoyaltyPointProvider({required this.loyaltyPointRepo});


  bool _isLoading = false;
  bool _firstLoading = false;
  bool _isConvert = false;
  bool get isConvert => _isConvert;
  bool get isLoading => _isLoading;
  bool get firstLoading => _firstLoading;


  int? _loyaltyPointPageSize;
  int? get loyaltyPointPageSize=> _loyaltyPointPageSize;
  List<LoyaltyPointList> _loyaltyPointList = [];
  List<LoyaltyPointList> get loyaltyPointList => _loyaltyPointList;



  Future<void> getLoyaltyPointList(BuildContext context, int offset, {bool reload = false}) async {
    if(reload){
      _loyaltyPointList = [];
    }

    _isLoading = true;
    ApiResponse apiResponse = await loyaltyPointRepo!.getLoyaltyPointList(offset);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _loyaltyPointList = [];
      _loyaltyPointList.addAll(LoyaltyPointModel.fromJson(apiResponse.response!.data).loyaltyPointList!);
      _loyaltyPointPageSize = LoyaltyPointModel.fromJson(apiResponse.response!.data).totalLoyaltyPoint;
      _isLoading = false;
    } else {
      _isLoading = false;
      ApiChecker.checkApi( apiResponse);
    }
    notifyListeners();
  }


  Future convertPointToCurrency(BuildContext context, int point) async {
    _isConvert = true;
    notifyListeners();
    ApiResponse apiResponse = await loyaltyPointRepo!.convertPointToCurrency(point);
    if (apiResponse.response != null && apiResponse.response!.statusCode == 200) {
      _isConvert = false;
      showCustomSnackBar("${getTranslated('point_converted_successfully', Get.context!)}", Get.context!, isError: false);
    }else{
      _isConvert = false;
      showCustomSnackBar("${getTranslated('point_converted_failed', Get.context!)}", Get.context!);
    }
    notifyListeners();
  }

  void showBottomLoader() {
    _isLoading = true;
    notifyListeners();
  }

  void removeFirstLoading() {
    _firstLoading = true;
    notifyListeners();
  }


  int currentIndex = 0;
  void setCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

}
