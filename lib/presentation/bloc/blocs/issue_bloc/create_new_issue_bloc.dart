import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/department_issuecase.dart';
import 'package:mobile_warehouse_thaiduong/domain/usecases/goods_issue_usecase.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/events/issue_event/create_new_issue_event.dart';
import 'package:mobile_warehouse_thaiduong/presentation/bloc/states/issue_state/create_new_issue_state.dart';

class CreateIssueBloc extends Bloc<CreateNewIssueEvent, CreaNewIssueState> {
  GoodsIssueUseCase goodsIssueUseCase;
  DepartmentUsecase departmentUsecase;
  CreateIssueBloc(this.goodsIssueUseCase, this.departmentUsecase)
      : super(CreateNewIssueInitialState()) {
    on<LoadListDataEvent>((event, emit) async {
      emit(LoadDepartmentLoadingState(DateTime.now()));
      try {
        final department = await departmentUsecase.getAllDepartment();
        emit(LoadListDataSuccessState(
            department, event.entriesIssue, const [], DateTime.now()));
      } catch (e) {
        // emit(LoginStateLoginFailure(DateTime.now()));
      }
    });
    on<AddIssueEntryEvent>((event, emit) async {
      emit(UpdateEntryToGoodsIssueLoading(DateTime.now()));
      try {
        event.issueEntries.add(event.issueEntry);
        emit(UpdateEntryToGoodsIssueSuccess(
          DateTime.now(),
       
          event.issueEntries,
        ));
      } catch (e) {
        // emit(LoginStateLoginFailure(DateTime.now()));
      }
    });
    on<UpdateIssueEntryEvent>((event, emit) async {
      emit(UpdateEntryToGoodsIssueLoading(DateTime.now()));
      try {
        event.issueEntries.removeAt(event.index);
        event.issueEntries.insert(event.index, event.issueEntry);
        emit(UpdateEntryToGoodsIssueSuccess(
          DateTime.now(),
         
          event.issueEntries,
        ));
      } catch (e) {
        // emit(LoginStateLoginFailure(DateTime.now()));
      }
    });
  }
}