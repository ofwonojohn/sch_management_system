import 'package:hive/hive.dart';

part 'student_model.g.dart';

@HiveType(typeId: 0)
class StudentModel extends HiveObject {
  @HiveField(0)
  final String fullName;

  @HiveField(1)
  final String studentID;

  @HiveField(2)
  final String studentClass;

  @HiveField(3)
  final String level;

  @HiveField(4)
  final String dob;

  @HiveField(5)
  final String gender;

  @HiveField(6)
  final String guardianContact;

  StudentModel({
    required this.fullName,
    required this.studentID,
    required this.studentClass,
    required this.level,
    required this.dob,
    required this.gender,
    required this.guardianContact,
  });
}
