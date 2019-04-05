import 'package:flutter/material.dart';
import 'package:assignment_app/movie.dart';
import 'package:assignment_app/favourite_screen.dart';
import 'package:assignment_app/database_helper.dart';
class MoreInfo extends StatefulWidget{
  final Movie mv;
  MoreInfo(this.mv);
  @override
  State<StatefulWidget> createState() {
    return MoreInfoState(this.mv);
  }
}
class MoreInfoState extends State<MoreInfo> {
  MoreInfoState(this.mv);

  Movie mv;
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies',
      home: Scaffold(
        appBar: AppBar(

          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          backgroundColor: Colors.pinkAccent,
          title: Text('Movies'),
        ),
        body: Center(
          child: ListView(

            children: <Widget>[
             Column(
               children: <Widget>[
                 Row(
                   children: <Widget>[
                    Expanded (child:Container(
                       child: Image.network("https://image.tmdb.org/t/p/w500" + mv.getPoster()),)),
                     Expanded(child:Column(
                       children: <Widget>[
                          Text(mv.getTitle(),style:TextStyle(fontSize: 20.0)),
                              Container(
                                height:5.0
                              ),
                              Text(mv.getOverview(),
                             maxLines: 10,
                             overflow: TextOverflow.ellipsis,
                             style: TextStyle(
                                 fontSize: 18.0,
                                 fontStyle: FontStyle.italic))
                       ],
                     ))
                   ],
                 ),
                 RaisedButton(
                     color: Colors.pinkAccent[100],
                     child: Text('Add to Favourite List'),
                     onPressed: () {
                       setState(() {
                         Navigator.push(context, MaterialPageRoute(builder: (context){
                           _insert();

                           return FavouriteMovie(mv);
                         }));
                       });
                     }),
               ],
             )

            ],
          ),

        ),
      ),
    );;
  }
  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnTitle : mv.getTitle(),

      DatabaseHelper.columnOverview : mv.getOverview(),
      DatabaseHelper.columnReleaseDate  : mv.getReleaseDate(),


    };
    await dbHelper.insert(row);
    AlertDialog(title: Text('correct'),);
  }
}

