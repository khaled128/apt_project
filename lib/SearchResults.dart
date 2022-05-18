// ignore_for_file: file_names, prefer_const_constructors

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:gradient_borders/gradient_borders.dart';

// const baseurl = "http://10.0.2.2:3000/pages";
const baseurl = "http://192.168.1.2:3000/pages";

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key}) : super(key: key);
  static String route = 'searchresult';
  @override
  State<SearchResult> createState() => _SearchResultState();
}

Future<String> fetchitem() async {
  final res = await http.get(Uri.parse(baseurl));
  if (res.statusCode == 200) {
    return res.body;
  } else {
    throw Exception('Failed to load post');
  }
}

Future<List<dynamic>> getdata() async {
  var body = await fetchitem();
  return json.decode(body);
  // log(pages.length.toString());
}

class _SearchResultState extends State<SearchResult> {
  late String searchResult;
  int _page = 0;
  static const int _perPage = 6;

  @override
  Widget build(BuildContext context) {
    // List<String> links = List.filled(28, "https://www.youtube.com/");
    List<String> links = [
      "https://github.com/",
      "https://www.youtube.com/",
      "https://www.google.com/",
      "https://www.facebook.com/",
      "https://www.instagram.com/",
      "https://www.wikipedia.org/",
      "https://pub.dev/D"
    ];
    searchResult = ModalRoute.of(context)?.settings.arguments as String;

    return Container(
      color: Colors.white,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text("Search Result for $searchResult"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future:
                        Future.delayed(Duration(seconds: 1), () => getdata()),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        int end = (_page * _perPage) + _perPage;
                        if (end >= snapshot.data.length) {
                          end = snapshot.data.length;
                        }
                        final dataToShow =
                            snapshot.data.sublist((_page * _perPage), (end));

                        return Column(children: [
                          Text("About ${snapshot.data.length} results"),
                          SizedBox(height: 5),
                          ListView.builder(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: dataToShow.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () =>
                                    _launchUrl(dataToShow[index]['url']),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      dataToShow[index]['url'],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.blue[400],
                                          fontSize: 12),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      dataToShow[index]['title'],
                                      style: const TextStyle(
                                          color:
                                              Color.fromARGB(255, 153, 34, 135),
                                          fontSize: 20),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      dataToShow[index]['paragraph'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 15),
                                    ),
                                    SizedBox(height: 10),
                                    Divider(thickness: 2)
                                  ],
                                ),
                              );
                            },
                          ),
                          buttomBar(snapshot.data.length, end)
                        ]);
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    }),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Row buttomBar(int links, int end) {
    // log("end ${end.toString()}");
    // var x = (_page + 1) * _perPage;
    // log(x.toString());
    log("page ${_page}");

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (_page > 0)
          Container(
            width: 130,
            height: 35,
            decoration: BoxDecoration(
                border: const GradientBoxBorder(
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.purple]),
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(16)),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  log("tapped prevois");
                  _page -= 1;
                  log(_page.toString());
                });
              },
              child: const Text("Prevois Page"),
            ),
          ),
        if (_page + 1 <= links / _perPage && end != links)
          Container(
            width: 130,
            height: 35,
            decoration: BoxDecoration(
                border: const GradientBoxBorder(
                  gradient:
                      LinearGradient(colors: [Colors.blue, Colors.purple]),
                  width: 4,
                ),
                borderRadius: BorderRadius.circular(16)),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  log("tapped Next");
                  _page += 1;
                });
              },
              child: const Text("Next Page"),
            ),
          ),
      ],
    );
  }
}

// return WebView(
//   initialUrl: "https://www.google.com/",
//   javascriptMode: JavascriptMode.unrestricted,
// );

_launchUrl(String _url) async {
  final Uri link = Uri.parse(_url);
  if (!await launchUrl(link)) throw 'Could not launch $_url';
}

// FutureBuilder(
//     future: gettitle(links[index]),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         log("TITLE: " + snapshot.data.toString());
//         if (snapshot.data.toString() == "404 Not Found") {
//           return Container();
//         }
//         return Text(snapshot.data.toString());
//       } else {
//         return Container();
//       }
//     }),
// FutureBuilder(
//     future: getParagraph(links[index]),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         log("Para: " + snapshot.data.toString());
//         if (snapshot.data.toString() == "404 Not Found") {
//           return Container();
//         }
//         return Text(snapshot.data.toString());
//       } else {
//         return Container();
//       }
//     }),

// Future<String?> gettitle(String link) async {
//   final res = await http.get(Uri.parse(link));
//   final doc = parse(res.body);

//   String? title = doc.getElementsByTagName('title').isEmpty
//       ? null
//       : doc.getElementsByTagName('title')[0].text.toString();
//   return title;
// }

// Future<String?> getParagraph(String link) async {
//   final res = await http.get(Uri.parse(link));
//   final doc = parse(res.body);

//   String? title = doc.getElementsByTagName('p1').isEmpty
//       ? null
//       : doc.getElementsByTagName('p1')[0].text.toString();

//   return title;
// }


// _launchUrl(dataToShow[index]);
// get request link
// parse html html.parse(response)
// response get tags and titles
// title => title   paragraph => P

// final res = await http.get(Uri.parse(links[index]));
// final doc = parse(res.body);
// log(doc.getElementsByTagName('title')[0].text.toString());
//  log(doc.getElementsByTagName('p')[0].text.toString());

  // void getdata() async {
  //   try {
  //     const baseurl = "http://10.0.2.2:3000/replies";
  //     var response = await http.get(Uri.parse(baseurl));
  //     var data = jsonDecode(response.body);
  //     log(response.body);
  //   } catch (e) {
  //     log(e.toString());
  //     throw Exception(e);
  //   }
  // }



  // Text("About ${pages.length} results"),
  //               ListView.builder(
  //                 shrinkWrap: true,
  //                 itemCount: pages.length,
  //                 itemBuilder: (context, index) {
  //                   return InkWell(
  //                     onTap: () => _launchUrl(pages[index]['url']),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         const SizedBox(height: 10),
  //                         Text(
  //                           pages[index]['url'],
  //                           overflow: TextOverflow.ellipsis,
  //                           style: const TextStyle(
  //                               color: Colors.black, fontSize: 12),
  //                         ),
  //                         const SizedBox(height: 10),
  //                         Text(
  //                           pages[index]['title'],
  //                           style: const TextStyle(
  //                               color: Color.fromARGB(255, 153, 34, 135),
  //                               fontSize: 20),
  //                         ),
  //                         SizedBox(height: 10),
  //                         Text(
  //                           pages[index]['paragraph'],
  //                           overflow: TextOverflow.ellipsis,
  //                           maxLines: 3,
  //                           style: const TextStyle(
  //                               color: Colors.black, fontSize: 12),
  //                         ),
  //                         SizedBox(height: 10),
  //                         Divider(thickness: 2)
  //                       ],
  //                     ),
  //                   );
  //                 },
  //               ),
                