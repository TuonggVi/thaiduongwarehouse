import 'package:mobile_warehouse_thaiduong/datasource/service/inventory_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/inventory_log_entry.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/inventory_repository.dart';

class InventoryRepoImpl implements InventoryRepository {
  final InventoryService inventoryService;
  InventoryRepoImpl(this.inventoryService);
  @override
  Future<List<InventoryLogEntry>> getInventoryByItemClass(
      DateTime startDate, DateTime endDate, String itemClassId) {
    final inventoryLogEntry = inventoryService.getInventoryByItemClass(
        startDate, endDate, itemClassId);
    return inventoryLogEntry;
  }

  @override
  Future<List<InventoryLogEntry>> getInventoryByItemId(
      DateTime startDate, DateTime endDate, String itemId) {
    final inventoryLogEntry =
        inventoryService.getInventoryByItemId(startDate, endDate, itemId);
    return inventoryLogEntry;
  }

  @override
  Future<List<InventoryLogEntry>> getInventoryByTime(
      String startDate, String endDate) {
    final inventoryLogEntry =
        inventoryService.getInventoryByTime(startDate, endDate);
    return inventoryLogEntry;
  }
  // thử giao diện
    @override
  Future<List<InventoryLogEntry>> getInventoryLotByItemClassId(
      DateTime dateTime, String warehouseName) {
    final inventoryLogEntry =
        inventoryService.getInventoryLotByItemClassId(dateTime, warehouseName);
    return inventoryLogEntry;
  }
}
