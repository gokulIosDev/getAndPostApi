import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_app/Models/HomeScreenModel.dart';
import 'package:http/http.dart' as http;
class HomeScreen1 extends StatefulWidget {
  const HomeScreen1({super.key});

  @override
  State<HomeScreen1> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen1> {
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
        title: const Text("News Screen"),
        centerTitle: true,
      ),
      body: FutureBuilder(future: getNews(), builder: (context,snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text(snapshot.hasError.toString()),);
        } else if(snapshot.data == null  || snapshot.data!.articles!.isEmpty) {
          return Center(child: Text("Data Not Found"),);
        }
        return ListView.builder(itemBuilder: (context,index){
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(snapshot.data!.articles![index].urlToImage.toString()),

            ),
            title: Text(snapshot.data!.articles![index].title.toString()),
            subtitle: Text(snapshot.data!.articles![index].description.toString()),
          );
        },itemCount: snapshot.data!.articles!.length,);
      }),
    );
  }
  Future<HomeScreenModel> getNews()async{
    final response = await http.get(Uri.parse("https://newsapi.org/v2/everything?q=apple&from=2024-10-31&to=2024-10-31&sortBy=popularity&apiKey=11f999fcddb54b70b2dab328a0b8c660"));
  if(response.statusCode == 200) {
    Map<String,dynamic> responseData =jsonDecode(response.body);
    print(responseData);
    HomeScreenModel homeScreenModel = HomeScreenModel.fromJson(responseData);
    return homeScreenModel;
  } else {
    return HomeScreenModel();
  }
  }
}
