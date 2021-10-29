import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super (key : key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Flutter Scrollable',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key?key}) : super(key:key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];

  // Fetch content from the json file
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/MOCK_DATA.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        centerTitle: true,
        title: Text(
          'Scrollable',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              style:  ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.pink)
              ),
              child: Text('Load Data'),
              onPressed: readJson,
            ),

            // Display the data loaded from sample.json
            _items.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, id) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(child: Image.network("${_items[id]["avatar"]}")),
                                  ],
                                ),
                                Column(children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: Text(_items[id]["first_name"]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Text(_items[id]["last_name"]),
                                      ),
                                    ],
                                  ),
                                  Text(_items[id]["username"]),
                                  Text(_items[id].containsKey("status") ? _items[id]["status"] : "n/a", style: TextStyle(color: Colors.grey[500]),),
                                  //Text(_items[id]["status"]),
                                  ],
                                  
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Text(_items[id]["last_seen_time"]),
                                    CircleAvatar(child: Text(
                                   _items[id].containsKey("messages") ? _items[id]["messages"].toString() : "0"
                               )),
                                  ],
                                ),
                                
                              ]
                              //leading: Image.network("${_items[id]["avatar"]}"), //Text(_items[id]["last_seen_time"]),
                              //title: Text(_items[id]["first_name"]),
                              //subtitle: Text(_items[id]["last_name"]),
                              //avatar: Image.network("${_items[id]["avatar"]}"), 
                              
                            ),
                            
                        );
                        
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
