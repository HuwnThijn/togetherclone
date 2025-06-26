import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:lovejourney/cores/enumlist.dart';
import 'package:lovejourney/gen/assets.gen.dart';

class PurchasableProduct {
  String get id => productDetails.id;
  String get title => productDetails.title;
  String get description => productDetails.description;
  String get price => productDetails.price;
  ProductStatus status;
  ProductDetails productDetails;

  int get coin => getCoin(productDetails.id);
  String get image => getImage(productDetails.id);

  PurchasableProduct(this.productDetails) : status = ProductStatus.purchasable;

  int getCoin(String idProduct) {
    switch (idProduct) {
      case 'most_inapp_0':
        return 5;
      case 'most_inapp_1':
        return 10;
      case 'most_inapp_2':
        return 20;
      case 'most_inapp_3':
        return 30;
      case 'most_inapp_4':
        return 50;
      case 'most_inapp_5':
        return 90;
      case 'most_inapp_6':
        return 120;
      case 'most_inapp_7':
        return 180;
      case 'most_inapp_8':
        return 240;
      case 'most_inapp_9':
        return 310;
      case 'most_inapp_10':
        return 510;
      case 'most_inapp_11':
        return 650;
      case 'most_inapp_12':
        return 1330;
    }
    return 0;
  }

  String getImage(String idProduct) {
    return AssetsClass.images.imageStar2.path;
    // switch (idProduct) {
    //   case 'most_inapp_0':
    //     return AssetsClass.images.imageStar1.path;
    //   case 'most_inapp_1':
    //     return AssetsClass.images.imageStar1.path;
    //   case 'most_inapp_2':
    //     return AssetsClass.images.imageStar1.path;
    //   case 'most_inapp_3':
    //     return AssetsClass.images.imageStar1.path;
    //   case 'most_inapp_4':
    //     return AssetsClass.images.imageStar1.path;
    //   case 'most_inapp_5':
    //     return AssetsClass.images.imageStar1.path;
    //   case 'most_inapp_6':
    //     return AssetsClass.images.imageStar6.path;
    //   case 'most_inapp_7':
    //     return AssetsClass.images.imageStar7.path;
    //   case 'most_inapp_8':
    //     return AssetsClass.images.imageStar8.path;
    //   case 'most_inapp_9':
    //     return AssetsClass.images.imageStar9.path;
    //   case 'most_inapp_10':
    //     return AssetsClass.images.imageStar10.path;
    //   case 'most_inapp_11':
    //     return AssetsClass.images.imageStar11.path;
    //   case 'most_inapp_12':
    //     return AssetsClass.images.imageStar12.path;
    // }
    // return '';
  }
}
