import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel extends ChangeNotifier {
  SharedPreferences? _prefs;

  AuthModel() {
    initializePreferences();
  }

  bool _isLogin = false;
  Map<String, dynamic> user = {};
  //to update user details when logged in
  Map<String, dynamic> userDetails = {};
  Map<String, dynamic> booking =
      {}; // to update upcoming booking when logged in
  List<Map<String, dynamic>> favGround = []; //get lastest fav ground
  List<dynamic> _fav = []; //get all fav ground id in lost

  String? _photo;

  bool get isLogin {
    return _isLogin;
  }

  List<dynamic> get getFav {
    return _fav;
  }

  Map<String, dynamic> get getDetails {
    return userDetails;
  }

  Map<String, dynamic> get getUser {
    return user;
  }

  Future<void> initializePreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _isLogin = _prefs!.getBool('isLoggedIn') ?? false;
    if (_isLogin) {
      // Retrieve user data from SharedPreferences and update the state
      String? userDataJson = _prefs!.getString('userData');
      if (userDataJson != null) {
        user = json.decode(userDataJson);

        
      }

      String? bookingInfoJson = _prefs!.getString('bookingInfo');
      if (bookingInfoJson != null) {
        booking = json.decode(bookingInfoJson);
      }

      String? favListJson = _prefs!.getString('favList');
      if (favListJson != null) {
        _fav = json.decode(favListJson);
      }
      String? address = _prefs!.getString('address');
      if (address != null) {
        user['address'] = address;
      }

      String? phone = _prefs!.getString('phone');
      if (phone != null) {
        user['phone'] = phone;
      }

      String? position = _prefs!.getString('position');
      if (position != null) {
        user['position'] = position;
      }

      String? photo = _prefs!.getString('profile_photo_path');
      if (photo != null) {
        user['profile_photo_path'] = photo;
      }
    }
    notifyListeners();
  }

  Future<void> updateLoginStatus(bool isLoggedIn) async {
    _isLogin = isLoggedIn;
    await _prefs!.setBool('isLoggedIn', isLoggedIn);
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    user['address'] = newAddress;
    _prefs!.setString('address', newAddress);
    notifyListeners();
  }

  void updatePhone(String newPhone) {
    user['phone'] = newPhone;
    _prefs!.setString('phone', newPhone);
    notifyListeners();
  }

  void updatePosition(String newPosition) {
    user['position'] = newPosition;
    _prefs!.setString('position', newPosition);
    notifyListeners();
  }

  void updatePhoto(String newPhoto) {
    user['profile_photo_path'] = newPhoto;
    _prefs!.setString('profile_photo_path', newPhoto);
    notifyListeners();
  }

  Map<String, dynamic> get getBooking {
    return booking;
  }

//update latest fav list
  void setFavList(List<dynamic> list) {
    _fav = list;
    notifyListeners();
  }

//return latest favourite ground
  List<Map<String, dynamic>> get getFavGround {
    favGround.clear();

    //list out ground list according to favourite list
    for (var num in _fav) {
      for (var ground in user['ground']) {
        if (num == ground['ground_id']) {
          favGround.add(ground);
        }
      }
    }
    return favGround;
  }

  void loginSuccess(
    Map<String, dynamic> userData,
    Map<String, dynamic> bookingInfo,
  ) async {
    _isLogin = true;

    // To update all these data when logged in
    user = userData;
    booking = bookingInfo;

    if (user['details']['fav'] != null) {
      _fav = await json.decode(user['details']['fav']);
    }

    await _prefs!.setBool('isLoggedIn', true);
    await _prefs!.setString('userData', json.encode(user));
    await _prefs!.setString('bookingInfo', json.encode(booking));
    await _prefs!.setString('favList', json.encode(_fav));
    // Notify listeners and stop displaying the progress indicator
    notifyListeners();
  }
}
