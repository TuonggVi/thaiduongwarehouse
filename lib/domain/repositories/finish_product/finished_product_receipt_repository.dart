import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';

import '../../entities/finish_product/finished_product_receipt.dart';

abstract class FinishedProductReceiptRepository{
  Future<ErrorPackage> postFinishedProductReceipt(
       FinishedProductReceipt finishedProductReceipt);
  Future<ErrorPackage> updateFinishedProductLotReceipt(
  FinishedProductReceipt finishedProductReceipt);
  Future<List<FinishedProductReceipt>> getCompleteFinishedProductReceipts(DateTime startDate, DateTime endDate);
  Future<List<FinishedProductReceipt>> getUnCompletedFinishedProductReceipts();
}
