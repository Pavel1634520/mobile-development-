import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<List<News>> fetchNews(http.Client client) async {
  final response = await client.get(Uri.parse(
      'https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90'));
  return compute(parseNews, response.body);
}

List<News> parseNews(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<News>((json) => News.fromJson(json)).toList();
}

class News {
  final String ID;
  final String ACTIVE_FROM;
  final String TITLE;
  final String PREVIEW_TEXT;
  final String PREVIEW_PICTURE_SRC;
  final String DETAIL_TEXT;
  final String LAST_MODIFIED;
  final String DETAIL_PAGE_URL;

  const News(
      {required this.ACTIVE_FROM,
      required this.DETAIL_TEXT,
      required this.ID,
      required this.LAST_MODIFIED,
      required this.PREVIEW_PICTURE_SRC,
      required this.PREVIEW_TEXT,
      required this.TITLE,
      required this.DETAIL_PAGE_URL});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      ACTIVE_FROM: json['ACTIVE_FROM'] as String,
      DETAIL_TEXT: json['DETAIL_TEXT'] as String,
      ID: json['ID'] as String,
      LAST_MODIFIED: json['LAST_MODIFIED'] as String,
      PREVIEW_PICTURE_SRC: json['PREVIEW_PICTURE_SRC'] as String,
      PREVIEW_TEXT: json['PREVIEW_TEXT'] as String,
      TITLE: json['TITLE'] as String,
      DETAIL_PAGE_URL: json['DETAIL_PAGE_URL'] as String,
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Лента новойтей КубГАУ';
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: FutureBuilder<List<News>>(
        future: fetchNews(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Ошибка запроса!'),
            );
          } else if (snapshot.hasData) {
            return NewsList(news: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.news}) : super(key: key);
  final List<News> news;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) => Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  Image.network(news[index].PREVIEW_PICTURE_SRC),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    news[index].ACTIVE_FROM,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    news[index].TITLE,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    news[index].PREVIEW_TEXT,
                  ),
                ]),
              ),
            ));
  }
}
