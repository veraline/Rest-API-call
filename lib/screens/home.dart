import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List <dynamic> users = [];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Center(
            child:  Text('Rest API call')),
      ),
      body: ListView.builder(
        itemCount: users.length,
          itemBuilder: (context, index){
          final user = users[index];
          final email = user['email'];
          final name = user['name'] ['first'] ;
          final imageUrl = user ['picture'] ['thumbnail'];
        return ListTile(
           leading: ClipRRect(
             borderRadius: BorderRadius.circular(100),
             child:  Image.network(imageUrl),
           ),
          // Text('${index + 1}', style: TextStyle(fontSize: 20),),
            title: Text(name.toString(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
            subtitle: Text(email, style: TextStyle(fontSize: 20),),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
      ),
    );
  }

  void fetchUsers() async{
    const url = 'https://randomuser.me/api/?results=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    setState(() {
      users = json['results'];
      print('fetch users completed');
    }
    );
  }
}



