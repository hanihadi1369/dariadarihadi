// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sim_charge_transaction.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SimChargeTransactionAdapter extends TypeAdapter<SimChargeTransaction> {
  @override
  final int typeId = 0;

  @override
  SimChargeTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SimChargeTransaction(
      phoneNumber: fields[0] as String?,
      operatorType: fields[1] as int?,
      simCardType: fields[2] as int?,
      chargeAmountType: fields[3] as int?,
      paymentType: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SimChargeTransaction obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.phoneNumber)
      ..writeByte(1)
      ..write(obj.operatorType)
      ..writeByte(2)
      ..write(obj.simCardType)
      ..writeByte(3)
      ..write(obj.chargeAmountType)
      ..writeByte(4)
      ..write(obj.paymentType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimChargeTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
