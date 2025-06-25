import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_id.dart';
import 'app_localizations_vi.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('id'),
    Locale('vi'),
    Locale('zh')
  ];

  /// No description provided for @preferredLanguage.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get preferredLanguage;

  /// No description provided for @celebratingEverylovemilestone.
  ///
  /// In en, this message translates to:
  /// **'The box contains beautiful memories of the couple'**
  String get celebratingEverylovemilestone;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get choose;

  /// No description provided for @setTheAnniversarystartdate.
  ///
  /// In en, this message translates to:
  /// **'The day you started dating'**
  String get setTheAnniversarystartdate;

  /// No description provided for @setUpphotos.
  ///
  /// In en, this message translates to:
  /// **' Set up photos'**
  String get setUpphotos;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @inlove.
  ///
  /// In en, this message translates to:
  /// **'In love'**
  String get inlove;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @theAnniversarystartdate.
  ///
  /// In en, this message translates to:
  /// **'The anniversary start date'**
  String get theAnniversarystartdate;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get years;

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get months;

  /// No description provided for @weeks.
  ///
  /// In en, this message translates to:
  /// **'Weeks'**
  String get weeks;

  /// No description provided for @changeAvatar.
  ///
  /// In en, this message translates to:
  /// **'Change Avatar'**
  String get changeAvatar;

  /// No description provided for @changeUsername.
  ///
  /// In en, this message translates to:
  /// **'Change Username'**
  String get changeUsername;

  /// No description provided for @changeDOB.
  ///
  /// In en, this message translates to:
  /// **'Change DOB'**
  String get changeDOB;

  /// No description provided for @deleteAvatar.
  ///
  /// In en, this message translates to:
  /// **'Delete Avatar'**
  String get deleteAvatar;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @loveStory.
  ///
  /// In en, this message translates to:
  /// **'Love Story'**
  String get loveStory;

  /// No description provided for @youTwodonthavealovestory.
  ///
  /// In en, this message translates to:
  /// **'You two don\'t have a love story!'**
  String get youTwodonthavealovestory;

  /// No description provided for @addNewlovestory.
  ///
  /// In en, this message translates to:
  /// **'Add new love story'**
  String get addNewlovestory;

  /// No description provided for @enterThecontentofyourstory.
  ///
  /// In en, this message translates to:
  /// **'Enter the content of your story'**
  String get enterThecontentofyourstory;

  /// No description provided for @pickaDate.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get pickaDate;

  /// No description provided for @detailStory.
  ///
  /// In en, this message translates to:
  /// **'Detail Story'**
  String get detailStory;

  /// No description provided for @editStory.
  ///
  /// In en, this message translates to:
  /// **'Edit Story'**
  String get editStory;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @deleteStory.
  ///
  /// In en, this message translates to:
  /// **'Delete Story?'**
  String get deleteStory;

  /// No description provided for @areYousureyouwanttodeletestory.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete story?'**
  String get areYousureyouwanttodeletestory;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @versionPremium.
  ///
  /// In en, this message translates to:
  /// **'Version Premium'**
  String get versionPremium;

  /// No description provided for @removeAdsandunlockfeatures.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads and unlock features'**
  String get removeAdsandunlockfeatures;

  /// No description provided for @changeWallpaper.
  ///
  /// In en, this message translates to:
  /// **'Change Wallpaper'**
  String get changeWallpaper;

  /// No description provided for @changeTheme.
  ///
  /// In en, this message translates to:
  /// **'Change Theme'**
  String get changeTheme;

  /// No description provided for @changeIconApp.
  ///
  /// In en, this message translates to:
  /// **'Change Icon App'**
  String get changeIconApp;

  /// No description provided for @usePasswordLock.
  ///
  /// In en, this message translates to:
  /// **'Use Password Lock'**
  String get usePasswordLock;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @shareWithApp.
  ///
  /// In en, this message translates to:
  /// **'Share With App'**
  String get shareWithApp;

  /// No description provided for @reviewApp.
  ///
  /// In en, this message translates to:
  /// **'Review App'**
  String get reviewApp;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms Of Service'**
  String get termsOfService;

  /// No description provided for @contactUs.
  ///
  /// In en, this message translates to:
  /// **'Contact Us'**
  String get contactUs;

  /// No description provided for @versionApp.
  ///
  /// In en, this message translates to:
  /// **'Version App'**
  String get versionApp;

  /// No description provided for @change.
  ///
  /// In en, this message translates to:
  /// **'Change'**
  String get change;

  /// No description provided for @unlock.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get unlock;

  /// No description provided for @doYouwanttounlock.
  ///
  /// In en, this message translates to:
  /// **'Do you want to unlock'**
  String get doYouwanttounlock;

  /// No description provided for @withx.
  ///
  /// In en, this message translates to:
  /// **'With'**
  String get withx;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @yourCoinsarenotenoughtounlockpleasegotothestoretobuymorecoins.
  ///
  /// In en, this message translates to:
  /// **'Your coins are not enough to unlock. Please go to the store to buy more coins. '**
  String get yourCoinsarenotenoughtounlockpleasegotothestoretobuymorecoins;

  /// No description provided for @gotoShoping.
  ///
  /// In en, this message translates to:
  /// **'Go to shopping'**
  String get gotoShoping;

  /// No description provided for @functionunderdevelopment.
  ///
  /// In en, this message translates to:
  /// **'Function under development'**
  String get functionunderdevelopment;

  /// No description provided for @shopstar.
  ///
  /// In en, this message translates to:
  /// **'Diamonds Store'**
  String get shopstar;

  /// No description provided for @removeAds.
  ///
  /// In en, this message translates to:
  /// **'Remove Ads'**
  String get removeAds;

  /// No description provided for @unlockAlltools.
  ///
  /// In en, this message translates to:
  /// **'Unlock all tools'**
  String get unlockAlltools;

  /// No description provided for @chooseYoursubscription.
  ///
  /// In en, this message translates to:
  /// **'Choose Your subscription'**
  String get chooseYoursubscription;

  /// No description provided for @goSubscription.
  ///
  /// In en, this message translates to:
  /// **'Go Subscription'**
  String get goSubscription;

  /// No description provided for @recurringPaymentscancelanytime.
  ///
  /// In en, this message translates to:
  /// **'Recurring payments, cancel anytime'**
  String get recurringPaymentscancelanytime;

  /// No description provided for @recurringPaymentscancelanytimeSub.
  ///
  /// In en, this message translates to:
  /// **'If the trial period ends, you will be automatically charged for your subscription according to the terms and price at which you previously selected the plan. Your subscription will automatically renew unless you cancel it at least 24 hours before the expiration date. You can cancel at any time in Google Play.'**
  String get recurringPaymentscancelanytimeSub;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @terms.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get terms;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @upgradePremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade Premium'**
  String get upgradePremium;

  /// No description provided for @enterApasscodeof4digits.
  ///
  /// In en, this message translates to:
  /// **'Enter a passcode of 4 digits'**
  String get enterApasscodeof4digits;

  /// No description provided for @reEnternewpasscode.
  ///
  /// In en, this message translates to:
  /// **'Re-enter new passcode'**
  String get reEnternewpasscode;

  /// No description provided for @passcodeDoesnotmatch.
  ///
  /// In en, this message translates to:
  /// **'Passcode does not match'**
  String get passcodeDoesnotmatch;

  /// No description provided for @changeShapeAvatar.
  ///
  /// In en, this message translates to:
  /// **'Change Shape Avatar'**
  String get changeShapeAvatar;

  /// No description provided for @newVersionAvailable.
  ///
  /// In en, this message translates to:
  /// **'New Version Available'**
  String get newVersionAvailable;

  /// No description provided for @updateNewVersion.
  ///
  /// In en, this message translates to:
  /// **'Update New Version'**
  String get updateNewVersion;

  /// No description provided for @remindMeLater.
  ///
  /// In en, this message translates to:
  /// **'Remind Me Later'**
  String get remindMeLater;

  /// No description provided for @theAppisundermaintenance.
  ///
  /// In en, this message translates to:
  /// **'The app is under maintenance'**
  String get theAppisundermaintenance;

  /// No description provided for @weAreupgradingtoserveyoubetterPleasecomebacklater.
  ///
  /// In en, this message translates to:
  /// **'We are upgrading to serve you better. Please come back later.'**
  String get weAreupgradingtoserveyoubetterPleasecomebacklater;

  /// No description provided for @closeApp.
  ///
  /// In en, this message translates to:
  /// **'Close App'**
  String get closeApp;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @termsofConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms of Conditions'**
  String get termsofConditions;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @yourGender.
  ///
  /// In en, this message translates to:
  /// **'Your gender'**
  String get yourGender;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @startDating.
  ///
  /// In en, this message translates to:
  /// **'Start Dating'**
  String get startDating;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// No description provided for @frame.
  ///
  /// In en, this message translates to:
  /// **'Frame'**
  String get frame;

  /// No description provided for @background.
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get background;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @enterUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter Username'**
  String get enterUsername;

  /// No description provided for @birthday.
  ///
  /// In en, this message translates to:
  /// **'Birthday'**
  String get birthday;

  /// No description provided for @memoriesMoment.
  ///
  /// In en, this message translates to:
  /// **'Memories Moment'**
  String get memoriesMoment;

  /// No description provided for @newMemory.
  ///
  /// In en, this message translates to:
  /// **'New Memory'**
  String get newMemory;

  /// No description provided for @youDonthaveanymemoriesyet.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any memories yet!'**
  String get youDonthaveanymemoriesyet;

  /// No description provided for @photoBackground.
  ///
  /// In en, this message translates to:
  /// **'Photo Background'**
  String get photoBackground;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @memoryName.
  ///
  /// In en, this message translates to:
  /// **'Memory Name'**
  String get memoryName;

  /// No description provided for @enterName.
  ///
  /// In en, this message translates to:
  /// **'Enter Name'**
  String get enterName;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @memoryDay.
  ///
  /// In en, this message translates to:
  /// **'Memory Day'**
  String get memoryDay;

  /// No description provided for @editMemory.
  ///
  /// In en, this message translates to:
  /// **'Edit Memory'**
  String get editMemory;

  /// No description provided for @infomationMemory.
  ///
  /// In en, this message translates to:
  /// **'Information Memory'**
  String get infomationMemory;

  /// No description provided for @doYouWantToDeleteThisMemory.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete this memory?'**
  String get doYouWantToDeleteThisMemory;

  /// No description provided for @daysLeft.
  ///
  /// In en, this message translates to:
  /// **'days left'**
  String get daysLeft;

  /// No description provided for @dayLeft.
  ///
  /// In en, this message translates to:
  /// **'day left'**
  String get dayLeft;

  /// No description provided for @beingTogether.
  ///
  /// In en, this message translates to:
  /// **'Being Together'**
  String get beingTogether;

  /// No description provided for @theDayWeStartedLovingEachOther.
  ///
  /// In en, this message translates to:
  /// **'The day we started loving each other'**
  String get theDayWeStartedLovingEachOther;

  /// No description provided for @reviewUs.
  ///
  /// In en, this message translates to:
  /// **'Review Us'**
  String get reviewUs;

  /// No description provided for @doYouLoveOurApp.
  ///
  /// In en, this message translates to:
  /// **'Do you love our app?'**
  String get doYouLoveOurApp;

  /// No description provided for @sendSummit.
  ///
  /// In en, this message translates to:
  /// **'Send Submit'**
  String get sendSummit;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'id', 'vi', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'id':
      return AppLocalizationsId();
    case 'vi':
      return AppLocalizationsVi();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
