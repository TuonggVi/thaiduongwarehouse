import 'package:equatable/equatable.dart';

class Department extends Equatable {
 final String name;
  const Department(this.name);
  @override
  List<Object?> get props => [name];
}