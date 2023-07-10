
import '../../entities/error_package.dart';
import '../../entities/finish_product/finished_product_receipt.dart';
import '../../repositories/finish_product/finished_product_receipt_repository.dart';

class FinishedProductReceiptUseCase {
  final FinishedProductReceiptRepository finishedProductReceiptRepository;
  FinishedProductReceiptUseCase(this.finishedProductReceiptRepository);
  Future<ErrorPackage> postNewFinishedProductReceipt(
      FinishedProductReceipt finishedProductReceipt) async {
    final status =
        finishedProductReceiptRepository.postFinishedProductReceipt(finishedProductReceipt);
    return status;
  }

  Future<ErrorPackage> updateDetailLotReceipt(
    FinishedProductReceipt finishedProductReceipt) async {
    final status = finishedProductReceiptRepository.updateFinishedProductLotReceipt(
       finishedProductReceipt);
    return status;
  }

  Future<List<FinishedProductReceipt>> getCompleteFinishedProductReceipts(DateTime startDate, DateTime endDate) async {
    final finishedProductReceipts = finishedProductReceiptRepository.getCompleteFinishedProductReceipts(startDate,endDate);
    return finishedProductReceipts;
  }

  Future<List<FinishedProductReceipt>> getUnCompletedFinishedProductReceipts() async {
    final finishedProductReceipts = finishedProductReceiptRepository.getUnCompletedFinishedProductReceipts();
    return finishedProductReceipts;
  }
}
