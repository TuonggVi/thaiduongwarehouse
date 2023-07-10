import 'package:mobile_warehouse_thaiduong/domain/entities/department.dart';

abstract class InfoRepository {
  Future<List<Department>> getAllDepartment();
  Future<List<String>> getAllReceiver();
  Future<List<String>> getAllSupplier();
  Future<List<String>> getAllPO();
}
