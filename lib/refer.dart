
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
String url="https://covid19.mathdro.id/api/countries/india";

Future<Shape> fetchAlbum() async {
  final response =
      await http.get(url);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Shape.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Property{
  int vaalue;
  Property({this.vaalue});
  
  factory Property.fromJson(Map<String, dynamic> json){
  return Property(
    vaalue: json['value'],
   
  );
}
}
class Property1{
  int vaalue1;
  Property1({this.vaalue1});
  
  factory Property1.fromJson(Map<String, dynamic> json){
  return Property1(
    vaalue1: json['value'],
   
  );
}
}
class Property2{
  int vaalue2;
  Property2({this.vaalue2});
  
  factory Property2.fromJson(Map<String, dynamic> json){
  return Property2(
    vaalue2: json['value'],
   
  );
}
}


class Shape{
  Property proper;
  Property1 prop;
  Property2 pro;
  Shape({this.proper,this.prop,this.pro});
factory Shape.fromJson(Map<String, dynamic> parsedJson){
  return Shape(
     proper: Property.fromJson(parsedJson['confirmed']),
     prop: Property1.fromJson(parsedJson['recovered']),
     pro: Property2.fromJson(parsedJson['deaths']),
  );
}
}



class SecondPage extends StatefulWidget {
  final String datea;
  SecondPage({Key key, @required this.datea} ) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  
  Future<Shape> futureAlbum;
  
  @override
  void initState() {
    super.initState();
     url="https://covid19.mathdro.id/api/countries/"+widget.datea;
    

    
    
  }

  @override
  Widget build(BuildContext context) {
    futureAlbum = fetchAlbum();
    return  Scaffold(
          body: Container(
            decoration: BoxDecoration(color:Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.datea.toUpperCase()+" DATA", style:new TextStyle(fontSize: 50,color:Colors.green,),),
                FutureBuilder<Shape>(
                      future: futureAlbum,
                      builder: (context, snapshot){
                        if (snapshot.hasData) {
                          return  Column(
                            children: <Widget>[
                              Card(
                                elevation:8.0,
                                margin: EdgeInsets.symmetric(horizontal:10.0,vertical:6.0),
                                child: Container(
                                  decoration:BoxDecoration(color:Color.fromRGBO(64, 75, 96, 0.9)),
                                  child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                          right: new BorderSide(width: 1.0, color: Colors.white24))),
                                  child: Icon(Icons.local_hotel, color: Colors.white),

                                ),
                                title: Text(
                                "Number Of Confirmed Cases",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                      children: <Widget>[
                                        Icon(Icons.linear_scale, color: Colors.blue),
                                        Text("  ${snapshot.data.proper.vaalue}",style: TextStyle(color:Colors.blue),),
                                      ],
                                    ),
                              ),
                                ),
                              ),
                               Card(
                                elevation:8.0,
                                margin: EdgeInsets.symmetric(horizontal:10.0,vertical:6.0),
                                child: Container(
                                  decoration:BoxDecoration(color:Color.fromRGBO(64, 75, 96, 0.9)),
                                  child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                          right: new BorderSide(width: 1.0, color: Colors.white24))),
                                  child: Icon(Icons.mood_bad, color: Colors.white),

                                ),
                                title: Text(
                                "Number Of Deaths",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                      children: <Widget>[
                                        Icon(Icons.linear_scale, color: Colors.red),
                                        Text("  ${snapshot.data.pro.vaalue2}",style: TextStyle(color:Colors.red),),
                                      ],
                                    ),
                              
                              ),
                                ),
                              ),
                               Card(
                                elevation:8.0,
                                margin: EdgeInsets.symmetric(horizontal:10.0,vertical:6.0),
                                child: Container(
                                  decoration:BoxDecoration(color:Color.fromRGBO(64, 75, 96, 0.9)),
                                  child: ListTile(
                                contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                                leading: Container(
                                  decoration: new BoxDecoration(
                                      border: new Border(
                                          right: new BorderSide(width: 1.0, color: Colors.white24))),
                                  child: Icon(Icons.mood, color: Colors.white),

                                ),
                                title: Text(
                                "Number Of people Recovered",
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Row(
                                      children: <Widget>[
                                        Icon(Icons.linear_scale, color: Colors.green),
                                        Text("  ${snapshot.data.prop.vaalue1}",style: TextStyle(color:Colors.green),),
                                      ],
                                    ),
                              ),
                                ),
                              ),
                              SizedBox(height: 20,),
                               Text("Stay at Home 🏡", style: TextStyle(color:Colors.white),),
                               Text("Wash your 👐 regularly", style: TextStyle(color:Colors.white),),
                               Text("Prefer 👏 than 🤝", style: TextStyle(color:Colors.white),),
                               SizedBox(height:20),
                               
                              
                            ],
                          );
                        }
                        return CircularProgressIndicator();
                      }
                    ),
                
              ],
            ),
          ),
    );
      
  }
}