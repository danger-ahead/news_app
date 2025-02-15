import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants/ui.dart';
import 'package:news_app/logic/blocs/home/home_bloc.dart';
import 'package:news_app/presentation/widgets/cached_image.dart';
import 'package:news_app/presentation/widgets/news_topic_chip.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Padding(
        padding: pagePadding,
        child: Column(
          spacing: 10,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 10,
                children: newsTopics
                    .map((topic) => BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                          return NewsTopicChip(
                            text: topic,
                            onPressed: () => BlocProvider.of<HomeBloc>(context)
                                .add(FetchNews(
                                    index: newsTopics.indexOf(topic))),
                            activeBackgroundColor:
                                state.index == newsTopics.indexOf(topic)
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                            activeForegroundColor:
                                state.index == newsTopics.indexOf(topic)
                                    ? Colors.white
                                    : Theme.of(context).colorScheme.primary,
                          );
                        }))
                    .toList(),
              ),
            ),
            Expanded(
              child:
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.news[state.index]!.articles.length,
                  itemBuilder: (context, index) {
                    final article = state.news[state.index]!.articles[index];

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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text((index + 1).toString(),
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary))),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    child: Text(article.source.name,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary))),
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
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            Text(article.description,
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            OverflowBar(
                              alignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (article.author != null)
                                  Text('Author: ${article.author!}'),
                                Text(
                                  'Published at: ${article.publishedAt.toLocal().toString().substring(0, 11)}',
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
