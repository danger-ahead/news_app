import 'package:flutter/material.dart';
import 'package:news_app/data/models/news_model.dart';
import 'package:news_app/presentation/widgets/cached_image.dart';
import 'package:news_app/utils/helpers.dart';

class NewsCard extends StatefulWidget {
  const NewsCard(
      {super.key,
      required this.index,
      required this.article,
      this.keepAlive = false});

  final int index;
  final Article article;
  final bool keepAlive;

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => widget.keepAlive;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
          child: InkWell(
        onTap: () async {
          await openNews(widget.article.url);
        },
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text((widget.index + 1).toString(),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary))),
                  Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Text(widget.article.source.name,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary))),
                ],
              ),
              if (widget.article.urlToImage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CachedImageWidget(
                          imageUrl: widget.article.urlToImage!,
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              Text(widget.article.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              Text(widget.article.description,
                  style: TextStyle(fontWeight: FontWeight.w500)),
              OverflowBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.article.author != null)
                    Text('Author: ${widget.article.author!}'),
                  Text(
                    'Published at: ${widget.article.publishedAt.toLocal().toString().substring(0, 11)}',
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}
