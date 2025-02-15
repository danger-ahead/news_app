import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants/ui.dart';
import 'package:news_app/logic/blocs/home/home_bloc.dart';
import 'package:news_app/presentation/widgets/news_card.dart';
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

                    return NewsCard(
                        key: ValueKey(article.url),
                        index: index,
                        article: article);
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
