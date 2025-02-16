import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants/ui.dart';
import 'package:news_app/logic/blocs/home/home_bloc.dart';
import 'package:news_app/presentation/widgets/news_card.dart';
import 'package:news_app/presentation/widgets/news_topic_chip.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100 &&
        !_isFetchingMore) {
      _fetchMoreNews();
    }
  }

  bool get _isFetchingMore {
    final state = context.read<HomeBloc>().state;
    return state.isLoadingMore ||
        (state.news[state.index]!.articles.length >= state.totalArticles);
  }

  void _fetchMoreNews() {
    final bloc = context.read<HomeBloc>();
    final state = bloc.state;

    if (state.news[state.index]!.articles.length >= state.totalArticles) {
      return;
    }

    final nextPage = state.pageNumber + 1;
    bloc.add(FetchMoreNews(index: state.index, pageNumber: nextPage));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
                  controller: _scrollController,
                  addAutomaticKeepAlives: true,
                  shrinkWrap: true,
                  itemCount: state.news[state.index]!.articles.length +
                      1, // Extra item for loader
                  itemBuilder: (context, index) {
                    final articles = state.news[state.index]!.articles;

                    if (index < articles.length) {
                      final article = articles[index];
                      return NewsCard(
                        key: ValueKey(article.url),
                        index: index,
                        article: article,
                        keepAlive: true,
                      );
                    } else {
                      // Show loading indicator at the end of the list
                      return state.news[state.index]!.articles.length <
                              state.totalArticles
                          ? const Center(child: CircularProgressIndicator())
                          : const SizedBox.shrink();
                    }
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
