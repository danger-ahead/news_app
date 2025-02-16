import 'package:hive_flutter/hive_flutter.dart';

part 'news_model.g.dart';

@HiveType(typeId: 1)
class NewsTopic {
  @HiveField(0)
  final int totalResults;
  @HiveField(1)
  final List<Article> articles;

  NewsTopic({
    required this.totalResults,
    required this.articles,
  });

  factory NewsTopic.fromJson(Map<String, dynamic> json) => NewsTopic(
        totalResults: json["totalResults"],
        articles: List<Article>.from(
            json["articles"].map((x) => Article.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 2)
class Article {
  @HiveField(0)
  Source source;
  @HiveField(1)
  String? author;
  @HiveField(2)
  String title;
  @HiveField(3)
  String description;
  @HiveField(4)
  String url;
  @HiveField(5)
  String? urlToImage;
  @HiveField(6)
  DateTime publishedAt;
  @HiveField(7)
  String content;

  Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

@HiveType(typeId: 3)
class Source {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
