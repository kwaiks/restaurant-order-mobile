import 'package:mesan_mobile/common/blocs/OrderBloc.dart';

class GlobalBloc{
  OrderBloc _orderBloc;
  OrderBloc get orderBloc => _orderBloc;

  GlobalBloc(){
    _orderBloc = OrderBloc();
  }

  void dispose(){
    _orderBloc.dispose();
  }
}