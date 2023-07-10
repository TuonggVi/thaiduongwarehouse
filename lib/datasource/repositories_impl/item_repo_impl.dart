import 'package:mobile_warehouse_thaiduong/datasource/service/item_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/item_repository.dart';

class ItemRepoImpl implements ItemRepository {
  ItemService itemService;
  ItemRepoImpl(this.itemService);
  @override
  Future<List<Item>> getAllItems() {
    final items = itemService.getAllItems();
    return items;
  }

  @override
  Future<ErrorPackage> postNewItems(Item item) {
    final status = itemService.postNewItems(item);
    return status;
  }
}
