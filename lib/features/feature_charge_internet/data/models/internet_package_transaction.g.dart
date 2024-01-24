// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internet_package_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class InternetPackageTransactionAdapter
    extends TypeAdapter<InternetPackageTransaction> {
  @override
  final int typeId = 1;

  @override
  InternetPackageTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return InternetPackageTransaction(
      phoneNumber: fields[0] as String?,
      operatorType: fields[1] as int?,
      simCardType: fields[2] as int?,
      bundleID: fields[3] as String?,
      bundleName: fields[4] as String?,
      paymentType: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, InternetPackageTransaction obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.phoneNumber)
      ..writeByte(1)
      ..write(obj.operatorType)
      ..writeByte(2)
      ..write(obj.simCardType)
      ..writeByte(3)
      ..write(obj.bundleID)
      ..writeByte(4)
      ..write(obj.bundleName)
      ..writeByte(5)
      ..write(obj.paymentType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InternetPackageTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
