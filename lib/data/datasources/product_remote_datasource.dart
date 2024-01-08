import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/core/constants/variables.dart';
import 'package:pos_app/data/datasources/auth_local_datasource.dart';
import 'package:pos_app/data/models/request/product_request_model.dart';
import 'package:pos_app/data/models/response/product_response_model.dart';

import '../models/response/add_product_response_model.dart';

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

  Future<Either<String, AddProductResponseModel>> addProducts(
      ProductRequestModel requestModel) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final Map<String, String> headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${authData.token}'
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('${Variables.baseUrl}api/products'),
    );

    request.fields.addAll(requestModel.toMap());
    request.files.add(
        await http.MultipartFile.fromPath('image', requestModel.image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    final String body = await response.stream.bytesToString();

    if (response.statusCode == 201) {
      return right(AddProductResponseModel.fromJson(body));
    } else {
      return left(body);
    }
  }
}
