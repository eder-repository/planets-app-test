import 'package:flutter/foundation.dart';

@immutable
class Planet {
  const Planet({
    required this.name,
    required this.image,
    this.orbitalDistanceKm,
    this.equatorialRadiusKm,
    this.volumeKm3,
    this.massKg,
    this.densityGCm3,
    this.surfaceGravityMS2,
    this.escapeVelocityKmh,
    this.dayLengthEarthDays,
    this.yearLengthEarthDays,
    this.orbitalSpeedKmh,
    this.moons,
    this.atmosphereComposition,
    this.description,
    this.favorite = false,
  });

  final String name;
  final String image;
  final int? orbitalDistanceKm;
  final int? equatorialRadiusKm;
  final String? volumeKm3;
  final String? massKg;
  final double? densityGCm3;
  final double? surfaceGravityMS2;
  final int? escapeVelocityKmh;
  final double? dayLengthEarthDays;
  final double? yearLengthEarthDays;
  final int? orbitalSpeedKmh;
  final int? moons;
  final String? atmosphereComposition;
  final String? description;
  final bool favorite;

  @override
  int get hashCode => Object.hash(
    name,
    image,
    orbitalDistanceKm,
    equatorialRadiusKm,
    volumeKm3,
    massKg,
    densityGCm3,
    surfaceGravityMS2,
    escapeVelocityKmh,
    dayLengthEarthDays,
    yearLengthEarthDays,
    orbitalSpeedKmh,
    moons,
    atmosphereComposition,
    description,
    favorite,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Planet &&
          name == other.name &&
          image == other.image &&
          orbitalDistanceKm == other.orbitalDistanceKm &&
          equatorialRadiusKm == other.equatorialRadiusKm &&
          volumeKm3 == other.volumeKm3 &&
          massKg == other.massKg &&
          densityGCm3 == other.densityGCm3 &&
          surfaceGravityMS2 == other.surfaceGravityMS2 &&
          escapeVelocityKmh == other.escapeVelocityKmh &&
          dayLengthEarthDays == other.dayLengthEarthDays &&
          yearLengthEarthDays == other.yearLengthEarthDays &&
          orbitalSpeedKmh == other.orbitalSpeedKmh &&
          moons == other.moons &&
          atmosphereComposition == other.atmosphereComposition &&
          description == other.description &&
          favorite == other.favorite;
}
