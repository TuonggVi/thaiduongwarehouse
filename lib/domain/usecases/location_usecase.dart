import 'package:mobile_warehouse_thaiduong/domain/entities/location.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/location_repository.dart';

class LocationUsecase {
  final LocationRepository locationRepository;
  LocationUsecase(this.locationRepository);
  Future<List<String>> getAllLocationId() async {
    final locationIds = locationRepository.getAllLocationId();
    return locationIds;
  }
  Future<List<Warehouse>> getAllWarehouse() async{
    final warehouse = locationRepository.getAllWarehouse();
    return warehouse;
  }
}
 