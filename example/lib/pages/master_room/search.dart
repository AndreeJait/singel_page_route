import 'package:flutter/material.dart';
import 'package:singel_page_route/singel_page_route.dart';
import 'package:singel_page_route_example/constans/singel_page.dart';

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
