class NewsArticle {
  final String title;
  final String description;
  final String author;
  final String url;
  final String urlToImage;
  final String publishedAt;
  
  NewsArticle({
    required this.title,
    required this.description,
    required this.author,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      author: json['author'] ?? '',
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }

  static List<NewsArticle> listFromJson(List<dynamic> json) {
    return json.map((article) => NewsArticle.fromJson(article)).toList();
  }
}