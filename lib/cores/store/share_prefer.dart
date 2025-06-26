import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lovejourney/cores/config.dart';
import 'package:lovejourney/cores/enumlist.dart';
import 'package:lovejourney/cores/models/anniversary_model.dart';
import 'package:lovejourney/cores/models/icon_app_model.dart';
import 'package:lovejourney/cores/models/love_story_model.dart';
import 'package:lovejourney/cores/models/loveday_model.dart';
import 'package:lovejourney/cores/models/male_model.dart';
import 'package:lovejourney/cores/shared.dart';
import 'package:lovejourney/cores/ultils.dart';

class SharePrefer {
  late final SharedPreferences _sharedPreferences;
  Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveAnniversary(AnniversaryModel item) async {
    final list = await getAnniversary();
    if (list.isNotEmpty) {
      list.add(item);
      return _sharedPreferences.setString(StoreKey.anniversaryKey.name,
          jsonEncode(list.map((e) => e.toJson()).toList()));
    } else {
      List<AnniversaryModel> list = [];
      list.add(item);
      return _sharedPreferences.setString(StoreKey.anniversaryKey.name,
          jsonEncode(list.map((e) => e.toJson()).toList()));
    }
  }

  Future<bool> saveListAnniversary(List<AnniversaryModel> list) async {
    return _sharedPreferences.setString(StoreKey.anniversaryKey.name,
        jsonEncode(list.map((e) => e.toJson()).toList()));
  }

  Future<List<AnniversaryModel>> getAnniversary() async {
    final data = _sharedPreferences.getString(StoreKey.anniversaryKey.name);
    try {
      if (data != null && data.isNotEmpty) {
        return List.from(jsonDecode(data))
            .map((e) => AnniversaryModel.formJson(e))
            .toList();
      }
    } catch (e) {
      print(e);
      return [];
    }
    return [];
  }

  // User Female
  Future<MaleModel?> getFemale() async {
    final data = _sharedPreferences.getString(StoreKey.femaleKey.name);
    if (data != null && data.isNotEmpty) {
      return MaleModel.formJson(jsonDecode(data));
    }
    return null;
  }

  Future<bool> saveFemale(MaleModel femaleData) async {
    return _sharedPreferences.setString(
        StoreKey.femaleKey.name, jsonEncode(femaleData.toJson()));
  }

  Future<MaleModel?> getMale() async {
    final data = _sharedPreferences.getString(StoreKey.maleKey.name);
    if (data != null && data.isNotEmpty) {
      return MaleModel.formJson(jsonDecode(data));
    }
    return null;
  }

  Future<bool> saveMale(MaleModel femaleData) async {
    return _sharedPreferences.setString(
        StoreKey.maleKey.name, jsonEncode(femaleData.toJson()));
  }

  // Love Day
  Future<LoveDayModel> getLoveday() async {
    final data = _sharedPreferences.getString(StoreKey.lovedayKey.name);
    if (data != null && data.isNotEmpty) {
      return LoveDayModel.formJson(jsonDecode(data));
    }
    return LoveDayModel(gender: '', loveday: null);
  }

  Future<bool> saveLoveDay(LoveDayModel data) async {
    return _sharedPreferences.setString(
        StoreKey.lovedayKey.name, jsonEncode(data.toJson()));
  }

  // Images

  Future<bool> saveAlbum(String data) async {
    final list = await getListAlbum();
    if (!list.contains(data)) {
      list.add(data);
      return _sharedPreferences.setStringList(
          StoreKey.albumImageKey.name, list);
    }
    return false;
  }

  Future<List<String>> getListAlbum() async {
    final list = _sharedPreferences.getStringList(StoreKey.albumImageKey.name);
    if (list != null && list.isNotEmpty) {
      return list;
    }
    return [];
  }

  // setBackGround
  Future<bool> saveBackground(String data) async {
    return _sharedPreferences.setString(StoreKey.backgroundImageKey.name, data);
  }

  String getBackground() {
    final data = _sharedPreferences.getString(StoreKey.backgroundImageKey.name);
    return data ?? '';
  }

  // Buy Frame
  Future<bool> saveFrame(String data) async {

    return _sharedPreferences.setString(
        StoreKey.FrameKey.name, data);
  }

  String getFrame() {
    final data =
        _sharedPreferences.getString(StoreKey.FrameKey.name);
    return data ?? '';
  }

  Future<List<String>> getFurureFrame() async {
    final data =
        _sharedPreferences.getStringList(StoreKey.backgroundImageKey.name);
    return data ?? [];
  }

  //Buy Coins
  // Future<bool> saveCoins(int data) async {
  //   return _sharedPreferences.setInt(StoreKey.CoinsKey.name, data);
  // }

  // Future<int> getCoins() async {
  //   final data = _sharedPreferences.getInt(StoreKey.CoinsKey.name);
  //   return data ?? 60;
  // }

  //Set Frame

  Future<bool> saveFrameUser(String data) async {
    return _sharedPreferences.setString(StoreKey.FrameKey.name, data);
  }

  String getFrameUser() {
    final data = _sharedPreferences.getString(StoreKey.FrameKey.name);
    return data ?? '';
  }

  // set Language
  Future<bool> saveLanguage(String data) async {
    return _sharedPreferences.setString(StoreKey.languageKey.name, data);
  }

  String getLanguage() {
    final data = _sharedPreferences.getString(StoreKey.languageKey.name);
    return data ?? 'en';
  }

  // love story
  Future<bool> saveLoveStory(LoveStoryModel data) async {
    final list = await getLoveStory();
    list.add(data);
    return _sharedPreferences.setString(StoreKey.loveStoryKey.name,
        jsonEncode(list.map((e) => e.toJson()).toList()));
  }

  Future<List<LoveStoryModel>> getLoveStory() async {
    final data = _sharedPreferences.getString(StoreKey.loveStoryKey.name);
    if (data != null && data.isNotEmpty) {
      return List.from(jsonDecode(data))
          .map((e) => LoveStoryModel.fromJson(e))
          .toList();
    }
    return [];
  }

  Future<bool> saveListLoveStory(List<LoveStoryModel> data) async {
    return _sharedPreferences.setString(StoreKey.loveStoryKey.name,
        jsonEncode(data.map((e) => e.toJson()).toList()));
  }

  Future<bool> removeLoveStory(String id) async {
    final list = await getLoveStory();
    list.removeWhere((element) => element.id == id);
    return _sharedPreferences.setString(StoreKey.loveStoryKey.name,
        jsonEncode(list.map((e) => e.toJson()).toList()));
  }

  Future<bool> updateLoveStory(LoveStoryModel data) async {
    final list = await getLoveStory();
    final index = list.indexWhere((element) => element.id == data.id);
    if (index != -1) {
      list[index] = data;
      return _sharedPreferences.setString(StoreKey.loveStoryKey.name,
          jsonEncode(list.map((e) => e.toJson()).toList()));
    }
    return false;
  }

  // setMainColor
  Future<bool> saveMainColor(Color data) async {
    return _sharedPreferences.setString(
        StoreKey.mainColorKey.name, colorToHex(data));
  }

  Color getMainColor() {
    final data = _sharedPreferences.getString(StoreKey.mainColorKey.name);
    return data != null ? hexToColor(data) : Configs.listColorTheme.first;
  }

  String getMainColorString() {
    final data = _sharedPreferences.getString(StoreKey.mainColorKey.name);
    return data ?? '';
  }

  // setIconApp
  Future<bool> saveIconApp(IconAppModel data) async {
    return _sharedPreferences.setString(
        StoreKey.iconAppKey.name, jsonEncode(data.toJson()));
  }

  IconAppModel getIconApp() {
    final data = _sharedPreferences.getString(StoreKey.iconAppKey.name);
    return data != null
        ? IconAppModel.fromJson(jsonDecode(data))
        : Configs.listIcon.first;
  }

  // List icon unlock
  Future<bool> saveListIconUnlock(List<String> data) async {
    return _sharedPreferences.setStringList(
        StoreKey.listIconUnlockKey.name, data);
  }

  List<String> getListIconUnlock() {
    final data =
        _sharedPreferences.getStringList(StoreKey.listIconUnlockKey.name);
    return data ?? ['icon_default'];
  }

  // user star app

  Future<bool> saveStarApp(int star) async {
    return _sharedPreferences.setInt(StoreKey.starAppKey.name, star);
  }

  int getStarApp() {
    final data = _sharedPreferences.getInt(StoreKey.starAppKey.name);
    return data ?? 0;
  }

  // savePassLockApp
  Future<bool> savePassLockApp(String pass) async {
    return _sharedPreferences.setString(StoreKey.passLockAppKey.name, pass);
  }

  String getPassLockApp() {
    final data = _sharedPreferences.getString(StoreKey.passLockAppKey.name);
    return data ?? '';
  }

  // save Shape type
  Future<bool> saveShapeType(ShapeType data) async {
    return _sharedPreferences.setString(StoreKey.shapeAppKey.name, data.name);
  }

  ShapeType getShapeType() {
    final data = _sharedPreferences.getString(StoreKey.shapeAppKey.name);
    return data != null
        ? ShapeType.values.firstWhere((element) => element.name == data)
        : ShapeType.circle;
  }

  // getListShapePurchase
  Future<bool> saveListShapePurchase(List<String> data) async {
    return _sharedPreferences.setStringList(
        StoreKey.listShapePurchaseKey.name, data);
  }

  List<String> getListShapePurchase() {
    final data =
        _sharedPreferences.getStringList(StoreKey.listShapePurchaseKey.name);
    return data ?? [ShapeType.circle.name];
  }

  getShapeUser() {}
}
