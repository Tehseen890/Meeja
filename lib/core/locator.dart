import 'package:get_it/get_it.dart';
import 'package:meeja/screens/add_friend/add_friend_provider.dart';

import 'services/auth_services.dart';

GetIt locator = GetIt.instance;
GetIt friendsLocator = GetIt.instance;
// GetIt deviceLocator = GetIt.instance;
setupLocator() {
  print("AuthServices calling");
  locator.registerSingleton(AuthServices());
  friendsLocator.registerSingleton(AddFriend());
  // deviceLocator.registerSingleton(DeviceType());
  // locator.registerSingleton(DatabaseServices());
  print("AuthServices registered");
}
