// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_cache_entry_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoviesCacheEntryHiveModelAdapter
    extends TypeAdapter<MoviesCacheEntryHiveModel> {
  @override
  final int typeId = 2;

  @override
  MoviesCacheEntryHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MoviesCacheEntryHiveModel(
      key: fields[0] as String,
      updatedAt: fields[1] as int,
      movies: (fields[2] as List).cast<MovieHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, MoviesCacheEntryHiveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.updatedAt)
      ..writeByte(2)
      ..write(obj.movies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviesCacheEntryHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
