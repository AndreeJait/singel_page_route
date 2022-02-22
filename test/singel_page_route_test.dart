import 'package:flutter_test/flutter_test.dart';
import 'package:singel_page_route/singel_page_route.dart';

import 'singel_page_route_test_variabel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const home = Home();
  const search = Search();
  var routes = {
    'home': home,
    'search': search
  };

  setUp(() {
    SingelPageRoute.initSingelPageRoute("home", routes);
  });

  tearDown(() {
    SingelPageRoute.close();
  });

  test('test_validate_router_exist', () {
    expect(SingelPageRoute.checkRouterExist("home2"), false);
    expect(SingelPageRoute.checkRouterExist("home"), true);
  });
  
  test("test_push_route_without_trigger", (){
    SingelPageRoute.pushNamedWithoutTrigger("home");
    expect(SingelPageRoute.current, home);
  });

  test("test_push_route", (){
    SingelPageRoute.initSingelPageRoute("home", routes);
    SingelPageRoute.listen(expectAsync1((data){
      expect(data, home);
      SingelPageRoute.close();
    }));

    SingelPageRoute.pushName("home");

  });

  test("test_push_route_and_replace", (){
    SingelPageRoute.initSingelPageRoute("home", routes);
    SingelPageRoute.pushNamedWithoutTrigger("home");
    SingelPageRoute.listen(expectAsync1((data){
      expect(data, search);
      expect(SingelPageRoute.currentName, "search");
      SingelPageRoute.close();
    }));

    SingelPageRoute.pushAndReplaceName("search");
  });

  test("test_push_route_and_replace", (){
    SingelPageRoute.initSingelPageRoute("home", routes);
    SingelPageRoute.pushNamedWithoutTrigger("search");
    SingelPageRoute.listen(expectAsync1((data){
      expect(data, home);
      expect(SingelPageRoute.currentName, "home");
      SingelPageRoute.close();
    }));

    SingelPageRoute.previous();
  });
}
