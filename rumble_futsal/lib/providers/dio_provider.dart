import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioProvider {
  //get token
  Future<dynamic> getToken(String email, String password) async {
    try {
      var response = await Dio().post('http://127.0.0.1:8000/api/login',
          data: {'email': email, 'password': password});

      if (response.statusCode == 200 && response.data != '') {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

  //get user data
  Future<dynamic> getUser(String token) async {
    try {
      var user = await Dio().get('http://127.0.0.1:8000/api/user',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (user.statusCode == 200 && user.data != '') {
        return json.encode(user.data);
      }
    } catch (error) {
      return error;
    }
  }

//register new user
  Future<dynamic> registerUser(
      String username, String email, String password) async {
    try {
      var user = await Dio().post('http://127.0.0.1:8000/api/register',
          data: {'name': username, 'email': email, 'password': password});
      if (user.statusCode == 201 && user.data != '') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return error;
    }
  }

//store booking details
  Future<dynamic> bookGround(
      String date, String day, String time, int ground, String token) async {
    try {
      var response = await Dio().post('http://127.0.0.1:8000/api/book',
          data: {'date': date, 'day': day, 'time': time, 'ground_id': ground},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  //get user data
  Future<dynamic> getBook(String token) async {
    try {
      var response = await Dio().get('http://127.0.0.1:8000/api/getbook',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200 && response.data != '') {
        return json.encode(response.data);
      }
    } catch (error) {
      return error;
    }
  }

  Future<dynamic> cancelBooking(int id, int ground, String token) async {
    try {
      var response = await Dio().post('http://127.0.0.1:8000/api/cancel',
          data: {'booking_id': id, 'ground_id': ground},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  //store rating details
  Future<dynamic> storeReviews(
      String reviews, double ratings, int id, int ground, String token) async {
    try {
      var response = await Dio().post('http://127.0.0.1:8000/api/reviews',
          data: {
            'ratings': ratings,
            'reviews': reviews,
            'booking_id': id,
            'ground_id': ground
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  //store fav ground
  Future<dynamic> storeFavGround(String token, List<dynamic> favList) async {
    try {
      var response = await Dio().post('http://127.0.0.1:8000/api/fav',
          data: {
            'favList': favList,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  //update user details
  Future<dynamic> updateUser(
      String token, String phone, String address, String position) async {
    try {
      var response = await Dio().post('http://127.0.0.1:8000/api/update',
          data: {
            'phone': phone,
            'address': address,
            'position': position,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
       
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  //update the photo
  Future<dynamic> updatePhoto(
      String token, String photo) async {
    try {
      var response = await Dio().post('http://127.0.0.1:8000/api/photo',
          data: {
            'profile_photo_path': photo,
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
         final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('photoPath', response.data);
        return response.statusCode;
      } else {
       
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }

  //get user reviews
  Future<dynamic> getReview(String token) async {
    try {
      var response = await Dio().get('http://127.0.0.1:8000/api/ratings',
          options: Options(headers: {'Authorization': 'Bearer $token'}));
      if (response.statusCode == 200 && response.data != '') {
        return json.encode(response.data);
      }
    } catch (error) {
      return error;
    }
  }

  



//logout
  Future<dynamic> logout(String token) async {
    try {
      var response = await Dio().post('http://127.0.0.1:8000/api/logout',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 && response.data != '') {
        return response.statusCode;
      } else {
        return 'Error';
      }
    } catch (error) {
      return error;
    }
  }
}
