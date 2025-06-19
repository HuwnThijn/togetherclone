import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dynamic_icon_plus/flutter_dynamic_icon_plus.dart';
import 'package:morphable_shape/morphable_shape.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lovejourney/cores/app_colors.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/enumlist.dart';
import 'package:lovejourney/cores/models/icon_app_model.dart';
import 'package:lovejourney/cores/servicelocator/service_locator.dart';
import 'package:lovejourney/cores/store/share_prefer.dart';
import 'package:url_launcher/url_launcher.dart';

createRouter(Widget page, {bool isCupertino = true}) {
  return isCupertino
      ? CupertinoPageRoute(
          builder: (context) => page,
          settings: RouteSettings(name: page.runtimeType.toString()),
        )
      : MaterialPageRoute(
          builder: (context) => page,
          settings: RouteSettings(name: page.runtimeType.toString()),
        );
}

Future<String> copyImageToCache(Uint8List dataCache,
    {required String name}) async {
  final cacheDir = await getTemporaryDirectory();
  final file = File('${cacheDir.path}/$name');
  await file.writeAsBytes(dataCache);
  return file.path;
}

String getRandomString({int length = 10}) {
  const characters =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return String.fromCharCodes(Iterable.generate(
      length, (_) => characters.codeUnitAt(random.nextInt(characters.length))));
}

// String colorToHex(Color color, {bool leadingHashSign = true}) {
//   String hex = color.value.toRadixString(16).padLeft(8, '0').toUpperCase();
//   return leadingHashSign ? '#$hex' : hex;
// }

Color hexToColor(String hexString) {
  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('FF');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
}

Future<void> applyIconChanged(IconAppModel icon) async {
  try {
    if (await FlutterDynamicIconPlus.supportsAlternateIcons) {
      await FlutterDynamicIconPlus.setAlternateIconName(
        iconName: icon.id,
        blacklistBrands: ['Redmi'],
        blacklistManufactures: ['Xiaomi'],
        blacklistModels: ['Redmi 200A'],
      );
      serviceLocator<SharePrefer>().saveIconApp(icon);
      return;
    }
  } catch (e) {
    print(e.toString());
  }
}

Decoration getDecoration(ShapeType type) {
  switch (type) {
    case ShapeType.circle:
      return BoxDecoration(
        shape: BoxShape.circle,
      );
    case ShapeType.square:
      return BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.accentDark,
      );

    case ShapeType.heart:
      return ShapeDecoration(
        shape: PolygonShapeBorder(
          sides: 6,
          cornerRadius: Length(2),
        ),
      );
    case ShapeType.star:
      return ShapeDecoration(
        shape: PolygonShapeBorder(
          sides: 9,
          cornerRadius: Length(2),
        ),
      );
    case ShapeType.apple:
      return ShapeDecoration(
        shape: PolygonShapeBorder(
          sides: 4,
          cornerRadius: Length(2),
        ),
      );
    case ShapeType.triangle:
      return ShapeDecoration(
        shape: PolygonShapeBorder(
          sides: 3,
          cornerRadius: Length(2),
        ),
      );
    case ShapeType.hexagon:
      return ShapeDecoration(
        shape: PolygonShapeBorder(
          sides: 7,
          cornerRadius: Length(2),
        ),
      );
    case ShapeType.octagon:
      return ShapeDecoration(
        shape: PolygonShapeBorder(
          sides: 8,
          cornerRadius: Length(2),
        ),
      );
    case ShapeType.pentagon:
      return ShapeDecoration(
        shape: StarShapeBorder(
          corners: 5,
          cornerRadius: Length(2),
        ),
      );
    case ShapeType.tree:
      return ShapeDecoration(
        shape: StarShapeBorder(
          corners: 4,
          cornerRadius: Length(2),
        ),
      );
    case ShapeType.diamond:
      return ShapeDecoration(
        shape: StarShapeBorder(
          corners: 10,
          cornerRadius: Length(2),
        ),
      );
    case ShapeType.flower:
      return ShapeDecoration(
        shape: StarShapeBorder(
          corners: 7,
          cornerRadius: Length(2),
        ),
      );
  }
}

void launchEmail({required String email}) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    queryParameters: {'subject': 'Support', 'body': ''},
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    throw 'Không thể mở ứng dụng email';
  }
}
