import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/register_model/user_data_model.dart';
import 'api_constants.dart';
import 'api_end_points.dart';
import 'package:injectable/injectable.dart';

@singleton
class ApiManager {
  Future<UserDataModel> register(
      String name,
      String email,
      String password,
      String confirmPassword,
      String phone,
      int avaterId,
      ) async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiEndPoints.registerEndPoint);

    try {
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "name": name,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "phone": phone,
          "avaterId": avaterId,
        }),
      );

      print("STATUS CODE: ${response.statusCode}");
      print("RAW RESPONSE: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        var json = jsonDecode(response.body);
        return UserDataModel.fromJson(json);
      } else {
        throw Exception('Failed to register user: ${response.body}');
      }
    } catch (e) {
      rethrow;
    }
  }
}