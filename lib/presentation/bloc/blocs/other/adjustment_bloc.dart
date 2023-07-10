import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/datasource/models/error_package_model.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/item_lot.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/lot_adjustment.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/adjustment_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/adjustment_states.dart';

import '../../../../domain/usecases/other/lot_adjustment_usecase.dart';

class AdjustmentBloc extends Bloc<AdjustmentEvent, AdjustmentState> {
  LotAdjustmentUsecase lotAdjustmentUsecase;
  ItemLotUsecase itemLotUsecase;
  AdjustmentBloc(this.lotAdjustmentUsecase, this.itemLotUsecase)
      : super(GetLotDetailLoadingState(DateTime.now())) {
    on<GetLotEvent>((event, emit) async {
      List<LotAdjustment> listLotAjustment = [];
      emit(GetLotDetailLoadingState(DateTime.now()));
      try {
        // final List<ItemLot> lotsAdjust =
        //     await itemLotUsecase.getItemLotsByItemId(event.lotId);
        // for (var element in lotsAdjust) {
        //   listLotAjustment.add(LotAdjustment(
        //       element.lotId,
        //       '',
        //       null,
        //       null,
        //       null,
        //       element.quantity,
        //       element.purchaseOrderNumber,
        //       null,
        //       element.item,
        //       null));
        // }
         
        final ItemLot lot =
            await itemLotUsecase.getItemLotById(event.lotId);
             listLotAjustment.add(LotAdjustment(
              lot.lotId,
              '',
              null,
              null,
              null,
              lot.quantity,
              lot.purchaseOrderNumber,
              null,
              lot.item,
              null));
        emit(GetLotDetailSuccessState(DateTime.now(), listLotAjustment));
      } catch (e) {
        emit(GetLotDetailFailState(DateTime.now()));
      }
    });

    on<UpdateLotAdjustmentQuantityEvent>((event, emit) async {
      emit(UpdateLotQuantityLoadingState(DateTime.now()));
      try {
        final ErrorPackage postNewAdjust =
            await lotAdjustmentUsecase.postNewLotAdjustment(
                event.employeeName, event.lotAdjustment);
        if (postNewAdjust.detail == 'success') {
          emit(UpdateLotQuantitySuccessState(
            DateTime.now(),
            ErrorPackageModel('Thành công'),
          ));
        } else {
          emit(UpdateLotQuantityFailState(
            DateTime.now(),
            ErrorPackageModel('Thất bại'),
          ));
        }
      } catch (e) {
        emit(UpdateLotQuantityFailState(
          DateTime.now(),
          ErrorPackageModel('Thất bại'),
        ));
      }
    });
  }
}
