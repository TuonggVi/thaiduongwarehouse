import 'package:mobile_warehouse_thaiduong/domain/entities/other/import_history_entry.dart';

import '../../entities/error_package.dart';
import '../../entities/other/goods_receipt.dart';

abstract class ImportHistoryRepoitory {
  Future<List<ImportHistoryEntry>> getImportHistoryByPO(String poNumber);
  Future<List<ImportHistoryEntry>> getImportHistoryBySupplier(
      String supplier, DateTime startDate, DateTime endDate);
  Future<List<ImportHistoryEntry>> getImportHistoryByItem(
      String warehouseId, String itemId, DateTime startDate, DateTime endDate);
        Future<ErrorPackage> postAddNewGoodsReceipt(
       GoodsReceipt goodsReceipt);
}
