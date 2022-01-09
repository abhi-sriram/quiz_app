
import 'package:http/http.dart' as http;
import "dart:convert";

class Centers {



  Future<Map<String, dynamic>> fetchData() async {
    var headers = {'Content-Type': 'application/json'};
     var request = http.Request('GET', Uri.parse('https://isro.vercel.app/api/centres'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      final data = await response.stream.bytesToString();

      return {
        "responseCode": 200,
        "data": json.decode(data),
        "message": response.reasonPhrase,
      };
    } else {
      return {
        "responseCode": 400,
        "data": {},
        "message": response.reasonPhrase,
      };
    }
  }
}
