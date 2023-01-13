import 'package:flutter/material.dart';
import 'package:flutter_tutorial_3/movie_details.kt.dart';
import 'package:provider/provider.dart';

import 'StudentAdd.dart';
import 'movie.dart';
import 'package:firebase_core/firebase_core.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Cross Platform App'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.calendar_view_day), text: "Weeks"),
                Tab(icon: Icon(Icons.people), text: "Students")
              ],
            ),
          ),
          body: TabBarView(
            children: [
              weekSummary(),
              studentSummary(),


            ],
          ),
        ),
      ),
    );
  }
}
class studentSummary extends StatelessWidget
{
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) //this functio is called every time the "future" updates
      {
        // Check for errors
        if (snapshot.hasError) {
          return FullScreenText(text:"Something went wrong");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done)
        {
          //BEGIN: the old MyApp builder from last week
          return ChangeNotifierProvider(
              create: (context) => MovieModel(),
              child: MaterialApp(
                  title: 'Student Summary',
                  theme: ThemeData(
                    primarySwatch: Colors.deepPurple,
                  ),
                  home: MyHomePage(title: 'Student Summary')
              )
          );
          //END: the old MyApp builder from last week
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return FullScreenText(text:"Loading");
      },
    );
  }
}
class weekSummary extends StatelessWidget
{
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context)
  {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) //this functio is called every time the "future" updates
      {
        // Check for errors
        if (snapshot.hasError) {
          return FullScreenText(text:"Something went wrong");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done)
        {
          //BEGIN: the old MyApp builder from last week
          return ChangeNotifierProvider(
              create: (context) => MovieModel(),
              child: MaterialApp(
                  title: 'Week Summary',
                  theme: ThemeData(
                    primarySwatch: Colors.deepPurple,
                  ),
                  home: WeekHomePage(title: 'Week Summary')
              )
          );
          //END: the old MyApp builder from last week
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return FullScreenText(text:"Loading");
      },
    );
  }
}


class WeekHomePage extends StatefulWidget
{
  WeekHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WeekHomePageState createState() => _WeekHomePageState();
}


class _WeekHomePageState extends State<WeekHomePage>
{
  @override
  String dropdownValue = 'Week 1';

  List <String> spinnerItems = [
    'Week 1',
    'Week 2',
    'Week 3',
    'Week 4',
    'Week 5',
    'Week 6',
    'Week 7',
    'Week 8',
    'Week 9',
    'Week 10',
    'Week 11',
    'Week 12'
  ] ;
  var tempw1='0';
  var tempw2='0';
  var tempw3='0';
  var tempw4='0';


  Widget build(BuildContext context) {
    return Consumer<MovieModel>(
        builder:buildScaffold
    );
  }

  Scaffold buildScaffold(BuildContext context, MovieModel movieModel, _) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //added this

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ DropdownButton<String>(
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

            //YOUR UI HERE
         if (dropdownValue == "Week 1")
            if (movieModel.loading) CircularProgressIndicator() else Expanded(
              child: ListView.builder(
                  itemBuilder: (_, index) {
                    var movie = movieModel.items[index];
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
                    return ListTile(
                      title: Text("Student Name: "+movie.title),
                      subtitle: Text("Week 1 Mark: "+tempw1),

                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                            }));
                      },
                    );
                  },
                  itemCount: movieModel.items.length
              ),
            )
            else
            if (dropdownValue == "Week 2")
              if (movieModel.loading) CircularProgressIndicator() else Expanded(
                child: ListView.builder(
                    itemBuilder: (_, index) {
                      var movie = movieModel.items[index];
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
                      return ListTile(
                        title: Text("Student Name: "+movie.title),
                        subtitle: Text("Week 2 Mark: "+tempw2),

                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                              }));
                        },
                      );
                    },
                    itemCount: movieModel.items.length
                ),
              )
            else
              if (dropdownValue == "Week 3")
                if (movieModel.loading) CircularProgressIndicator() else Expanded(
                  child: ListView.builder(
                      itemBuilder: (_, index) {
                        var movie = movieModel.items[index];
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
                        return ListTile(
                          title: Text("Student Name: "+movie.title),
                          subtitle: Text("Week 3 Mark: "+tempw3),

                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                                }));
                          },
                        );
                      },
                      itemCount: movieModel.items.length
                  ),
                )
            else
                if (dropdownValue == "Week 4")
    if (movieModel.loading) CircularProgressIndicator() else Expanded(
    child: ListView.builder(
    itemBuilder: (_, index) {
    var movie = movieModel.items[index];
    switch (movie.week4.toString()){
    case "100":{tempw4='Attend';}
    break;
    case "0":{tempw4='Absent';}
    break;
    }
    return ListTile(
    title: Text("Student Name: "+movie.title),
    subtitle: Text("Week 4 Mark: "+tempw4),

    onTap: () {
         Navigator.push(context, MaterialPageRoute(
    builder: (context) {
    return MovieDetails(id: movie.id); //modify this line, this wont compile at first
    }));
    },
    );
    },
    itemCount: movieModel.items.length
    ),
    )
                else
                  if (dropdownValue == "Week 5")
                    if (movieModel.loading) CircularProgressIndicator() else Expanded(
                      child: ListView.builder(
                          itemBuilder: (_, index) {
                            var movie = movieModel.items[index];
                            return ListTile(
                              title: Text("Student Name: "+movie.title),
                              subtitle: Text("Week 5 Mark: "+movie.week5.toString()),

                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                                    }));
                              },
                            );
                          },
                          itemCount: movieModel.items.length
                      ),
                    )
                  else
                    if (dropdownValue == "Week 5")
                      if (movieModel.loading) CircularProgressIndicator() else Expanded(
                        child: ListView.builder(
                            itemBuilder: (_, index) {
                              var movie = movieModel.items[index];
                              return ListTile(
                                title: Text("Student Name: "+movie.title),
                                subtitle: Text("Week 5 Mark: "+movie.week5.toString()),

                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                                      }));
                                },
                              );
                            },
                            itemCount: movieModel.items.length
                        ),
                      )
                    else
                      if (dropdownValue == "Week 6")
                        if (movieModel.loading) CircularProgressIndicator() else Expanded(
                          child: ListView.builder(
                              itemBuilder: (_, index) {
                                var movie = movieModel.items[index];
                                return ListTile(
                                  title: Text("Student Name: "+movie.title),
                                  subtitle: Text("Week 6 Mark: "+movie.week6.toString()),

                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                                        }));
                                  },
                                );
                              },
                              itemCount: movieModel.items.length
                          ),
                        )
                      else
                        if (dropdownValue == "Week 7")
                          if (movieModel.loading) CircularProgressIndicator() else Expanded(
                            child: ListView.builder(
                                itemBuilder: (_, index) {
                                  var movie = movieModel.items[index];
                                  return ListTile(
                                    title: Text("Student Name: "+movie.title),
                                    subtitle: Text("Week 7 Mark: "+movie.week7.toString()),

                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) {
                                            return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                                          }));
                                    },
                                  );
                                },
                                itemCount: movieModel.items.length
                            ),
                          )
                        else
                          if (dropdownValue == "Week 8")
                            if (movieModel.loading) CircularProgressIndicator() else Expanded(
                              child: ListView.builder(
                                  itemBuilder: (_, index) {
                                    var movie = movieModel.items[index];
                                    return ListTile(
                                      title: Text("Student Name: "+movie.title),
                                      subtitle: Text("Week 8 Mark: "+movie.week8.toString()),

                                      onTap: () {
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) {
                                              return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                                            }));
                                      },
                                    );
                                  },
                                  itemCount: movieModel.items.length
                              ),
                            )
                          else
                            if (dropdownValue == "Week 9")
                              if (movieModel.loading) CircularProgressIndicator() else Expanded(
                                child: ListView.builder(
                                    itemBuilder: (_, index) {
                                      var movie = movieModel.items[index];
                                      return ListTile(
                                        title: Text("Student Name: "+movie.title),
                                        subtitle: Text("Week 9 Mark: "+movie.week9.toString()),

                                        onTap: () {
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) {
                                                return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                                              }));
                                        },
                                      );
                                    },
                                    itemCount: movieModel.items.length
                                ),
                              )
                            else
                              if (dropdownValue == "Week 10")
                                if (movieModel.loading) CircularProgressIndicator() else Expanded(
                                  child: ListView.builder(
                                      itemBuilder: (_, index) {
                                        var movie = movieModel.items[index];
                                        return ListTile(
                                          title: Text("Student Name: "+movie.title),
                                          subtitle: Text("Week 10 Mark: "+movie.week10.toString()),

                                          onTap: () {
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (context) {
                                                  return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                                                }));
                                          },
                                        );
                                      },
                                      itemCount: movieModel.items.length
                                  ),
                                )
                              else
                                if (dropdownValue == "Week 11")
                                  if (movieModel.loading) CircularProgressIndicator() else Expanded(
                                    child: ListView.builder(
                                        itemBuilder: (_, index) {
                                          var movie = movieModel.items[index];
                                          return ListTile(
                                            title: Text("Student Name: "+movie.title),
                                            subtitle: Text("Week 11 Mark: "+movie.week11.toString()),

                                            onTap: () {
                                              Navigator.push(context, MaterialPageRoute(
                                                  builder: (context) {
                                                    return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                                                  }));
                                            },
                                          );
                                        },
                                        itemCount: movieModel.items.length
                                    ),
                                  )
                                else
                                  if (dropdownValue == "Week 12")
                                    if (movieModel.loading) CircularProgressIndicator() else Expanded(
                                      child: ListView.builder(
                                          itemBuilder: (_, index) {
                                            var movie = movieModel.items[index];
                                            return ListTile(
                                              title: Text("Student Name: "+movie.title),
                                              subtitle: Text("Week 12 Mark: "+movie.week12.toString()),

                                              onTap: () {
                                                Navigator.push(context, MaterialPageRoute(
                                                    builder: (context) {
                                                      return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                                                    }));
                                              },
                                            );
                                          },
                                          itemCount: movieModel.items.length
                                      ),
                                    )



    ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget
{
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage>
{
  @override
  Widget build(BuildContext context) {
    return Consumer<MovieModel>(
        builder:buildScaffold
    );
  }

  Scaffold buildScaffold(BuildContext context, MovieModel movieModel, _) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //added this
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return StudentAdd(); //modify this line, this wont compile at first
              }));
        },
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            //YOUR UI HERE
            if (movieModel.loading) CircularProgressIndicator() else Expanded(
              child: ListView.builder(
                  itemBuilder: (_, index) {
                    var movie = movieModel.items[index];
                    var avg = (movie.week1+movie.week2+movie.week3+movie.week4+movie.week5+movie.week6+movie.week7+movie.week8+movie.week9+movie.week10+movie.week11+movie.week12).toDouble();
                    avg = double.parse((avg/12).toStringAsFixed(2));
                    return ListTile(
                      title: Text("Student Name: "+ movie.title),
                      subtitle: Text("Student ID: "+movie.sid.toString()+"     Student Average: "+avg.toString()+"%"),

                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return MovieDetails(id: movie.id); //modify this line, this wont compile at first
                            }));
                      },
                    );
                  },
                  itemCount: movieModel.items.length
              ),
            )
          ],
        ),
      ),
    );
  }
}

//A little helper widget to avoid runtime errors -- we can't just display a Text() by itself if not inside a MaterialApp, so this workaround does the job
class FullScreenText extends StatelessWidget {
  final String text;

  const FullScreenText({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(textDirection:TextDirection.ltr, child: Column(children: [ Expanded(child: Center(child: Text(text))) ]));
  }
}
