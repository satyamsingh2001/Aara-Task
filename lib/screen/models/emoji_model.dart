class EmojiModel {
  final String slug;
  final String character;

  EmojiModel({
    required this.slug,
    required this.character,
  });

  factory EmojiModel.fromJson(Map<String, dynamic> json) {
    return EmojiModel(
      slug: json['slug'],
      character: json['character'],
    );
  }
}


  List<Map<String, dynamic>> jsonDataList = [
    {
      "slug": "e1-0-grinning-face",
      "character": "😀",
    },
    {
      "slug": "e0-6-grinning-face-with-big-eyes",
      "character": "😃",
    },
    {
      "slug": "e0-6-grinning-face-with-smiling-eyes",
      "character": "😄",
    },
    {
      "slug": "e0-6-beaming-face-with-smiling-eyes",
      "character": "😁",
    },
    {
      "slug": "e0-6-grinning-squinting-face",
      "character": "😆",
    },
    {
      "slug": "e0-6-grinning-face-with-sweat",
      "character": "😅",
    },
  ];

  List<EmojiModel> emojiList = jsonDataList
      .map((jsonData) => EmojiModel.fromJson(jsonData))
      .toList();



class SimpleEmoji {
  String character;

  SimpleEmoji({
    required this.character,
  });

  factory SimpleEmoji.fromJson(Map<String, dynamic> json) {
    return SimpleEmoji(
      character: json["character"],
    );
  }}
