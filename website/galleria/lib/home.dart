import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:galleria/data.dart';
import 'package:http/http.dart' as http;
import 'imagemodel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var impored = false;

  @override
  void initState() {
    super.initState();
    print("sdfad");
    fetchAlbum();
    impored = false;
  }

  void printer() {
    print("hellp");
  }

  void fetchAlbum() async {
    print("in 1");
    String url = "https://lemon-cocoon-sari.cyclic.app/getter";
    final response = await http.get(Uri.parse(url));
    print("fghhgfd");
    var responseData = json.decode(response.body);
    print("uruyt");
    print(responseData);
    toImage(responseData);
  }

  void toImage(List resposeData) {
    resposeData.forEach((element) {
      if (element["imgurl"] == null) {
        print("null aaya");
        return;
      }
      var CurrenImage =
          ImageModel(id: element["_id"], imgurl: element["imgurl"]);
      TotalData.add(CurrenImage);
    });
    setState(() {
      impored = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    Widget content = Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
    if (impored == true) {
      content = Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: Text("Galleria"),
          ),
          body: Container(
            child: SingleChildScrollView(
              physics: ScrollPhysics(),
              child: StaggeredGrid.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 3,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(TotalData.length, (index) {
                    return Center(
                        child: Card(
                      child: Image.network(
                          TotalData[TotalData.length - 1 - index].imgurl),
                    ));
                  })),
            ),
          ));
    }

    return content;
  }
}
