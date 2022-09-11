// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wordModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyWordAdapter extends TypeAdapter<MyWord> {
  @override
  final int typeId = 0;

  @override
  MyWord read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyWord(
      fields[1] as String,
      fields[2] as String,
      fields[3] as bool,
      fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MyWord obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.word)
      ..writeByte(2)
      ..write(obj.definition)
      ..writeByte(3)
      ..write(obj.wordToDef)
      ..writeByte(4)
      ..write(obj.defToWord);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyWordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
