import 'dart:convert';
import 'package:http/http.dart' as http;
import 'ProductFetchingJsondart.dart';

Future<List<ProductFetching>> fetchProductFetching() async {
  final response = await http.get(Uri.parse('https://fakestoreapi.com/products/'));

  if (response.statusCode == 200) {
    List<dynamic> jsonResponse = json.decode(response.body);
    return jsonResponse.map((product) => ProductFetching.fromJson(product)).toList();
  } else {
    throw Exception('Failed to load products');
  }
}