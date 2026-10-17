import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fa.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
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
    Locale('fa')
  ];

  ///
  ///
  /// In en, this message translates to:
  /// **'We will send you an '**
  String get login_description_1;

  ///
  ///
  /// In en, this message translates to:
  /// **'One Time Password'**
  String get login_description_2;

  ///
  ///
  /// In en, this message translates to:
  /// **' on this mobile number'**
  String get login_description_3;

  ///
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get login_next;

  ///
  ///
  /// In en, this message translates to:
  /// **'Please input correct phone number.'**
  String get login_phone_validation_error;

  ///
  ///
  /// In en, this message translates to:
  /// **'+33...'**
  String get login_phone_phone_input_placeholder;

  ///
  ///
  /// In en, this message translates to:
  /// **'Enter 6 digits verification code sent to your number'**
  String get otp_title;

  ///
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get otp_confirm;

  ///
  ///
  /// In en, this message translates to:
  /// **'Total Animals'**
  String get dashboard_total_animal;

  ///
  ///
  /// In en, this message translates to:
  /// **'Milking Cows'**
  String get dashboard_milking_cow;

  ///
  ///
  /// In en, this message translates to:
  /// **'Dry Cows'**
  String get dashboard_dry_cow;

  ///
  ///
  /// In en, this message translates to:
  /// **'Kgs Av.Milk/Cow'**
  String get dashboard_avg_milk;

  ///
  ///
  /// In en, this message translates to:
  /// **'Insemination'**
  String get dashboard_insemination;

  ///
  ///
  /// In en, this message translates to:
  /// **'Milked'**
  String get dashboard_milked;

  ///
  ///
  /// In en, this message translates to:
  /// **'Heifer'**
  String get dashboard_heifer;

  ///
  ///
  /// In en, this message translates to:
  /// **'Abortion'**
  String get dashboard_abortion;

  ///
  ///
  /// In en, this message translates to:
  /// **'Bull'**
  String get dashboard_bull;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cow'**
  String get dashboard_cow;

  ///
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get dashboard_summary;

  ///
  ///
  /// In en, this message translates to:
  /// **'State : '**
  String get filter_state;

  ///
  ///
  /// In en, this message translates to:
  /// **'Gender : '**
  String get filter_gender;

  ///
  ///
  /// In en, this message translates to:
  /// **'Confirm Filters'**
  String get filter_confirm;

  ///
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get filter_clear;

  ///
  ///
  /// In en, this message translates to:
  /// **'New Animal'**
  String get new_animal_title;

  ///
  ///
  /// In en, this message translates to:
  /// **'Edit Animal'**
  String get edit_animal_title;

  ///
  ///
  /// In en, this message translates to:
  /// **'Tag No.'**
  String get new_animal_tag_no;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get new_animal_mother;

  ///
  ///
  /// In en, this message translates to:
  /// **'Inseminator'**
  String get new_animal_inserminator;

  ///
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get new_animal_birth;

  ///
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get new_animal_gender;

  ///
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get new_animal_save;

  ///
  ///
  /// In en, this message translates to:
  /// **'No matching animal found'**
  String get list_not_found;

  ///
  ///
  /// In en, this message translates to:
  /// **'Birth'**
  String get list_birth_state;

  ///
  ///
  /// In en, this message translates to:
  /// **'Search tag number...'**
  String get list_search_tag_no;

  ///
  ///
  /// In en, this message translates to:
  /// **'Animals'**
  String get list_animals;

  ///
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get detail_alert;

  ///
  ///
  /// In en, this message translates to:
  /// **'Are you sure ?'**
  String get detail_are_you_sure_delete;

  ///
  ///
  /// In en, this message translates to:
  /// **'Birth'**
  String get detail_birth;

  ///
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get detail_gender;

  ///
  ///
  /// In en, this message translates to:
  /// **'Mother'**
  String get detail_mother;

  ///
  ///
  /// In en, this message translates to:
  /// **'Inseminator'**
  String get detail_inseminator;

  ///
  ///
  /// In en, this message translates to:
  /// **'Tag No.'**
  String get detail_tag_no;

  ///
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get detail_history;

  ///
  ///
  /// In en, this message translates to:
  /// **'Type '**
  String get state_dialog_type;

  ///
  ///
  /// In en, this message translates to:
  /// **'Date '**
  String get state_dialog_date;

  ///
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get state_dialog_description;

  ///
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get state_dialog_save;

  ///
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get state_dialog_cancel;

  ///
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get confirm_dialog_yes;

  ///
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get confirm_dialog_no;

  ///
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get setting_language;

  ///
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get setting_sign_out;

  ///
  ///
  /// In en, this message translates to:
  /// **'Choose Language'**
  String get setting_language_title;

  ///
  ///
  /// In en, this message translates to:
  /// **'Common'**
  String get setting_common_section;
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
      <String>['en', 'fa'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fa':
      return AppLocalizationsFa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
