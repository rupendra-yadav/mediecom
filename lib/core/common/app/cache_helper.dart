import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

// import '../../../features/user/data/model/user_model.dart';

class CacheHelper {
  const CacheHelper(this._prefs);

  final SharedPreferences _prefs;

  static const _isLoggedInKey = 'is_logged_in';
  static const _firstTimerKey = 'is_user_first_timer';
  static const _userIdKey = 'user_id';
  static const _userKey = 'user';

  //   //  / Reset session
  //   Future<void> resetSession() async {
  //     await _prefs.remove(_isLoggedInKey);
  //   }

  // Check if user is logged in
  bool isLoggedIn() => _prefs.getBool(_isLoggedInKey) ?? false;

  // Set the logged-in status
  Future<void> setIsLoggedIn(bool value) async {
    await _prefs.setBool(_isLoggedInKey, value);
  }

  //   // Check if user is a first-time user
  bool isFirstTime() => _prefs.getBool(_firstTimerKey) ?? true;

  // Set the first-time user status
  Future<void> setIsFirstTime(bool value) async {
    await _prefs.setBool(_firstTimerKey, value);
  }

  //   /// Cache user ID(Access token)
  //   Future<bool> cacheUserId(String userId) async {
  //     try {
  //       final result = await _prefs.setString(_userIdKey, userId);
  //       return result;
  //     } catch (_) {
  //       return false;
  //     }
  //   }

  //   /// Get user ID
  //   String? getUserId() {
  //     return _prefs.getString(_userIdKey);
  //   }

  //   ///Cache user
  //   Future<bool> cacheUser(UserModel user) async {
  //     try {
  //       final userJson = jsonEncode(user.toJson());
  //       final result = await _prefs.setString(_userKey, userJson);
  //       return result;
  //     } catch (e) {
  //       appLog('Error caching user: $e');
  //       return false;
  //     }
  //   }

  //   /// GetUserDetails
  //   UserModel? getUser() {
  //     final userJson = _prefs.getString(_userKey);

  //     if (userJson != null) {
  //       final userMap = jsonDecode(userJson);
  //       final user = UserModel.fromJson(userMap);
  //       return user;
  //     } else {
  //       appLog('getUser: User does not exist');
  //       return null;
  //     }
  //   }
  // }

  // // import 'dart:convert';
  // // import 'dart:developer';
  // //
  // // import 'package:flutter/material.dart';
  // //
  // // import 'package:shared_preferences/shared_preferences.dart';
  // //
  // // import '../../../features/profile/data/models/user_model.dart';
  // //
  // // // import '../../../features/auth/data/models/user_model.dart';
  // //
  // // class CacheHelper {
  // //   const CacheHelper(this._prefs);
  // //
  // //   final SharedPreferences _prefs;
  // //
  // //   static const _userIdKey = 'user_id';
  // //   static const _userKey = 'user';
  // //
  //   // static const _isLoggedInKey = 'is_logged_in';
  // //   static const _firstTimerKey = 'is_user_first_timer';
  // //   static const _fcmTokenKey = 'fcm-token';
  // //   static const _languageCodeKey = 'languageCode';
  // //
  // //   static const _latKey = 'lat';
  // //   static const _lngKey = 'lng';
  // //
  // //   static const _districtKey = 'district';
  // //
  // //   /// Cache user ID
  // //   Future<bool> cacheUserId(String userId) async {
  // //     try {
  // //       final result = await _prefs.setString(_userIdKey, userId);
  // //       return result;
  // //     } catch (_) {
  // //       return false;
  // //     }
  // //   }
  // //
  // //   ///Cache user
  // //   Future<bool> cacheUser(UserModel user) async {
  // //     try {
  // //       final userJson = jsonEncode(user.toJson());
  // //       final result = await _prefs.setString(_userKey, userJson);
  // //       return result;
  // //     } catch (e) {
  // //       appLog('Error caching user: $e');
  // //       return false;
  // //     }
  // //   }
  // //
  // //   ///Cache District
  // //   // Future<bool> cacheDistrict(DistrictModel district) async {
  // //   //   try {
  // //   //     final districtJson = jsonEncode(district.toJson());
  // //   //     final result = await _prefs.setString(_districtKey, districtJson);
  // //   //     return result;
  // //   //   } catch (e) {
  // //   //     appLog('Error caching user: $e');
  // //   //     return false;
  // //   //   }
  // //   // }
  // //
  // //   /// Cache fcm token
  // //   Future<bool> cacheFcmToken(String token) async {
  // //     try {
  // //       final result = await _prefs.setString(_fcmTokenKey, token);
  // //       return result;
  // //     } catch (_) {
  // //       return false;
  // //     }
  // //   }
  // //
  // //   /// Cache language code
  // //   Future<bool> cacheLanguageCode(String languageCode) async {
  // //     try {
  // //       final result = await _prefs.setString(_languageCodeKey, languageCode);
  // //       return result;
  // //     } catch (_) {
  // //       return false;
  // //     }
  // //   }
  // //
  // //   /// Cache user lat
  // //   Future<bool> cacheLat(double lat) async {
  // //     try {
  // //       final result = await _prefs.setDouble(_latKey, lat);
  // //       return result;
  // //     } catch (_) {
  // //       return false;
  // //     }
  // //   }
  // //
  // //   /// Cache user lng
  // //   Future<bool> cacheLng(double lng) async {
  // //     try {
  // //       final result = await _prefs.setDouble(_lngKey, lng);
  // //       return result;
  // //     } catch (_) {
  // //       return false;
  // //     }
  // //   }
  // //
  // //   /// Get user ID
  // //   String? getUserId() {
  // //     return _prefs.getString(_userIdKey);
  // //   }
  // //
  // //   /// Get District data
  // //   // DistrictModel? getDistrict() {
  // //   //   final districtJson = _prefs.getString(_districtKey);
  // //   //
  // //   //   if (districtJson != null) {
  // //   //     final districtMap = jsonDecode(districtJson);
  // //   //     final district = DistrictModel.fromJson(districtMap);
  // //   //     return district;
  // //   //   } else {
  // //   //     appLog('getDistrict: District does not exist');
  // //   //     return null;
  // //   //   }
  // //   // }
  // //
  // //   /// Get user data
  // //   UserModel? getUser() {
  // //     final userJson = _prefs.getString(_userKey);
  // //
  // //     if (userJson != null) {
  // //       final userMap = jsonDecode(userJson);
  // //       final user = UserModel.fromJson(userMap);
  // //       return user;
  // //     } else {
  // //       appLog('getUser: User does not exist');
  // //       return null;
  // //     }
  // //   }
  // //
  // //   /// Get fcm token
  // //   String? getFcmToken() {
  // //     return _prefs.getString(_fcmTokenKey);
  // //   }
  // //
  // //   /// Get language code
  // //   String getLanguageCode() {
  // //     return _prefs.getString(_languageCodeKey) ??
  // //         'en'; // Defaulting to English if not found
  // //   }
  // //
  // //   /// Get user lat
  // //   double? getLatLng() {
  // //     return _prefs.getDouble(_latKey);
  // //   }
  // //
  // //   /// Get user lng
  // //   double? getLng() {
  // //     return _prefs.getDouble(_lngKey);
  // //   }
  // //
  // //   /// Reset session
  // //   Future<void> resetSession() async {
  // //     await _prefs.remove(_isLoggedInKey);
  // //     await _prefs.remove(_userIdKey);
  // //     await _prefs.remove(_userKey);
  // //     await _prefs.remove(_fcmTokenKey);
  // //     await _prefs.remove(_languageCodeKey); // Removing language code too
  // //   }
  // //
  // //   // Check if user is logged in
  // //   bool isLoggedIn() => _prefs.getBool(_isLoggedInKey) ?? false;
  // //
  // //   // Set the logged-in status
  // //   Future<void> setIsLoggedIn(bool value) async {
  // //     await _prefs.setBool(_isLoggedInKey, value);
  // //   }
  // //
  // //   // Check if user is a first-time user
  // //   bool isFirstTime() => _prefs.getBool(_firstTimerKey) ?? true;
  // //
  // //   // Set the first-time user status
  // //   Future<void> setIsFirstTime(bool value) async {
  // //     await _prefs.setBool(_firstTimerKey, value);
  // //   }
  // //
  // //   // Set Locale
  // //   // Future<Locale> setLocale(String languageCode) async {
  // //   //   await cacheLanguageCode(languageCode); // Cache the language code
  // //   //   return _locale(languageCode);
  // //   // }
  // //
  // //   // Get Locale
  // //   Future<Locale> getLocale() async {
  // //     String languageCode = getLanguageCode(); // Get the language code from cache
  // //     return _locale(languageCode);
  // //   }
  // //
  // //   Locale _locale(String languageCode) {
  // //     switch (languageCode) {
  // //       case 'en':
  // //         return Locale('en', 'US');
  // //       case 'hi':
  // //         return Locale('hi', 'IN');
  // //       default:
  // //         return Locale('en', 'US');
  // //     }
  // //   }
}
