// ignore_for_file: must_be_immutable

import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';

class ErrorPackageModel extends ErrorPackage{
  ErrorPackageModel(super.detail);
factory ErrorPackageModel.fromJson(Map<String, dynamic> json) {
    return ErrorPackageModel(
      json['detail'],
    
    );
  }
}