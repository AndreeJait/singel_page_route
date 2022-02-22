import 'dart:async';

import 'package:flutter/material.dart';
import 'package:singel_page_route/singel_page_route.dart';
import 'package:singel_page_route_example/constans/singel_page.dart';
import 'package:singel_page_route_example/routes/singel_page_routes.dart';

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
