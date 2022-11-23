import 'dart:convert';
import 'package:coffeeapp/model/models.dart';
import 'base_network_repsoitory.dart';
import 'package:http/http.dart' as http;

class NetworkRepository extends BaseNetworkRepository {
  Future<NetWorkModel> networkAnswer()async{
  final url = await Uri.https('coffee.alexflipnote.dev', 'random.json', {'q': '{https}'});
  final response = await http.get(url);
    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      String imageurl = result["file"].toString();
      final resultImage = await http.get(Uri.parse(imageurl));
      if (resultImage.statusCode ==200){
        return NetWorkModel(response: resultImage.statusCode, image: resultImage.bodyBytes,url: imageurl);
      }
    }
    return NetWorkModel(response: response.statusCode);
  }
}
