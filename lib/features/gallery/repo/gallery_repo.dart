import 'dart:convert';
import 'package:cubit_practice/features/gallery/data/model/gallery_model.dart';
import 'package:http/http.dart' as http;

class GalleryRepo {
  Future<List<PhotoModel>> fetchPhotos() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/photos');
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch photos');
    }

    final List<dynamic> photosJson = json.decode(response.body);
    return photosJson.map((json) => PhotoModel.fromJson(json)).toList();
  }
}
