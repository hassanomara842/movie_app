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

      if (kDebugMode) {
        print("UPDATE STATUS CODE: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("UPDATE RAW RESPONSE: ${response.body}");
      }

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

      if (kDebugMode) {
        print("REGISTER STATUS CODE: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("REGISTER RAW RESPONSE: ${response.body}");
      }

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

      if (kDebugMode) {
        print("DELETE ACCOUNT STATUS CODE: ${response.statusCode}");
      }
      if (kDebugMode) {
        print("DELETE ACCOUNT RESPONSE: ${response.body}");
      }

      if (response.statusCode != 200 && response.statusCode != 204) {
        throw Exception('Failed to delete account: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<MovieResponse> getAllMovies() async {
    Uri url =
        Uri.https(ApiConstants.movieBaseUrl, ApiEndPoints.allMovieEndPoint, {
      "sort_by:": "date_added",
      "order_by": "desc",
    });

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
      {
        'movie_id': movieId.toString(),
        'with_images': 'true',
        "with_cast": "true"
      },
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

  static Future<MovieResponse> getMovieSuggestions(int movieId) async {
    Uri url = Uri.https(
      ApiConstants.movieBaseUrl,
      ApiEndPoints.movieSuggestionsEndPoint,
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
        return MovieResponse.fromJson(json);
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

  static Future<MovieResponse> getMoviesBySearch(String q) async {
    Uri url = Uri.https(
      ApiConstants.movieBaseUrl,
      ApiEndPoints.allMovieEndPoint,
      {'query_term': q},
    );

    try {
      var response = await http.get(url);

      if (kDebugMode) {
        print("q URL: $url");
        print("STATUS CODE: ${response.statusCode}");
      }

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return MovieResponse.fromJson(json);
      } else {
        throw Exception(
            'Failed to load movies by q: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching movies by q: $e");
      }
      rethrow;
    }
  }
}
