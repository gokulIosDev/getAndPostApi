import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/Models/NewsModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
      ),
      body: FutureBuilder(
          future: getNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.hasError.toString()),
              );
            } else if (snapshot.data == null || snapshot.data!.articles!.isEmpty) {
              return Center(
                child: Text("Data Not Found"),
              );
            }
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        snapshot.data!.articles![index].urlToImage.toString()),
                  ),
                  title: Text(snapshot.data!.articles![index].title.toString()),
                  subtitle: Text(
                      snapshot.data!.articles![index].description.toString()),
                  trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                );
              },
              itemCount: snapshot.data!.articles!.length,
            );
          }),
    );
  }

  Future<NewsModel> getNews() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=2024-09-28&sortBy=publishedAt&apiKey=11f999fcddb54b70b2dab328a0b8c660"));
    if (response.statusCode == 200) {
      Map<String, dynamic> responseData = jsonDecode(response.body);
      NewsModel newsModel = NewsModel.fromJson(responseData);
      return newsModel;
    } else {
      log(response.body);
      return NewsModel();
    }
  }
}
