import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@injectable
@lazySingleton
class LocationService {
  Future<Position> getCurrentPostition() async {
    return await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
