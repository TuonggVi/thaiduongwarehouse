import 'package:mobile_warehouse_thaiduong/datasource/service/item_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/item_repository.dart';

class ItemRepoImpl implements ItemRepository {
  ItemService itemService;
  ItemRepoImpl(this.itemService);
  @override
  Future<List<Item>> getAllItem() {
    final items = itemService.getAllItem();
    return items;
  }
  //==
  @override
    Future<List<Item>> getItemByWarehouseId(itemClassId) {
    final items = itemService.getItemByWarehouseId(itemClassId);
    return items;
  }
  @override
    Future<List<ItemClass>> getAllItemClass() {
    final itemClass = itemService.getAllItemClass();
    return itemClass;
  }
 
}
