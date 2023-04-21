import 'package:mobile_warehouse_thaiduong/domain/entities/inventory_log_entry.dart';


abstract class InventoryRepository {
  Future<List<InventoryLogEntry>> getInventoryByTime(
      String startDate, String endDate);
  Future<List<InventoryLogEntry>> getInventoryByItemClass(
      DateTime startDate, DateTime endDate, String itemClassId);
  Future<List<InventoryLogEntry>> getInventoryByItemId(
      DateTime startDate, 
      DateTime endDate, 
      String itemId
      );
    // test giao diện
  Future<List<InventoryLogEntry>> getInventoryLotByItemClassId(
      DateTime dateTime, String itemClassId);
  

}
