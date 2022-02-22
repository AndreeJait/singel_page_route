import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:singel_page_route/singel_page_route.dart';

const HOME = "HOME";
const SEARCH = "SEARCH";

var routes = {
  HOME: const Home(),
  SEARCH: const Search()
};

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MasterRoom(),
    );
  }
}


class MasterRoom extends StatefulWidget {
  const MasterRoom({Key? key}) : super(key: key);

  @override
  _MasterRoomState createState() => _MasterRoomState();
}

class _MasterRoomState extends State<MasterRoom> {
  late Widget view;
  late StreamSubscription _subscription;
  @override
  void initState() {
    super.initState();

    SingelPageRoute.initSingelPageRoute(HOME, routes);

    if(!SingelPageRoute.histories.isNotEmpty){
      SingelPageRoute.pushNamedWithoutTrigger(HOME);
      view = SingelPageRoute.current;
    }else{
      SingelPageRoute.pushNamedWithoutTrigger(SingelPageRoute.currentName);
      view = SingelPageRoute.current;
    }

    _subscription = SingelPageRoute.listen((data){
      setState(() {
        view = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("EXAMPLE SINGEL ROUTE"),
            leading: SingelPageRoute.histories.length > 1 ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: (){
                SingelPageRoute.previous();
              },
            ) : null,
          ),
          body: view,
        )
    );
  }
}



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: FlatButton(
          color: Colors.blue,
          child: const Text(
            "Go To Search",
            style: TextStyle(
                color: Colors.white
            ),
          ),
          onPressed: (){
            SingelPageRoute.pushAndReplaceName(SEARCH);
          },
        ),
      ),
    );
  }
}


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: MaterialButton(
            color: Colors.blue,
            child: const Text(
              "Back to home",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            onPressed: (){
              SingelPageRoute.pushName(HOME);
            },
          ),
        )
    );
  }
}

