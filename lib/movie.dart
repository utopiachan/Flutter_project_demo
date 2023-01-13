import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Movie
{
  String id;
  String title;
  int sid;
  int week1;
  int week2;
  int week3;
  int week4;
  int week5;
  int week6;
  int week7;
  int week8;
  int week9;
  int week10;
  int week11;
  int week12;


  Movie({this.title, this.sid, this.week1, this.week2,this.week3, this.week4,this.week5, this.week6,this.week7, this.week8,this.week9, this.week10,this.week11, this.week12,});
  Movie.fromJson(Map<String, dynamic> json)
      :
        title = json['title'],
        sid = json['sid'],
        week1 = json['week1'],
        week2 = json['week2'],
        week3 = json['week3'],
        week4 = json['week4'],
        week5 = json['week5'],
        week6 = json['week6'],
        week7 = json['week7'],
        week8 = json['week8'],
        week9 = json['week9'],
        week10 = json['week10'],
        week11 = json['week11'],
        week12 = json['week12'];

  Map<String, dynamic> toJson() =>
      {
        'title': title,
        'sid': sid,
        'week1' : week1,
        'week2' : week2,
        'week3' : week3,
        'week4' : week4,
        'week5' : week5,
        'week6' : week6,
        'week7' : week7,
        'week8' : week8,
        'week9' : week9,
        'week10' : week10,
        'week11' : week11,
        'week12' : week12,
      };
}

class MovieModel extends ChangeNotifier {
  /// Internal, private state of the list.
  final List<Movie> items = [];
  Movie get(String id)
  {
    if (id == null) return null;
    return items.firstWhere((movie) => movie.id == id);
  }

  //added this
  CollectionReference moviesCollection = FirebaseFirestore.instance.collection(
      'students');

  //added this
  bool loading = false;

  //replaced this
  MovieModel() {
    fetch();
  }

  //added this
  void fetch() async
  {
    //clear any existing data we have gotten previously, to avoid duplicate data
    items.clear();

    //indicate that we are loading
    loading = true;
    notifyListeners(); //tell children to redraw, and they will see that the loading indicator is on

    //get all movies
    var querySnapshot = await moviesCollection.orderBy("title").get();

    //iterate over the movies and add them to the list
    querySnapshot.docs.forEach((doc) {
      //note not using the add(Movie item) function, because we don't want to add them to the db

      var movie = Movie.fromJson(doc.data());
      movie.id = doc.id; //add this line
      items.add(movie);
    });

    //put this line in to artificially increase the load time, so we can see the loading indicator (when we add it in a few steps time)
    //comment this out when the delay becomes annoying
    await Future.delayed(Duration(seconds: 2));

    //we're done, no longer loading
    loading = false;
    notifyListeners();
  }
  void add(Movie item) async
  {
    loading = true;
    notifyListeners();

    await moviesCollection.add(item.toJson());

    //refresh the db
    await fetch();
  }

  void update(String id, Movie item) async
  {
    loading = true;
    notifyListeners();

    await moviesCollection.doc(id).set(item.toJson());

    //refresh the db
    await fetch();
  }

  void delete(String id) async
  {
    loading = true;
    notifyListeners();

    await moviesCollection.doc(id).delete();

    //refresh the db
    await fetch();
  }
}

