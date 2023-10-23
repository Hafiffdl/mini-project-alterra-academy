// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:katalog_elektronik/models/api/news_model.dart';
import 'package:katalog_elektronik/screens/news/news_detail.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<NewsArticle> newsArticles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      final dio = Dio();
      final response = await dio.get(
        'https://newsapi.org/v2/everything?q=apple&from=2023-10-22&to=2023-10-22&sortBy=popularity&apiKey=b5bdde70ead24a68bd1cab167c261ee8',
      );

      if (response.statusCode == 200) {
        final data = response.data['articles'];
        final articles = NewsArticle.listFromJson(data);
        setState(() {
          newsArticles = articles;
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching news: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Electronic News'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : newsArticles.isEmpty
              ? const Center(
                  child: Text('No news articles available.'),
                )
              : ListView.builder(
                  itemCount: newsArticles.length,
                  itemBuilder: (context, index) {
                    final article = newsArticles[index];
                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            article.urlToImage,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          article.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(article.description),
                        onTap: () {
                          // Navigasi ke layar detail artikel dengan data artikel yang dipilih
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsArticleDetailScreen(article: article),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
