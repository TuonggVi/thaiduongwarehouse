import 'package:mobile_warehouse_thaiduong/datasource/service/location_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/location_repository.dart';

class LocationRepoImpl implements LocationRepository {
  final LocationService locationService;
  LocationRepoImpl(this.locationService);
  @override
  Future<List<String>> getAllLocationId() {
    throw UnimplementedError();
  }

  @override
  Future<List<Warehouse>> getAllWarehouseId() {
    final warehouseList = locationService.getAllWarehouseId();
    return warehouseList;
  }
}
