//import 'dart:js_util';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled3/models/Postmodel.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Postmodel> postList = [];
  Future<List<Postmodel>> getapi() async {
  final respone = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  var data = jsonDecode(respone.body.toString());
  if(respone.statusCode == 200)
  {
    postList.clear();
    for(Map i in data)
    {

      postList.add(Postmodel.fromJson(i));
    }
    return postList;
  }
  else
    {
      return postList;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('API')),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: getapi(),
              builder: (context,snapshot){
              if(!snapshot.hasData)
                {
                 return Text('Loading........');
                }
              else
                {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: postList.length,
                          itemBuilder: (context,index){
                            //return Text(index.toString());
                            //return Text(postList[index].title.toString());
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Title',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    Text( postList[index].title.toString()),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text('Description',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                    Text( postList[index].body.toString()),
                                  ],
                                ),
                              ),
                            );
                      } ),
                    );
                }
              },
          )
        ],
      ),
    );
  }
}
