import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/lot_adjustment.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/lot_adjment_repository.dart';



class LotAdjustmentUsecase {
  final LotAdjustmentRepository lotAdjustmentRepository;
  LotAdjustmentUsecase(this.lotAdjustmentRepository);
  Future<ErrorPackage> postNewLotAdjustment( String employeename, LotAdjustment lotAdjustment) async {
    final status = lotAdjustmentRepository.postNewLotAdjustment( employeename, lotAdjustment);
    return status;
  }

  Future<List<LotAdjustment>> getAllLotAdjustment() async {
    final lotsAdjust = lotAdjustmentRepository.getAllLotAdjustment();
    return lotsAdjust;
  }
}
