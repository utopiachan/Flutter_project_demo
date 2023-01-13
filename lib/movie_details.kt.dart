import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'movie.dart';

class MovieDetails extends StatefulWidget
{
  final String id; //this is an id now

  const MovieDetails({Key key, this.id}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {

  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final yearController = TextEditingController();
  final durationController = TextEditingController();
  final week5Controller = TextEditingController();
  final week6Controller = TextEditingController();
  final week7Controller = TextEditingController();
  final week8Controller = TextEditingController();
  final week9Controller = TextEditingController();
  final week10Controller = TextEditingController();
  final week11Controller = TextEditingController();
  final week12Controller = TextEditingController();

  String dropdownValue = 'F';
  String dropdownValue1 = 'NN';
  String dropdownValue2 = '0';
  String dropdownValue3 = 'Absent';

  List <String> spinnerItems = [
    'A',
    'B',
    'C',
    'D',
    'F'
  ] ;
  List <String> spinnerItems1 = [
    'HD+',
    'HD',
    'DN',
    'CR',
    'PP',
    'NN'
  ] ;
  List <String> spinnerItems2 = [
    '4',
    '3',
    '2',
    '1',
    '0'
  ] ;
  List <String> spinnerItems3 = [
    'Attend',
    'Absent'
  ] ;
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
      week5Controller.text = movie.week5.toString();
      week6Controller.text = movie.week6.toString();
      week7Controller.text = movie.week7.toString();
      week8Controller.text = movie.week8.toString();
      week9Controller.text = movie.week9.toString();
      week10Controller.text = movie.week10.toString();
      week11Controller.text = movie.week11.toString();
      week12Controller.text = movie.week12.toString();
     switch (movie.week1.toString()){
        case "100":{tempw1='A';}
        break;
        case "80":{tempw1='B';}
        break;
        case "70":{tempw1='C';}
        break;
        case "60":{tempw1='D';}
        break;
        case "0":{tempw1='F';}
        break;
      }
      switch (movie.week2.toString()){
        case "100":{tempw2='HD+';}
        break;
        case "80":{tempw2='HD';}
        break;
        case "70":{tempw2='DN';}
        break;
        case "60":{tempw2='CR';}
        break;
        case "50":{tempw2='PP';}
        break;
        case "0":{tempw2='NN';}
        break;
      }
      switch (movie.week3.toString()){
        case "100":{tempw3='4 pt';}
        break;
        case "75":{tempw3='3 pt';}
        break;
        case "50":{tempw3='2 pt';}
        break;
        case "25":{tempw3='1 pt';}
        break;
        case "0":{tempw3='0 pt';}
        break;
      }
      switch (movie.week4.toString()){
        case "100":{tempw4='Attend';}
        break;
        case "0":{tempw4='Absent';}
        break;
      }
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
                          ListTile(
                            title: Text( "Week1 Mark: (A-F) Current Mark: "+ tempw1),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 18,
                            elevation: 12,
                            style: TextStyle(color: Colors.purple, fontSize: 16),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String data) {
                              setState(() {
                                dropdownValue = data;
                              });
                            },
                            items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          ListTile(
                            title: Text( "Week2 Mark: (HD-NN) Current Mark: "+ tempw2),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue1,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 18,
                            elevation: 12,
                            style: TextStyle(color: Colors.purple, fontSize: 16),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String data) {
                              setState(() {
                                dropdownValue1 = data;
                              });
                            },
                            items: spinnerItems1.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          ListTile(
                            title: Text( "Week3 Mark: (Check point of 4) Current Mark: "+ tempw3),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue2,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 18,
                            elevation: 12,
                            style: TextStyle(color: Colors.purple, fontSize: 16),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String data) {
                              setState(() {
                                dropdownValue2 = data;
                              });
                            },
                            items: spinnerItems2.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          ListTile(
                            title: Text( "Week4 Mark: (Attendence) Current Mark: "+ tempw4),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue3,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 18,
                            elevation: 12,
                            style: TextStyle(color: Colors.purple, fontSize: 16),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String data) {
                              setState(() {
                                dropdownValue3 = data;
                              });
                            },
                            items: spinnerItems3.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Week 5 Mark:"),
                            keyboardType: TextInputType.number,
                            controller: week5Controller,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Week 6 Mark:"),
                            keyboardType: TextInputType.number,
                            controller: week6Controller,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Week 7 Mark:"),
                            keyboardType: TextInputType.number,
                            controller: week7Controller,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Week 8 Mark:"),
                            keyboardType: TextInputType.number,
                            controller: week8Controller,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Week 9 Mark:"),
                            keyboardType: TextInputType.number,
                            controller: week9Controller,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Week 10 Mark:"),
                            keyboardType: TextInputType.number,
                            controller: week10Controller,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Week 11 Mark:"),
                            keyboardType: TextInputType.number,
                            controller: week11Controller,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Week 12 Mark:"),
                            keyboardType: TextInputType.number,
                            controller: week12Controller,
                          ),


                          ElevatedButton.icon(onPressed: () {
                            if (_formKey.currentState.validate())
                            {
                              if (adding)
                              {
                                movie = Movie();
                              }

                              //update the movie object
                              movie.title = titleController.text;
                              movie.sid = int.parse(yearController.text); //good code would validate these
                              movie.week5 = int.parse(week5Controller.text);
                              movie.week6 = int.parse(week6Controller.text);
                              movie.week7 = int.parse(week7Controller.text);
                              movie.week8 = int.parse(week8Controller.text);
                              movie.week9 = int.parse(week9Controller.text);
                              movie.week10 = int.parse(week10Controller.text);
                              movie.week11 = int.parse(week11Controller.text);
                              movie.week12 = int.parse(week12Controller.text);
                              switch (dropdownValue){
                                case "A":{movie.week1=100;}
                                break;
                                case "B":{movie.week1=80;}
                                break;
                                case "C":{movie.week1=70;}
                                break;
                                case "D":{movie.week1=60;}
                                break;
                                case "F":{movie.week1=0;}
                                break;
                              }
                              switch (dropdownValue1){
                                case "HD+":{movie.week2=100;}
                                break;
                                case "HD":{movie.week2=80;}
                                break;
                                case "DN":{movie.week2=70;}
                                break;
                                case "CR":{movie.week2=60;}
                                break;
                                case "PP":{movie.week2=50;}
                                break;
                                case "NN":{movie.week2=0;}
                                break;
                              }
                              switch (dropdownValue2){
                                case "4":{movie.week3=100;}
                                break;
                                case "3":{movie.week3=75;}
                                break;
                                case "2":{movie.week3=50;}
                                break;
                                case "1":{movie.week3=25;}
                                break;
                                case "0":{movie.week3=0;}
                                break;
                              }
                              switch (dropdownValue3){
                                case "Attend":{movie.week4=100;}
                                break;
                                case "Absent":{movie.week4=0;}
                                break;
                              }
                               //good code would validate these

                              if (adding)
                                Provider.of<MovieModel>(context, listen:false).add(movie);
                              else
                                Provider.of<MovieModel>(context, listen:false).update(widget.id, movie);
                              //return to previous screen
                              Navigator.pop(context);
                            }
                          }, icon: Icon(Icons.save), label: Text("Save Student")),

                          ElevatedButton.icon(onPressed: () {

                                Provider.of<MovieModel>(context, listen:false).delete(widget.id);
                                   Navigator.pop(context);

                                   }, icon: Icon(Icons.delete_rounded), label: Text("Delete Student")),

                              ],
                              ),



                        ),
                      ),
                    )
                  )

             ]
         )
         )
    );
  }
}
