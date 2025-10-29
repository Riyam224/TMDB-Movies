// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieModelAdapter extends TypeAdapter<MovieModel> {
  @override
  final int typeId = 1;

  @override
  MovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieModel(
      id: fields[0] as int,
      title: fields[1] as String,
      overview: fields[2] as String,
      posterPath: fields[3] as String?,
      voteAverage: fields[4] as double,
      genreIds: (fields[5] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, MovieModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.overview)
      ..writeByte(3)
      ..write(obj.posterPath)
      ..writeByte(4)
      ..write(obj.voteAverage)
      ..writeByte(5)
      ..write(obj.genreIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'genre_ids': instance.genreIds,
    };
