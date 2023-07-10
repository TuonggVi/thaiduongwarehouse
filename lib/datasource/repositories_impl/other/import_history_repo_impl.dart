import 'package:mobile_warehouse_thaiduong/datasource/service/other/import_history_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/import_history_entry.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/import_history_repository.dart';

import '../../../domain/entities/error_package.dart';
import '../../../domain/entities/other/goods_receipt.dart';

class ImportHistoryRepoImpl implements ImportHistoryRepoitory {
  final ImportHistoryService importHistoryService;
  ImportHistoryRepoImpl(this.importHistoryService);
  @override
  Future<List<ImportHistoryEntry>> getImportHistoryByItem(
      String warehouseId, String itemId, DateTime startDate, DateTime endDate) {
    final entries = importHistoryService.getImportHistoryByItem(
        startDate, endDate, itemId, warehouseId);
    return entries;
  }

  @override
  Future<List<ImportHistoryEntry>> getImportHistoryByPO(String poNumber) {
    final entries = importHistoryService.getImportHistoryByPo(poNumber);
    return entries;
  }
 @override
  Future<ErrorPackage> postAddNewGoodsReceipt(GoodsReceipt goodsReceipt) {
    final status = importHistoryService.postAddNewGoodsReceipt(goodsReceipt);
    return status;
  }
  @override
  Future<List<ImportHistoryEntry>> getImportHistoryBySupplier(
      String supplier, DateTime startDate, DateTime endDate) {
    final entries = importHistoryService.getImportHistoryBySupplier(
        startDate, endDate, supplier);
    return entries;
  }
}
