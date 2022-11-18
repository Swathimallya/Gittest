import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather App',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          title: Text('Flutter weather app'),

        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget> [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children:<Widget> [
                      // Text('New York', style: new TextStyle(color: Colors.white)),
                      // Text('Sunny', style: new TextStyle(color: Colors.white, fontSize: 32.0)),
                      // Text('72°F',  style: new TextStyle(color: Colors.white)),
                      // Image.network('https://openweathermap.org/img/w/01d.png'),
                      // Text('Jun 28, 2018', style: new TextStyle(color: Colors.white)),
                      // Text('18:30', style: new TextStyle(color: Colors.white)),
                      FutureBuilder(
                          future: apicall(),
                          builder: (context,snapshot){
                        if(snapshot.hasData){
                          return Column(
                              children:<Widget> [
                                Text(snapshot.data['name'], style: new TextStyle(color: Colors.white, fontSize: 32.0)),
                                Text(snapshot.data['description'], style: new TextStyle(color: Colors.white)),
                                Text('72°F',  style: new TextStyle(color: Colors.white)),
                                Image.network('https://openweathermap.org/img/w/01d.png'),
                                Text('Jun 28, 2018', style: new TextStyle(color: Colors.white)),
                                Text('18:30', style: new TextStyle(color: Colors.white)),
                                Text(snapshot.data['country']),
                                Text(snapshot.data['Pressure'])
                              ]
                          );
                        }
                        else{
                          return CircularProgressIndicator();
                        }

                      })
                    ],
                  ))
            ],
          ),
        ),
      )
    );
  }
}


Future apicall() async{
  final url =Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=bangalore&appid=980df60f9d48ff866d91fbde2a06bae1");
  final response = await http.get(url);
  print(response.body);
  final json =jsonDecode(response.body);
  print(json['weather'][0]['description']);
  final output = {
    'description': json['weather'][0]['description'],
    'temp' : json['main']['temp'],
    'name' : json['name'],
    'country' :json['sys']['country'],
    'Pressure' :json['main']['pressure'].toString()

  };
  print(output);
  return output;
}
