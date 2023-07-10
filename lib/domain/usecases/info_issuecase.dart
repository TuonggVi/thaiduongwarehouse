import 'package:mobile_warehouse_thaiduong/domain/repositories/info_repository.dart';

import '../entities/department.dart';

class InfoUsecase {
  InfoRepository infoRepository;
  InfoUsecase(this.infoRepository);
  Future<List<Department>> getAllDepartment() async {
    final departments = infoRepository.getAllDepartment();
    return departments;
  }

  Future<List<String>> getAllReceiver() async {
    final receivers = infoRepository.getAllReceiver();
    return receivers;
  }

  Future<List<String>> getAllSupplier() async {
    final suppliers = infoRepository.getAllSupplier();
    return suppliers;
  }

  Future<List<String>> getAllPO() async {
    final poNumbers = infoRepository.getAllPO();
    return poNumbers;
  }
}
