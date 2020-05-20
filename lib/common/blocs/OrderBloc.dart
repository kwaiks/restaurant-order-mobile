import 'package:mesan_mobile/common/const/Types.dart';
import 'package:rxdart/rxdart.dart';

typedef void OnError(Exception exception);

class OrderBloc{
  BehaviorSubject<List<Menu>> _menus;
  BehaviorSubject<List<Menu>> get menu => _menus;

  BehaviorSubject<Restaurant> _resto;
  BehaviorSubject<Restaurant> get resto => _resto;

  OrderBloc(){
    _initStreams();
  }

  void _initStreams(){
    _resto = BehaviorSubject<Restaurant>();
    _menus = BehaviorSubject<List<Menu>>.seeded([]);
  }

  void setResto(Restaurant restaurant){
    _resto.add(restaurant);
  }

  void removeMenu(Menu menu){
    List<Menu> _menu = _menus.value;
    print(menu.name);
    Iterable<Menu> check = _menu.where((item)=>item.id==menu.id);
    if (check.length!=0) {
      final selectedMenu = _menu.firstWhere((item)=> item.id == menu.id);
      --selectedMenu.quantity;
      if(selectedMenu.quantity == 0){
        _menu.remove(menu);
      }
    }
    print(Menu.encondeToJson(_menu));
    _menus.add(_menu);
  }

  void clear(){
    List<Menu> menu = _menus.value;
    menu.clear();
    print(menu);
    _menus.add(menu);
  }

  void addMenu(Menu menu) {
    List<Menu> _menu = _menus.value;
    print(menu.name);
    Iterable<Menu> check = _menu.where((item)=>item.id==menu.id);
    if (check.length!=0) {
      final selectedMenu = _menu.firstWhere((item)=> item.id == menu.id);
      ++selectedMenu.quantity;
    }else{
      menu.quantity = 1;
      _menu.add(menu);
    }
    // selectedMenu.quantity = 2;
    // if(selectedMenu != null){
    //   _menu.add(selectedMenu);
    // }else{
    //   print('No Daya');
    // }
    print(Menu.encondeToJson(_menu));
    _menus.add(_menu);
  }

  void dispose(){
    _menus.close();
 } 
}