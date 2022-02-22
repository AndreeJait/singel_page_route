
import 'dart:async';

import 'package:singel_page_route/constans/error_message.dart';

class SingelPageRoute {

  static dynamic _current;
  static List<String> _histories = [];
  static Map<String, dynamic> _routes = {};
  static late StreamController _controller;


  static List<String> get histories => _histories;

  static Map<String, dynamic> get routes => _routes;

  static String get currentName => SingelPageRoute.histories.last;

  static dynamic get current => SingelPageRoute._current;

  static StreamController get controller => SingelPageRoute._controller;

  static void clearHistory (){
    SingelPageRoute._histories = [];
  }

  /// Check the name is on the router or not
  static bool checkRouterExist(String key) => (routes.containsKey(key));

  /// To check if the router exists and throw an error if the name does not exist
  static void validateRouterExist(String name, Function function){
    if(checkRouterExist(name)){
      function();
    }else{
      throw ArgumentError(errorRouterNameNotExist);
    }
  }

  /// Initial router
  static void initSingelPageRoute(String current, Map<String, dynamic> routes){
    SingelPageRoute._routes = routes;
    validateRouterExist(current, (){
      SingelPageRoute._histories.add(current);
      SingelPageRoute._current = _routes[current];
    });
    SingelPageRoute._controller = StreamController.broadcast();
  }

  /// To trigger the flow and return the flow
  static void triggerStream(){
    if(!SingelPageRoute._controller.isClosed){
      SingelPageRoute._controller.add(SingelPageRoute.current);
    }else{
      throw ArgumentError(errorStreamAlreadyClose);
    }
  }

  /// pushName function use to push new page and set current to pushed page without trigger stream
  static void pushNamedWithoutTrigger(String name){
    validateRouterExist(name, (){
      SingelPageRoute._histories.add(name);
      SingelPageRoute._current = SingelPageRoute.routes[name];
    });
  }

  /// pushAndReplaceName is used to push a new page but replaces the previous page with it
  static void pushAndReplaceName(String name){
    validateRouterExist(name, (){
      SingelPageRoute._histories.removeLast();
      SingelPageRoute._histories.add(name);
      SingelPageRoute._current = SingelPageRoute.routes[name];

      triggerStream();
    });
  }

  /// pushName function use to push new page and set current to pushed page
  static void pushName(String name){
    validateRouterExist(name, (){
      SingelPageRoute._histories.add(name);
      SingelPageRoute._current = SingelPageRoute.routes[name];

      triggerStream();
    });
  }

  /// Previous function use to back to before history
  static void previous(){
    if(SingelPageRoute._histories.length > 1){
      SingelPageRoute._histories.removeLast();
      String last = SingelPageRoute._histories.last;
      SingelPageRoute._current = SingelPageRoute.routes[last];

      triggerStream();
    }
  }

  /// @param {Function(dynamic data)} function
  ///
  /// @return StreamSubscription
  ///
  ///
  /// listen function is used to listen to the router stream, every page change will trigger this stream.
  ///  This function will return a StreamSubscription
  static StreamSubscription listen(Function function) =>
      SingelPageRoute._controller.stream.listen((data) {
        function(data);
      });

  /// close function use to unsubcrice stream
  static void close(){
    SingelPageRoute._controller.close();
  }

}
