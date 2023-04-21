import 'package:mobile_warehouse_thaiduong/datasource/service/lot_adjustment_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/lot_adjustment.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/lot_adjment_repository.dart';

class LotAjustmentRepoImpl implements LotAdjustmentRepository {
  final LotAdjustmentService lotAdjustmentService;
  LotAjustmentRepoImpl(this.lotAdjustmentService);
  @override
  Future<List<LotAdjustment>> getAllLotAdjustment() {
   final lotAdjustment = lotAdjustmentService.getAllLotAdjustment();
    return lotAdjustment;
  }
    @override
  Future<ErrorPackage> postNewLotAdjustment(
      double afterQuantity, String newPurchaseOrderNumber, String notes)async {
    final status = lotAdjustmentService.postNewLotAdjustment(
       afterQuantity, newPurchaseOrderNumber, notes);
    return status;
  }
  
}
