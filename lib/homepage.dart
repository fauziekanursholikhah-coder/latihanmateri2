import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'detail_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _get = [];

  final String apiKey = '9f79a29b76064bd6ba8f71ac1a6c99a4';

  @override
  void initState() {
    super.initState();
    _getData();
  }

  Future<void> _getData() async {
    try {
      final response = await http.get(
        Uri.parse(
          'https://newsapi.org/v2/everything'
          '?domains=techcrunch.com,thenextweb.com'
          '&apiKey=$apiKey',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _get = data['articles'] ?? [];
        });
      }
    } catch (e) {
      // tampilkan eror di terminal
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Center(
            child: Text(
              'News Apps with API',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ),
        body: _get.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _get.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListTile(
                      leading: Image.network(
                        _get[index]['urlToImage'] ??
                            'https://cdn.pixabay.com/photo/2023/10/12/14/41/town-8310950_960_720.jpg',
                        fit: BoxFit.cover,
                        width: 100,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://cdn.pixabay.com/photo/2023/10/12/14/41/town-8310950_960_720.jpg',
                            fit: BoxFit.cover,
                            width: 100,
                          );
                        },
                      ),

                      title: Text(
                        _get[index]['title'] ?? 'Tidak ada judul',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      subtitle: Text(
                        _get[index]['description'] ??
                            'Tidak ada deskripsi',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              url: _get[index]['url'],
                              title: _get[index]['title'],
                              content: _get[index]['content'],
                              urlToImage: _get[index]['urlToImage'],
                              author: _get[index]['author'],
                              publishedAt: _get[index]['publishedAt'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}