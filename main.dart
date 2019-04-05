import 'package:flutter/material.dart';
import 'package:assignment_app/movie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:assignment_app/single_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      home:  Scaffold(
        appBar:  AppBar(
          backgroundColor: Colors.pinkAccent,
          title: Text('Movies'),
        ),
        body: Center(
          child: Movies(),
        ),
      ),
    );
  }
}

class Movies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoviesState();
  }
}

class MoviesState extends State<Movies> {
  List<Movie> _movies =  List();
  final URL = "https://gfioehu47k.execute-api.us-west-1.amazonaws.com/staging/main";

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _movies.length,
        itemBuilder: (context, i) {
          return Card(
              child: Container(
                  height: 250.0,
                  child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Row(children: <Widget>[
                         Align(
                          child: Hero(
                              child: Image.network(
                                  "https://image.tmdb.org/t/p/w500" +
                                      this._movies[i].getPoster()),
                              tag: this._movies[i].getTitle()),
                          alignment: Alignment.center,
                        ),
                        Expanded(
                            child: Stack(children: <Widget>[
                          Align(
                            child: Text(
                              this._movies[i].getTitle(),
                              style: TextStyle(
                                  fontSize: 11.0, fontWeight: FontWeight.bold)
                              ,
                            ),
                            alignment: Alignment.topCenter,
                          ),
                          Align(
                            child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(this._movies[i].getOverview(),
                                    maxLines: 8,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontStyle: FontStyle.italic))),
                            alignment: Alignment.centerRight,
                          ),
                          Align(
                            child: Row(
                              children: <Widget>[
                             Expanded(child: RaisedButton(
                               child:Text('Favourite'),
                                 onPressed:(){
                                 setState(() {

                                 });
                                 }
                             ),),

                                Expanded(
                                 child: RaisedButton(
                                     child:Text('More Info'),

                                     onPressed:(){
                                       setState(() {
                                         Navigator.push(context, MaterialPageRoute(builder:(context){
                                           return MoreInfo(this._movies[i]);
                                         }));
                                       });
                                     }
                                  ),
                                ),

                              ],
                            ),
                            alignment: Alignment.bottomLeft,
                          ),

                           Align(
                              child: Text('Releasing on'+
                                this._movies[i].getReleaseDate(),
                                style: TextStyle(
                                    fontSize: 11.0, fontWeight: FontWeight.bold),
                              ),
                              alignment: Alignment.bottomCenter,
                            ),


                        ]))
                      ]))));

        });

  }
  void _addMovie(dynamic movie){
    this._movies.add(new Movie(
        title: movie["title"],
        overview: movie["overview"],
        poster: movie["poster_path"],
        releaseDate: movie["release_date"]
    ));
  }
  void initState() {
    super.initState();
    http.get(this.URL)
        .then((response) => response.body)
        .then(json.decode)
        .then((movies) {
      movies.forEach(_addMovie);
      setState(() {

      });
    });
  }

}
