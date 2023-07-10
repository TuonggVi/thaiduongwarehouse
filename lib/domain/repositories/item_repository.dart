import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';

import '../entities/error_package.dart';

abstract class ItemRepository {
  Future<List<Item>> getAllItems();
  //Future<Item> getItemByItemId(String itemId);
  // tra ve trang thai co post len thanh cong hay khong
  Future<ErrorPackage> postNewItems(Item item);
}
