// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static String route = '/';
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("LockUpLabs"),
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "https://cdn.wallpapersafari.com/57/55/RTvmOg.jpg")),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 250,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 50,
                      child: OutlinedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            Icon(Icons.search,
                                color: Color.fromARGB(255, 86, 86, 86)),
                            Text(
                              "  Ask anything",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 86, 86, 86)),
                            ),
                          ],
                        ),
                        onPressed: () => showSearch(
                            context: context, delegate: EngineSearch()),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EngineSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          if (query.isEmpty) {
            close(context, 'null');
          } else {
            query = '';
            showSuggestions(context);
          }
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, "");
        },
      );

  @override
  Widget buildResults(BuildContext context) {
    List unique = recentSearch.map((email) => email.toLowerCase()).toList();
    if (!unique.contains(query.toLowerCase())) {
      if (query != "") {
        recentSearch.insert(0, query);
      }
      // if (recentSearch.length > 8) {
      //   recentSearch.removeLast();
      // }
    }
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = recentSearch.where((s) {
      return s.toLowerCase().contains(query.toLowerCase());
    }).toList();
    // if query is not in recentSearch, add it to the list

    return buildSuggestionsSuccess(suggestions);
  }

  @override
  void showResults(BuildContext context) {
    Navigator.of(context).pushNamed(
      "searchresult",
      arguments: query,
    );
    super.showResults(context);
  }

  Widget buildSuggestionsSuccess(List<String> suggestions) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final suggestion = suggestions[index];
        return ListTile(
          title: Text(suggestion),
          leading: const Icon(Icons.restore),
          onTap: () {
            query = suggestion;
            showResults(context);
            query = '';
          },
        );
      },
    );
  }
}

List<String> recentSearch = [
  'Flutter',
  'Dart',
  'Java',
  'Kotlin',
  'Swift',
  'React',
];
