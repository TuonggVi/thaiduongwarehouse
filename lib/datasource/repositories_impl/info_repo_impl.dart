import 'package:mobile_warehouse_thaiduong/datasource/models/department_model.dart';
import 'package:mobile_warehouse_thaiduong/datasource/service/department_service.dart';
import 'package:mobile_warehouse_thaiduong/domain/repositories/info_repository.dart';

import '../service/list_purchaseorder_service.dart';
import '../service/list_receiver_service.dart';
import '../service/list_supplier_service.dart';

class InfoRepoImpl implements InfoRepository {
  final DepartmentService departmentService;
  final PODataService poDataService;
  final ReceiverListService receiverListService;
  final SupplierService supplierService;
  InfoRepoImpl(this.departmentService, this.poDataService,
      this.receiverListService, this.supplierService);
  @override
  Future<List<DepartmentModel>> getAllDepartment() {
    final departments = departmentService.getDepartments();
    return departments;
  }

  @override
  Future<List<String>> getAllPO() {
    final listPo = poDataService.getAllPO();
    return listPo;
  }

  @override
  Future<List<String>> getAllReceiver() {
    final listReciever = receiverListService.getAllReceiverId();
    return listReciever;
  }

  @override
  Future<List<String>> getAllSupplier() {
    final listSuppier = supplierService.getAllSupplierId();
    return listSuppier;
  }
}
