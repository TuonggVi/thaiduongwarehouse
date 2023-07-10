
import '../../entities/finish_product/finished_product_receipt_entry.dart';

abstract class FinishedProductReceiptEntryRepository{
  Future<List<FinishedProductReceiptEntry>> getFinishedProductReceiptEntryByPO(String purchaseOrderNumber,String finishedProductReceiptId );
  Future<List<FinishedProductReceiptEntry>> getFinishedProductReceiptEntryBySupplier(
      String supplier, DateTime startDate, DateTime endDate);
  Future<List<FinishedProductReceiptEntry>> getFinishedProductReceiptEntryByItem(
      String warehouseId, String itemId, DateTime startDate, DateTime endDate);
}
