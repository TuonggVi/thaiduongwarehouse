
import '../../entities/finish_product/finished_product_inventory.dart';

abstract class FinishedProductInventoryRepository{
  Future<List<FinishedProductInventory>> getFinishedProductInventoryByTime(
      DateTime startDate, DateTime endDate);
  Future<List<FinishedProductInventory>> getFinishedProductInventoryByItemClass(
      DateTime startDate, DateTime endDate, String itemClassId);
}
