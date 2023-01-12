import 'package:users_app/models/active_nearby_available_drivers.dart';
import 'package:users_app/models/broadcast_model.dart';

class GeoFireAssistant
{
  static List<ActiveNearbyAvailableDrivers> activeNearbyAvailableDriversList = [];
  static List<BroadcastData> broadcastDataList = [];

  static void deleteOfflineDriverFromList(String driverId)
  {
    int indexNumber = activeNearbyAvailableDriversList.indexWhere((element) => element.driverId == driverId);
    activeNearbyAvailableDriversList.removeAt(indexNumber);
  }

  static void updateActiveNearbyAvailableDriverLocation(ActiveNearbyAvailableDrivers driverWhoMove)
  {
    int indexNumber = activeNearbyAvailableDriversList.indexWhere((element) => element.driverId == driverWhoMove.driverId);

    activeNearbyAvailableDriversList[indexNumber].locationLatitude = driverWhoMove.locationLatitude;
    activeNearbyAvailableDriversList[indexNumber].locationLongitude = driverWhoMove.locationLongitude;
  }


}