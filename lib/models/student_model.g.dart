// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelAdapter extends TypeAdapter<StudentModel> {
  @override
  final int typeId = 0;

  @override
  StudentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModel(
      fullName: fields[0] as String,
      studentID: fields[1] as String,
      studentClass: fields[2] as String,
      level: fields[3] as String,
      dob: fields[4] as String,
      gender: fields[5] as String,
      guardianContact: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StudentModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.fullName)
      ..writeByte(1)
      ..write(obj.studentID)
      ..writeByte(2)
      ..write(obj.studentClass)
      ..writeByte(3)
      ..write(obj.level)
      ..writeByte(4)
      ..write(obj.dob)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.guardianContact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
