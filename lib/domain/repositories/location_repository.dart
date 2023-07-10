import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';

abstract class LocationRepository {
  Future<List<String>> getAllLocationId();
  Future<List<Warehouse>> getAllWarehouseId();
}
