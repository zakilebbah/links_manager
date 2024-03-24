// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pageLink.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PageLinkAdapter extends TypeAdapter<PageLink> {
  @override
  final int typeId = 1;

  @override
  PageLink read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PageLink(
      URL: fields[0] as String,
      NAME: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, PageLink obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.URL)
      ..writeByte(1)
      ..write(obj.NAME);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PageLinkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
