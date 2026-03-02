import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/register_model/user_data_model.dart';
import '../model/movie_response/movie_response.dart';
import '../model/movie_details_response/movie_details_response.dart';
import 'api_constants.dart';
import 'api_end_points.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {
  Future<UserDataModel> updateProfile({
    required String name,
    required String phone,
    required int avaterId,
  }) async {
    Uri url = Uri.https(ApiConstants.baseUrl, "/api/update-profile");

    try {
      var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "phone": phone,
          "avaterId": avaterId,
        }),
      );

      print("UPDATE STATUS CODE: ${response.statusCode}");
      print("UPDATE RAW RESPONSE: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = jsonDecode(response.body);
        return UserDataModel.fromJson(json);
      } else {
        throw Exception('Failed to update profile: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<UserDataModel> register(
    String name,
    String email,
    String password,
    String confirmPassword,
    String phone,
    int avaterId,
  ) async {
    Uri url = Uri.https(ApiConstants.baseUrl, "/api/register");

    try {
      var response = await http.put(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "phone": phone,
          "avaterId": avaterId,
        }),
      );

      print("REGISTER STATUS CODE: ${response.statusCode}");
      print("REGISTER RAW RESPONSE: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = jsonDecode(response.body);
        return UserDataModel.fromJson(json);
      } else {
        throw Exception('Failed to register: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAccount() async {

    Uri url = Uri.https(ApiConstants.baseUrl, "/api/delete-account");

    try {
      var response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
        },
      );

      print("DELETE ACCOUNT STATUS CODE: ${response.statusCode}");
      print("DELETE ACCOUNT RESPONSE: ${response.body}");

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete account: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<MovieResponse> getAllMovies() async {
    Uri url =
    Uri.https(ApiConstants.movieBaseUrl, ApiEndPoints.allMovieEndPoint);

    try {
      var response = await http.get(
        url,
      );

      if (kDebugMode) {
        print("STATUS CODE: ${response.statusCode}");
        print("RAW RESPONSE: ${response.body}");
      }

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return MovieResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load movies: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching movies: $e");
      }
      rethrow;
    }
  }

  static Future<MovieResponse> getAllMoviesByGenre(String genre) async {
    Uri url = Uri.https(
      ApiConstants.movieBaseUrl,
      ApiEndPoints.allMovieEndPoint,
      {'genre': genre},
    );

    try {
      var response = await http.get(url);

      if (kDebugMode) {
        print("GENRE URL: $url");
        print("STATUS CODE: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return MovieResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load movies by genre: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching movies by genre: $e");
      }
      rethrow;
    }
  }

  static Future<MovieDetailsResponse> getMovieDetails(int movieId) async {
    Uri url = Uri.https(
      ApiConstants.movieBaseUrl,
      ApiEndPoints.movieDetailsEndPoint,
      {'movie_id': movieId.toString()},
    );

    try {
      var response = await http.get(url);

      if (kDebugMode) {
        print("MOVIE DETAILS URL: $url");
        print("STATUS CODE: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return MovieDetailsResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load movie details: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching movie details: $e");
      }
      rethrow;
    }
  }
}
