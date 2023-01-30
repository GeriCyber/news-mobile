import 'dart:convert';

NewsResponse newsResponseFromMap(String str) => NewsResponse.fromMap(json.decode(str));

String newsResponseToMap(NewsResponse data) => json.encode(data.toMap());

class NewsResponse {
    NewsResponse({
        required this.status,
        required this.totalResults,
        required this.articles,
    });

    String status;
    int totalResults;
    List<Article> articles;

    factory NewsResponse.fromMap(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toMap())),
    };
}

class Article {
    Article({
        required this.source,
        this.author,
        required this.title,
        this.description,
        required this.url,
        this.urlToImage,
        required this.publishedAt,
        this.content,
    });

    Source source;
    String? author;
    String title;
    String? description;
    String url;
    String? urlToImage;
    DateTime publishedAt;
    String? content;

    factory Article.fromMap(Map<String, dynamic> json) => Article(
        source: Source.fromMap(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
    );

    Map<String, dynamic> toMap() => {
        "source": source.toMap(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
    };
}

class Source {
    Source({
        this.id,
        required this.name,
    });

    String? id;
    String name;

    factory Source.fromMap(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
    };
}
