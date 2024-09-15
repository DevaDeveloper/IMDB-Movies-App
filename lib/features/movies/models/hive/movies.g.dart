// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MoviesAdapter extends TypeAdapter<Movies> {
  @override
  final int typeId = 1;

  @override
  Movies read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Movies(
      favouriteMovies: (fields[0] as List?)?.cast<Results>(),
      popularMovies: (fields[1] as List?)?.cast<Results>(),
    );
  }

  @override
  void write(BinaryWriter writer, Movies obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.favouriteMovies)
      ..writeByte(1)
      ..write(obj.popularMovies);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoviesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
