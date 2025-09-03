// ignore_for_file: one_member_abstracts

import 'package:planets_app_test/core/core.dart';
import 'package:planets_app_test/features/planets/data/data.dart';

abstract interface class IPlanetsRemoteDatasource {
  FutureHttpRequest<List<PlanetModel>> all();
}
