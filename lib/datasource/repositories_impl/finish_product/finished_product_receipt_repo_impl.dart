import 'package:mobile_warehouse_thaiduong/domain/entities/finish_product/finished_product_receipt.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import '../../../domain/repositories/finish_product/finished_product_receipt_repository.dart';
import '../../service/finish_product/finished_product_receipt_service.dart';

class FinishedProductReceiptRepoImpl
    implements FinishedProductReceiptRepository {
  final FinishedProductReceiptService finishedProductReceiptService;
  FinishedProductReceiptRepoImpl(this.finishedProductReceiptService);
  Future<List<FinishedProductReceipt>> getCompletedFinishedProductReceipts(
      DateTime startDate, DateTime endDate) {
    final finishedProductReceipts = finishedProductReceiptService
        .getCompletedFinishedProductReceipts(startDate, endDate);
    return finishedProductReceipts;
  }

  @override
  Future<List<FinishedProductReceipt>> getUnCompletedFinishedProductReceipts() {
    final finishedProductReceipts =
        finishedProductReceiptService.getUnCompletedFinishedProductReceipts();
    return finishedProductReceipts;
  }

  @override
  Future<ErrorPackage> postFinishedProductReceipt(
      FinishedProductReceipt finishedProductReceipt) {
    final status = finishedProductReceiptService
        .postFinishedProductReceipt(finishedProductReceipt);
    return status;
  }

  @override
  Future<ErrorPackage> updateFinishedProductLotReceipt(
      FinishedProductReceipt finishedProductReceipt) {
    final status = finishedProductReceiptService.update(finishedProductReceipt);
    return status;
  }

  @override
  Future<List<FinishedProductReceipt>> getCompleteFinishedProductReceipts(
      DateTime startDate, DateTime endDate) {
    throw UnimplementedError();
  }
}
