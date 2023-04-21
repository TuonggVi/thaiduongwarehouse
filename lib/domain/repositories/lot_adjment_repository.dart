import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/lot_adjustment.dart';

abstract class LotAdjustmentRepository {
  Future<ErrorPackage> postNewLotAdjustment(
    double afterQuantity, 
    String newPurchaseOrderNumber, 
    String notes);
  Future<List<LotAdjustment>> getAllLotAdjustment();

     
}
