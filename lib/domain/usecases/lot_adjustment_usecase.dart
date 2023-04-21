import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/lot_adjustment.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/lot_adjment_repository.dart';

class LotAdjustmentUsecase {
  final LotAdjustmentRepository lotAdjustmentRepository;
  LotAdjustmentUsecase(this.lotAdjustmentRepository);
  Future<ErrorPackage> postNewLotAdjustment( 
    double afterQuantity, 
    String newPurchaseOrderNumber, 
    String notes) async {
    final status = lotAdjustmentRepository.postNewLotAdjustment( 
    afterQuantity, 
    newPurchaseOrderNumber, 
    notes);
    return status;
  }
  Future<List<LotAdjustment>> getAllLotAdjustment() async {
    final lotsAdjust = lotAdjustmentRepository.getAllLotAdjustment();
    return lotsAdjust;
  }
}
