import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/error_package.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/other/item_lot.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/other/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/other/isolation_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/other/isolation_states.dart';

import '../../../../domain/entities/item.dart';

class IsolationBloc extends Bloc<IsolationEvent, IsolationState> {
  ItemUsecase itemUsecase;
  ItemLotUsecase itemLotUsecase;
  IsolationBloc(this.itemUsecase, this.itemLotUsecase)
      : super(IsolationInitState(DateTime.now())) {
    on<GetLotByLotIdEvent>((event, emit) async {
            List<ItemLot> listIsolation = [];
      emit(GetLotByLotIdLoadingState(DateTime.now()));
      try {
        final itemLot = await itemLotUsecase.getItemLotById(event.lotId);
         listIsolation.add(ItemLot(
            itemLot.lotId, Item('', '', '', '', null,null), null, itemLot.quantity, itemLot.productionDate, itemLot.expirationDate, itemLot.itemLotSubLot));
        emit(GetLotByLotIdSuccessState(
          DateTime.now(),
          itemLot,
        ));
      } catch (e) {
        emit(GetLotByLotIdFailState(DateTime.now()));
      }
    });

    on<PostNewIsolationEvent>((event, emit) async {
      emit(PostNewIsolationLoadingState(DateTime.now()));
      try {
        final status =
            await itemLotUsecase.patchIsolationItemLot(true, event.lotId);
        status.detail == 'Success'
            ? emit(PostNewIsolationSuccessState(
                DateTime.now(),
                status,
              ))
            : emit(PostNewIsolationFailState(
                DateTime.now(), ErrorPackage('Lô không tồn tại')));
      } catch (e) {
        emit(PostNewIsolationFailState(
            DateTime.now(), ErrorPackage('Không thể truy xuất')));
      }
    });
// Danh sách hàng hóa đang chờ xử lý
    on<GetAllIsolationLotEvent>((event, emit) async {

       emit(GetAllIsolationLotLoadingState(DateTime.now()));
      try {
        final List<ItemLot> lots = await itemLotUsecase.getIsolatedItemLots();
        lots.isNotEmpty ?
        emit(GetAllIsolationLotSuccessState(DateTime.now(), lots)):        
        emit(GetAllIsolationLotFailState(DateTime.now(),ErrorPackage('Không tồn tại')));

      } catch (e) {
        emit(GetAllIsolationLotFailState(DateTime.now(),ErrorPackage('Lỗi hệ thống')));
      }
    });
  }
}
