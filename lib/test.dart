import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Watchlist')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            //todo
            child: SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'movie', label: Text('Movies')),
                ButtonSegment(value: 'tv', label: Text('TV Shows')),
              ],
              selected: {'tv'},
              onSelectionChanged: (value) {
                //cubit.filteredWatchListFun(type: value.first);
              },
            ),
          ),

        ],
      ),
    );

  }
}
