// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datatodo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataToDoAdapter extends TypeAdapter<DataToDo> {
  @override
  final int typeId = 0;

  @override
  DataToDo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataToDo(
      fields[0] as String,
      fields[1] as DateTime?,
      fields[2] as DateTime?,
      fields[3] as bool,
      fields[4] as bool,
      fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DataToDo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.todos)
      ..writeByte(1)
      ..write(obj.startDate)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.isPriority)
      ..writeByte(5)
      ..write(obj.desc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataToDoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
