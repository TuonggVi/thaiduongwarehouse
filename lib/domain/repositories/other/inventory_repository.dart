import 'package:mobile_warehouse_thaiduong/domain/entities/other/inventory_log_entry.dart';

abstract class InventoryRepository {
  Future<List<InventoryLogEntry>> getInventoryByTime(
      DateTime startDate, DateTime endDate);
  Future<List<InventoryLogEntry>> getInventoryByItemClass(
      DateTime startDate, DateTime endDate, String itemClassId);
  Future<List<InventoryLogEntry>> getInventoryByItemId(
      DateTime startDate, DateTime endDate, String itemId);
}
