import 'package:mobile_warehouse_thaiduong/datasource/service/other/lot_adjustment_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/lot_adjustment.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/other/lot_adjment_repository.dart';


class LotAjustmentRepoImpl implements LotAdjustmentRepository {
  final LotAdjustmentService lotAdjustmentService;
  LotAjustmentRepoImpl(this.lotAdjustmentService);
  @override
  Future<List<LotAdjustment>> getAllLotAdjustment() {
    final lotAdjust = lotAdjustmentService.getAllLotAdjustment();
    return lotAdjust;
  }

  @override
  Future<ErrorPackage> postNewLotAdjustment(String employeename, LotAdjustment lotAdjustment) {
    final lotAdjust = lotAdjustmentService.postNewLotAdjustment( employeename, lotAdjustment);
    return lotAdjust;
  }
}
