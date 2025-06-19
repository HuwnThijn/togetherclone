import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lovejourney/cores/extentions/messagingservice.dart';
import 'package:lovejourney/cores/purchase/in_app_purchase.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';

final serviceLocator = GetIt.instance;
Future<void> setUpServiceLocator() async {
  serviceLocator.registerSingleton<SharePrefer>(SharePrefer());
  await serviceLocator<SharePrefer>().init();
  serviceLocator.registerSingleton<ImagePicker>(ImagePicker());
  serviceLocator.registerSingleton<LocalInAppPurchase>(LocalInAppPurchase());
  serviceLocator.registerSingleton<MessagingService>(MessagingService());
}
