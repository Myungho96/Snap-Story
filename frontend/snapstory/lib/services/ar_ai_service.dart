import 'dart:convert';

import 'package:http/http.dart' as http;

class ARAIService {
  final String aiBase = 'https://j8a401.p.ssafy.io/ai';
  final String springBase = 'https://j8a401.p.ssafy.io/api/v1';
  final String apiKey = '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';
  final String apiUrl = 'https://api.openai.com/v1/completions';

  Future<String> postPictureAndGetWord({required String path}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$aiBase/predictions/objects'))
          ..files.add(await http.MultipartFile.fromPath('file', path));
    var response = await request.send();
    if (response.statusCode == 200) {
      return response.stream.bytesToString();
    } else {
      return 'CANNOT GET WORD';
    }
  }

  Future<Map<String, String>> generateText(
      {required String obj, required String token}) async {
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        "model": "text-davinci-003",
        'prompt':
            'give me one simple sentence about $obj and translation of that in korean too',
        'max_tokens': 1000,
        'temperature': 0,
        'top_p': 1,
        'frequency_penalty': 0,
        'presence_penalty': 0
      }),
    );

    Map<String, dynamic> newresponse =
        jsonDecode(utf8.decode(response.bodyBytes));
    List<String> str = newresponse['choices'][0]['text'].split('\n');
    Map<String, String> result = {
      'word': obj,
      'wordExampleKor': str[3].toString(),
      'wordExampleEng': str[2].toString()
    };
    print(result.toString());

    await http.post(
      Uri.parse('$springBase/word-list'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(result),
    );

    var res = await http.get(
      Uri.parse('$springBase/word-list/$obj'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    Map<String, dynamic> result2 = jsonDecode(utf8.decode(res.bodyBytes));
    result.addAll({'wordExplanationEng' : result2['result']['word']['wordExplanationEng'], 'wordExplanationKor' : result2['result']['word']['wordExplanationKor']});
    print(result.toString());
    return result;
  }

  Future<List> getWordList ({required String token}) async {
    var res = await http.get(
      Uri.parse('$springBase/word-list'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    Map<String, dynamic> result = jsonDecode(utf8.decode(res.bodyBytes));
    print(result['result'].toString());
    return result['result'];
  }
}
