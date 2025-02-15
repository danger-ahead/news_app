import 'package:flutter/material.dart';
import 'package:news_app/constants/ui.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Padding(
        padding: pagePadding,
        child: Column(
          spacing: 10,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Search",
                suffixIcon: Icon(Icons.search),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Item $index"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
