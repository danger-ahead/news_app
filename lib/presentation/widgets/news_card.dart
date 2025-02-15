import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/presentation/widgets/cached_image.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.index, required this.article});

  final int index;
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text((index + 1).toString(),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary))),
                Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(article.source.name,
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary))),
              ],
            ),
            if (article.urlToImage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: CachedImageWidget(
                        imageUrl: article.urlToImage!,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            Text(article.title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(article.description,
                style: TextStyle(fontWeight: FontWeight.w500)),
            OverflowBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                if (article.author != null) Text('Author: ${article.author!}'),
                Text(
                  'Published at: ${article.publishedAt.toLocal().toString().substring(0, 11)}',
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
