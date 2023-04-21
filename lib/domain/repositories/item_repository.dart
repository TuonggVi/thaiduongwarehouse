import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getAllItem();
  Future<List<Item>> getItemByWarehouseId(itemClassId);
  Future<List<ItemClass>> getAllItemClass();

}
