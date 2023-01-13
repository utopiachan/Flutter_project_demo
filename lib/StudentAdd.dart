import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie.dart';

class StudentAdd extends StatefulWidget
{
  final String id; //this is an id now

  const StudentAdd({Key key, this.id}) : super(key: key);

  @override
  _StudentAddState createState() => _StudentAddState();
}

class _StudentAddState extends State<StudentAdd> {

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final yearController = TextEditingController();

  @override
  Widget build(BuildContext context)
  {
    var movies = Provider.of<MovieModel>(context, listen:false).items;
    var movie = Provider.of<MovieModel>(context, listen:false).get(widget.id);
    var adding = movie == null;
    var tempw1='0';
    var tempw2='0';
    var tempw3='0';
    var tempw4='0';
    if (!adding) {
      titleController.text = movie.title;
      yearController.text = movie.sid.toString();
    }


    return Scaffold(
        appBar: AppBar(
          title: Text(adding ? "Add Movie" : "Edit Movie"),
        ),
        body: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if (adding == false) Text("Movie Index ${widget.id}"),
                  //check out this dart syntax, lets us do an if as part of an argument list
                  Expanded(
                      child:Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[


                                  TextFormField(
                                    decoration: InputDecoration(labelText: "Student Name"),
                                    controller: titleController,
                                  ),
                                  TextFormField(
                                    decoration: InputDecoration(labelText: "Student ID"),
                                    keyboardType: TextInputType.number,
                                    controller: yearController,
                                  ),


                                  ElevatedButton.icon(onPressed: () {
                                    if (_formKey.currentState.validate())
                                    {
                                      if (adding)
                                      {
                                        movie = Movie();
                                      }

                                      movie.title = titleController.text;
                                      movie.sid = int.parse(yearController.text);
                                      movie.week1 = 0;
                                      movie.week2 = 0;
                                      movie.week3 = 0;
                                      movie.week4 = 0;
                                      movie.week5 = 0;
                                      movie.week6 = 0;
                                      movie.week7 = 0;
                                      movie.week8 = 0;
                                      movie.week9 = 0;
                                      movie.week10 = 0;
                                      movie.week11 = 0;
                                      movie.week12 = 0;
                                      //good code would validate these


                                      if (adding)
                                        Provider.of<MovieModel>(context, listen:false).add(movie);
                                      else
                                        Provider.of<MovieModel>(context, listen:false).update(widget.id, movie);


                                      //return to previous screen
                                      Navigator.pop(context);
                                    }
                                  }, icon: Icon(Icons.save), label: Text("Add Student")),

                                ],
                              ),
                            ),
                          )
                      )
                  )
                ]
            )
        )
    );
  }
}
