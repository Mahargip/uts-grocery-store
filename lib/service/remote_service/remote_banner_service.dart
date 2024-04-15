import 'package:http/http.dart' as http;
import 'package:uts/core/const.dart';

class RemoteBannerService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/api/banners';

  Future<dynamic> get() async {
    var response = await client.get(
      Uri.parse('http://192.168.0.116:1337/api/banners?populate=image')
    );

    return response;
  }
}