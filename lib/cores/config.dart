import 'package:flutter/material.dart';
import 'package:lovejourney/cores/models/icon_app_model.dart';
import 'package:lovejourney/gen/assets.gen.dart';
import 'package:lovejourney/pages/home_page.dart';

class Configs {
  Configs._();
  static late final BuildContext mainContext;
  // static final countKey = GlobalKey<State<CountLoveView>>();
  static final keyHomePage = GlobalKey<ScaffoldState>();
  static final mainKey = GlobalKey<State<HomePage>>();

  static final commonRadius = 10.0;
  static final commonHeightButton = 42.0;
  static final commonPaddingPopup = 20.0;
  static final commonRadiusPopup = 20.0;

  static final emailContact = 'maazalim918@gmail.com';

  static final List<String> listImageBG = [
    'assets/backrounds/backround0.png',
    'assets/backrounds/backround1.png',
    'assets/backrounds/backround2.png',
    'assets/backrounds/backround3.png',
    'assets/backrounds/backround4.png',
    'assets/backrounds/backround5.png',
    'assets/backrounds/backround6.png',
    'assets/backrounds/backround7.png',
    'assets/backrounds/backround8.png',
    'assets/backrounds/backround9.png',
    'assets/backrounds/backround10.png',
  ];

  static final List<String> listFrame = [
    'assets/frames/frame1.png',
    'assets/frames/frame2.png',
    'assets/frames/frame3.png',
    'assets/frames/frame4.png',
    'assets/frames/frame5.png',
    'assets/frames/frame6.png',
    'assets/frames/frame7.png',
    'assets/frames/frame8.png'
  ];

  static final List<Color> listColorTheme = [
    Color(0xffFE97B3),
    Color(0xFFBA68C8), // Tím nhạt
    Color(0xFF64B5F6), // Xanh da trời nhạt
    Color(0xFF4DB6AC), // Xanh ngọc nhạt
    Color(0xFF81C784), // Xanh lá nhạt
    Color(0xFFFFD54F), // Vàng nhạt
    Color(0xFFFF8A65), // Cam nhạt
    Color(0xFFA1887F), // Nâu nhạt
    Color(0xFF90A4AE), // Xám xanh nhạt
    Color(0xFFF48FB1), // Hồng nhạt
    Color(0xFF9575CD), // Tím vừa
    Color(0xFF64B5F6), // Xanh nước biển
    Color(0xFF4DB6AC), // Xanh ngọc
    Color(0xFF81C784), // Xanh lá
    Color(0xFFFFD54F), // Vàng vừa
    Color(0xFFFF8A65), // Cam vừa
    Color(0xFFA1887F), // Nâu vừa
    Color(0xFF90A4AE), // Xám xanh
    Color(0xFFF06292), // Hồng vừa
    Color(0xFF7986CB), // Xanh dương vừa
    Color(0xFF4FC3F7), // Xanh biển
    Color(0xFF4DB6AC), // Xanh ngọc biển
    Color(0xFFFFA726), // Cam đậm
    Color(0xFFE57373), // Đỏ nhạt
    Color(0xFF8E24AA), // Tím đậm
    Color(0xFF1E88E5), // Xanh dương đậm
    Color(0xFF43A047), // Xanh lá đậm
    Color(0xFFFF7043), // Cam đỏ
  ];

  static final List<IconAppModel> listIcon = [
    IconAppModel(
        id: 'icon_default', path: AssetsClass.images.imageIconApp.path),
    IconAppModel(
        id: 'icon_default1', path: AssetsClass.images.imageDefault1.path),
    IconAppModel(
        id: 'icon_default2', path: AssetsClass.images.imageDefault2.path),
    IconAppModel(
        id: 'icon_default3', path: AssetsClass.images.imageDefault3.path),
    IconAppModel(
        id: 'icon_default4', path: AssetsClass.images.imageDefault4.path),
    IconAppModel(
        id: 'icon_default5', path: AssetsClass.images.imageDefault5.path),
    IconAppModel(
        id: 'icon_default6', path: AssetsClass.images.imageDefault6.path),
    IconAppModel(
        id: 'icon_default7', path: AssetsClass.images.imageDefault7.path),
    IconAppModel(
        id: 'icon_default9', path: AssetsClass.images.imageDefault9.path),
    IconAppModel(
        id: 'icon_default10', path: AssetsClass.images.imageDefault10.path),
    IconAppModel(
        id: 'icon_default11', path: AssetsClass.images.imageDefault11.path),
  ];
}
