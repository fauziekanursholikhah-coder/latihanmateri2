import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    this.url,
    this.title,
    this.content,
    this.publishedAt,
    this.author,
    this.urlToImage,
  });

  final url;
  final title;
  final content;
  final publishedAt;
  final author;
  final urlToImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Center(
          child: Text(
            'Detail News',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),

      body: Column(
        children: <Widget>[
          urlToImage != null
              ? Image.network(
                  urlToImage,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      margin: const EdgeInsets.all(20),
                      height: 250,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.grey,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.image_not_supported,
                          size: 50,
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  margin: const EdgeInsets.all(20),
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      size: 50,
                    ),
                  ),
                ),

          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title ?? 'Tidak ada judul',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  publishedAt ?? 'Tidak ada tanggal',
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  content ?? 'Tidak ada isi berita',
                ),

                const Divider(),

                Text(
                  author ?? 'Tidak ada author',
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  url ?? 'Tidak ada URL',
                ),
              ],
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),

      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat,
    );
  }
}