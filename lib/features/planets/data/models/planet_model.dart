// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/features/planets/domain/domain.dart';

part 'planet_model.freezed.dart';
part 'planet_model.g.dart';

@freezed
sealed class PlanetModel with _$PlanetModel, EntityConvertible<Planet> {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  factory PlanetModel({
    required String name,
    required String image,
    int? orbitalDistanceKm,
    int? equatorialRadiusKm,
    @StringOrNumToString() String? volumeKm3,
    String? massKg,
    double? densityGCm3,
    double? surfaceGravityMS2,
    int? escapeVelocityKmh,
    double? dayLengthEarthDays,
    double? yearLengthEarthDays,
    int? orbitalSpeedKmh,
    int? moons,
    String? atmosphereComposition,
    String? description,
    @Default(false) bool favorite,
  }) = _PlanetModel;

  PlanetModel._();

  factory PlanetModel.fromJson(Map<String, dynamic> json) =>
      _$PlanetModelFromJson(json);

  @override
  Planet toEntity() => Planet(
    name: name,
    image: image,
    orbitalDistanceKm: orbitalDistanceKm,
    equatorialRadiusKm: equatorialRadiusKm,
    volumeKm3: volumeKm3,
    massKg: massKg,
    densityGCm3: densityGCm3,
    surfaceGravityMS2: surfaceGravityMS2,
    escapeVelocityKmh: escapeVelocityKmh,
    dayLengthEarthDays: dayLengthEarthDays,
    yearLengthEarthDays: yearLengthEarthDays,
    orbitalSpeedKmh: orbitalSpeedKmh,
    moons: moons,
    atmosphereComposition: atmosphereComposition,
    description: description,
    favorite: favorite,
  );
}

class StringOrNumToString implements JsonConverter<String?, Object?> {
  const StringOrNumToString();

  @override
  String? fromJson(Object? json) {
    if (json == null) return null;
    if (json is String) return json;
    if (json is num) return json.toString();
    return json.toString(); // fallback
  }

  @override
  Object? toJson(String? object) => object;
}
