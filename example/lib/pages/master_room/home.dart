import 'package:flutter/material.dart';
import 'package:singel_page_route/singel_page_route.dart';
import 'package:singel_page_route_example/constans/singel_page.dart';

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
