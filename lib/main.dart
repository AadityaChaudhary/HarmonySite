import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:substring_highlight/substring_highlight.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 44, 47, 51),
      ),
      home: MyHomePage(title: 'Harmony Bot Programming'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  String code ='';
  String name = '';
  String desc = '';
  List<CodeEntry> entries = new List<CodeEntry>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        //leading: Image.file(File("/home/aadi/cs/Harmony_Site/lib/assets/harmony.png")),
        leading: IconButton(
          icon: Icon(Icons.apps),
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
        title: Row(
          children: <Widget>[
            SizedBox(

              width: 150,

              child: TextField(

                cursorColor: Colors.amber,
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  hintText: "name",
                  border: OutlineInputBorder(gapPadding: 0, borderRadius: BorderRadius.all(Radius.circular(0))),

                  fillColor: Color.fromARGB(100, 35, 39, 42),
                  filled: true,
                ),
                keyboardType: TextInputType.text,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                },
              ),
            ), //this is the name entry

            Padding(padding: EdgeInsets.only(left: 10)),

          SizedBox(

                width: 500,
                child: TextField(
                  cursorColor: Colors.amber,
                  style: TextStyle(
                    fontSize: 26,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(gapPadding: 0, borderRadius: BorderRadius.all(Radius.circular(0))),
                    fillColor: Color.fromARGB(100, 35, 39, 42),
                    filled: true,
                    hintText: "description:",
                  ),
                  keyboardType: TextInputType.text,
                  onChanged: (value) {
                    setState(() {
                      desc = value;
                    });
                  },
                ),
              ), //this is the name entry
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Text(
          'Existing Bots!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
          ),
        ),
            ),
//            ListView.builder(
//                itemCount: entries.length,
//                itemBuilder: (BuildContext ctx, int index)  {
////                      return Hero(
////                        tag: "entry",
//                        /*child:*/return FlatButton(
//                          child: Text(entries[index].name),
//                          //onPressed: _popupBot(entries[index].name,entries[index].desc),
//                          onPressed: null,
//                        //),
//                     );
//            })
          ],
        ),
      ),
      body: Container(
        color: Color.fromARGB(255, 44, 47, 51),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("<- Save ->",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0
                ),),
                Padding(padding: EdgeInsets.only(left: 50)),
                Text("<- Load ->",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                  ),),
                  Padding(padding: EdgeInsets.only(left: 50)),
                Text("<- Hack ->",
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0
                  ),),
              ],

            ),
          TextField(

            //enableSuggestions: true,
                onChanged: (value) {
                  setState(() {
                    code = value;
                  });
                },
                cursorColor: Colors.amber,
            style: TextStyle(
              fontFamily: "Mono",
              color: Colors.white,
              //fontSize:
            ),
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.arrow_right),
                  border: OutlineInputBorder(),
                  fillColor: Color.fromARGB(100, 35, 39, 42),
                  filled: true,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 40,
              ),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitProgram,
        backgroundColor: Color.fromARGB(255, 114, 137, 218),
        tooltip: 'Build and Deploy',
        child: Icon(Icons.arrow_forward_ios),
      ),

    );
  }

  void _submitProgram() async {
        var url = "http://localhost:10000/";
        print("name '" + name + "' \n" + code);
        var response = await http.post(url, body:{'code' : "name '" + name + "' \n" + code});

        print(response.statusCode);

        if(response.statusCode == 400) {
          _showDialog();
        }

  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Ruh Roh"),
          content: new Text("Looks like your code was bad"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _popupBot(String name, String desc) {

  }
}

class CodeEntry {
  String name;
  String desc;
  String code;

  CodeEntry({this.name, this.desc, this.code});
}
