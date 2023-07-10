
import '../../../domain/entities/finish_product/finished_product_receipt_entry.dart';
import '../../../domain/repositories/finish_product/finished_product_receipt_entry_repository.dart';
import '../../service/finish_product/finished_product_receipt_entry_service.dart';

class FinishedProductReceiptEntryRepoImpl implements FinishedProductReceiptEntryRepository {
  final FinishedProductReceiptEntryService finishedProductReceiptEntryService;
  FinishedProductReceiptEntryRepoImpl(this.finishedProductReceiptEntryService);
  @override
  Future<List<FinishedProductReceiptEntry>> getFinishedProductReceiptEntryByItem(
      String warehouseId, String itemId, DateTime startDate, DateTime endDate) {
    final entries = finishedProductReceiptEntryService.getFinishedProductReceiptEntryByItem(
        startDate, endDate, itemId, warehouseId);
    return entries;
  }

  @override
  Future<List<FinishedProductReceiptEntry>> getFinishedProductReceiptEntryByPO(String purchaseOrderNumber, String finishedProductReceiptId) {
    final entries = finishedProductReceiptEntryService.getFinishedProductReceiptEntryByPo(purchaseOrderNumber, finishedProductReceiptId);
    return entries;
  }

  @override
  Future<List<FinishedProductReceiptEntry>> getFinishedProductReceiptEntryBySupplier(
      String supplier, DateTime startDate, DateTime endDate) {
    final entries = finishedProductReceiptEntryService.getFinishedProductReceiptEntryBySupplier(
        startDate, endDate, supplier);
    return entries;
  }
}
