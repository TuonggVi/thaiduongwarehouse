
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/entities/item.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_usecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/item_lot_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/isolation_events.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/isolation_states.dart';

class IsolationBloc extends Bloc<IsolationEvent, IsolationState> {
  ItemUsecase itemUsecase;
  ItemLotUsecase itemLotUsecase;
  IsolationBloc(this.itemUsecase, this.itemLotUsecase)
      : super(GetAllItemLoadingState(DateTime.now())) {
    on<GetAllItemEvent>((event, emit) async {
      emit(GetAllItemLoadingState(DateTime.now()));
      try {
        final items = await itemUsecase.getAllItem();
        emit(GetAllItemSuccessState(DateTime.now(), items, 
        //items
        ));
      } catch (e) {
        //emit(Load(DateTime.now()));
      }
    });
    // list lô hàng theo itemId
    on<GetLotByItemIdEvent>((event, emit) async {
      emit(GetLotByItemIdLoadingState(DateTime.now()));
      try {
        final itemLot = await itemLotUsecase.getItemLotsByItemId(event.itemId);
        itemLot.isNotEmpty
            ? emit(GetLotByItemIdSuccessState(DateTime.now(), event.itemId, itemLot,
  //           event.listItem
             ))
            : emit(GetLotByItemIdFailState(
                DateTime.now(),
              ));
      } catch (e) {
        emit(GetLotByItemIdFailState(DateTime.now()));
      }
    });

// chọn lô để cách ly
    on<PostNewIsolationEvent>((event, emit) async {
      
    });
// Danh sách hàng hóa đang chờ xử lý
    on<GetAllIsolationLotEvent>((event, emit) async {
      
    });
  }


}
