import 'package:flutter/material.dart';
import 'package:assignment_app/movie.dart';
import 'package:assignment_app/database_helper.dart';
class FavouriteMovie extends StatefulWidget {
  final Movie fmv;
  FavouriteMovie(this.fmv);
  @override
  State<StatefulWidget> createState() {
    return FavouriteMovieState(this.fmv);
  }

}

class FavouriteMovieState extends State<FavouriteMovie> {
  FavouriteMovieState(this.fmv);
  Movie fmv;
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Favourites'),
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }),
            backgroundColor: Colors.pinkAccent,

          ),
          body: Container(

            color: Colors.black12,
            child: FutureBuilder(
                future: dbHelper.getAllRecords(),
                initialData: List(),
                builder: (context, snapshot){
                  return snapshot.hasData?ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int position) {
                      final item = snapshot.data[position];
                      //get your item data here ...
                      return Card(
                        child: ListTile(
                          title: Text(
                              snapshot.data[position].row[1]),

                        ),
                      );
                    },

                  ):Center(
                      child: CircularProgressIndicator()
                  );


                }),
          )
    ));
    }

}