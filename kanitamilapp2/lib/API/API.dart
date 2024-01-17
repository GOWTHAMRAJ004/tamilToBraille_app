import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> convertTamilToBraille(String tamilText) async {
  String apiUrl = 'http://10.0.2.2:5000/tamil-to-braille';

  try {
    http.Response response = await http.get(Uri.parse('$apiUrl?text=$tamilText'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return {'success': true, 'result': jsonResponse['braille']};
    } else {
      return {'success': false, 'error': 'Request failed with status: ${response.statusCode}'};
    }
  } catch (error) {
    return {'success': false, 'error': 'Error: $error'};
  }
}
Future<Map<String, dynamic>> convertBrailleToTamil(String brailleText) async {
  String apiUrl = 'http://10.0.2.2:5000/braille-to-tamil';

  try {
    http.Response response = await http.get(Uri.parse('$apiUrl?text=$brailleText'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return {'success': true, 'result': jsonResponse['tamil']};
    } else {
      return {'success': false, 'error': 'Request failed with status: ${response.statusCode}'};
    }
  } catch (error) {
    return {'success': false, 'error': 'Error: $error'};
  }
}
