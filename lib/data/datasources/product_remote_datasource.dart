import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/core/constants/variables.dart';
import 'package:pos_app/data/datasources/auth_local_datasource.dart';
import 'package:pos_app/data/models/response/product_response_model.dart';

class ProductRemoteDatasource {
  Future<Either<String, ProductResponseModel>> getProducts() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData.token}'
    };
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}api/products'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return right(ProductResponseModel.fromJson(response.body));
    } else {
      return left(response.body);
    }
  }
}
