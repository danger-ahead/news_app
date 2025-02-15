import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/constants/size.dart';
import 'package:news_app/constants/ui.dart';
import 'package:news_app/logic/cubits/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Padding(
        padding: pagePadding,
        child: Column(
          spacing: 10,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Theme", style: TextStyle(fontSize: largeText)),
                BlocBuilder<ThemeCubit, ThemeMode>(
                  builder: (context, state) {
                    return SegmentedButton(
                      segments: [
                        ButtonSegment(
                            value: ThemeMode.light,
                            label: Icon(Icons.wb_sunny)),
                        ButtonSegment(
                            value: ThemeMode.dark,
                            label: Icon(Icons.nightlight_round)),
                        ButtonSegment(
                            value: ThemeMode.system,
                            label: Icon(Icons.brightness_auto)),
                      ],
                      selected: {state},
                      onSelectionChanged: (p0) {
                        BlocProvider.of<ThemeCubit>(context).setThemeMode(
                          p0.first,
                        );
                      },
                      showSelectedIcon: false,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
