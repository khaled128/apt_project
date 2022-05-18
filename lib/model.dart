// import 'dart:convert';
// import 'dart:developer';

// import 'package:http/http.dart' as http;

// class FinalModel {
//   late int count;
//   late List<UrlModel> data;

//   FinalModel();

//   Future<FinalModel> getFinalModel() async {
//     var body = await fetchitem();
//     var t = json.decode(body);
//     final List<dynamic> url =
//         t.map((item) => UrlModel.fromJson(item)).toList();
//     data = url;
//     return FinalModel();
//   }

//   @override
//   List<Object> get props => [count, data];
// }

// class UrlModel {
//   late String hyperlink;
//   late String title;
//   late String paragraph;

//   UrlModel();

//   UrlModel.fromJson(Map<String, dynamic> json) {
//     hyperlink = json['url'];
//     title = json['title'];
//     paragraph = json['paragraph'];
//   }

//   @override
//   List<Object> get props => [hyperlink, title, paragraph];
// }

// const baseurl = "http://10.0.2.2:3000/pages";
// Future<String> fetchitem() async {
//   final res = await http.get(Uri.parse(baseurl));
//   log(res.body);
//   if (res.statusCode == 200) {
//     return res.body;
//   } else {
//     throw Exception('Failed to load post');
//   }
// }

// // class UrlModel {

// //   final String hyperlink;
// //   final String title;
// //   final String paragraph;
// //   UrlModel({required this.hyperlink ,required this.title ,required this.paragraph});
  
// //   UrlModel.fromJson(Map<String, dynamic> json) {
// //     hyperlink = json['hyperlink'];
// //     title = json['title'];
// //     paragraph = json['paragraph'];
// //     id = json['id'] as int;
// //   }
// //   Future<UrlModel> geturl() async {
// //     try {
// //       String loginData = await fetchitem();
// //       return UrlModel.fromJson(jsonDecode(loginData));
// //     } on Exception catch (e) {
// //       throw Exception(e);
// //     }
// //   }

// //   @override
// //   List<Object> get props => [hyperlink, title, paragraph, id];
// // }