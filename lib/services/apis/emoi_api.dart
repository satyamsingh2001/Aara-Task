import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../screen/models/emoji_model.dart';

Future<List<SimpleEmoji>> fetchEmojiList() async {
  final response = await http.get(Uri.parse(

      'https://emoji-api.com/emojis?access_key=5a77e9b0b489eb91cbfc2cc807ffec18911fee61'
  ));

  if (response.statusCode == 200) {
    final List<dynamic> responseData = json.decode(response.body);
    return responseData.map((json) => SimpleEmoji.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load emoji data');
  }
}