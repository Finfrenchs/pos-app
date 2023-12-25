import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/core/constants/variables.dart';
import 'package:pos_app/data/datasources/auth_local_datasource.dart';
import 'package:pos_app/data/models/response/auth_response_model.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(
      String email, String password) async {
    final headers = {
      'Accept': 'application/json',
    };
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}api/login'),
      body: {
        'email': email,
        'password': password,
      },
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(AuthResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }

  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData.token}'
    };

    final response = await http.post(
      Uri.parse('${Variables.baseUrl}api/logout'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(response.body);
    } else {
      return left(response.body);
    }
  }
}
