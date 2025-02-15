import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants/size.dart';
import 'package:news_app/constants/ui.dart';
import 'package:news_app/logic/blocs/search/search_bloc.dart';
import 'package:news_app/presentation/widgets/news_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Padding(
        padding: pagePadding,
        child: BlocProvider(
          create: (context) => SearchBloc()..add(FetchPreviousSearches()),
          child: Column(
            spacing: 10,
            children: [
              BlocBuilder<SearchBloc, SearchState>(
                  buildWhen: (previous, current) => false,
                  builder: (context, state) {
                    return TextFormField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search",
                        suffixIcon: InkWell(
                          onTap: () => BlocProvider.of<SearchBloc>(context).add(
                              PerformSearch(
                                  query: _searchController.text.trim())),
                          child: Icon(Icons.search,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    );
                  }),
              Expanded(
                child: BlocBuilder<SearchBloc, SearchState>(
                    builder: (context, state) {
                  if (state.isSearching) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state.currentResults != null) {
                    return Column(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () =>
                                  BlocProvider.of<SearchBloc>(context)
                                      .add(ClearSearch()),
                              child: Text('Clear')),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Text("Search Results for ",
                                  style: TextStyle(fontSize: largeText)),
                              Text(state.searchQuery,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: largeText,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary)),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.currentResults!.articles.length,
                            itemBuilder: (context, index) {
                              final article =
                                  state.currentResults!.articles[index];

                              return NewsCard(
                                  key: ValueKey(article.url),
                                  index: index,
                                  article: article);
                            },
                          ),
                        ),
                      ],
                    );
                  }

                  return state.previousSearches.isEmpty
                      ? Center(
                          child: Text("No previous searches",
                              style: TextStyle(fontSize: largeText)))
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Previous Searches",
                                    style: TextStyle(fontSize: largeText),
                                  ),
                                ),
                              ),
                              ...state.previousSearches.asMap().entries.map(
                                    (e) => Column(
                                      children: [
                                        ListTile(
                                            title: Text(e.value),
                                            onTap: () =>
                                                BlocProvider.of<SearchBloc>(
                                                        context)
                                                    .add(PerformSearch(
                                                        query: e.value))),
                                        if (e.key !=
                                            state.previousSearches.length - 1)
                                          Divider()
                                      ],
                                    ),
                                  ),
                            ],
                          ),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
