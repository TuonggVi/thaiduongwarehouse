

import '../../../domain/entities/finish_product/finished_product_inventory.dart';
import '../../../domain/repositories/finish_product/finished_product_inventory_repository.dart';
import '../../service/finish_product/finished_product_inventory_service.dart';

class FinishedProductInventoryRepoImpl implements FinishedProductInventoryRepository {
  final FinishedProductInventoryService finishedProductInventoryService;
  FinishedProductInventoryRepoImpl(this.finishedProductInventoryService);
  @override
  Future<List<FinishedProductInventory>> getFinishedProductInventoryByItemClass(
      DateTime startDate, DateTime endDate, String itemClassId) {
    final finishedProductInventoryLog = finishedProductInventoryService.getFinishedProductInventoryByItemClass(
        startDate, endDate, itemClassId);
    return finishedProductInventoryLog;
  }
  @override
  Future<List<FinishedProductInventory>> getFinishedProductInventoryByTime(
      DateTime startDate, DateTime endDate) {
    final finishedProductInventoryLog =
        finishedProductInventoryService.getFinishedProductInventoryByTime(startDate, endDate);
    return finishedProductInventoryLog;
  }

}
