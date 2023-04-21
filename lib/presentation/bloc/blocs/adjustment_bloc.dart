
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/inventory_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/adjustment_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/adjustment_states.dart';

import '../../../domain/usecases/location_usecase.dart';
import '../../../domain/usecases/lot_adjustment_usecase.dart';

class AdjustmentBloc extends Bloc<AdjustmentEvent, AdjustmentState> {
  ItemUsecase itemUsecase;
  LotAdjustmentUsecase lotAdjustmentUsecase;
  InventoryUsecase inventoryUsecase;
  LocationUsecase locationUsecase;
  AdjustmentBloc(this.inventoryUsecase, this.locationUsecase, this.itemUsecase,
      this.lotAdjustmentUsecase)
      : super(GetLotDetailLoadingState(DateTime.now())) {

    on<GetLotDetailEvent>((event, emit) async {
      emit(GetLotDetailLoadingState(DateTime.now()));
      try {
        final lotsAdjust = await lotAdjustmentUsecase.getAllLotAdjustment();
        emit(GetLotDetailSuccessState(DateTime.now(), lotsAdjust));
      } catch (e) {
        emit(GetLotDetailFailState(DateTime.now()));
      }
    });

    on<UpdateLotAdjustmentQuantityEvent>((event, emit) async {
      emit(UpdateLotQuantityLoadingState(DateTime.now()));
      try {
        event.lotAdjustment.removeAt(event.index);
        event.lotAdjustment.insert(event.index, event.lotAdjustmentView);
        emit(UpdateLotQuantitySuccessState(
          DateTime.now(),
          ErrorPackageModel(''),
        ));
      } catch (e) {
        // emit(LoginStateLoginFailure(DateTime.now()));
      }
    });
  }
}
