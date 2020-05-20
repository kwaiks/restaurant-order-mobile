import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mesan_mobile/common/blocs/GlobalBloc.dart';
import 'package:mesan_mobile/common/const/Types.dart';
import 'package:mesan_mobile/common/widgets/Container.dart';
import 'package:provider/provider.dart';

class CategorizedMenuList extends StatelessWidget {
  final MenuCategory _menuCategory;
  final bool isOrder;
  CategorizedMenuList(this._menuCategory, {this.isOrder});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(_menuCategory.menuType,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
        ListView.builder(
            itemCount: _menuCategory.menu.length,
            itemBuilder: (context, index) {
              return MenuList(
                  isOrder: isOrder, menu: _menuCategory.menu[index]);
            })
      ],
    );
  }
}

class MenuList extends StatefulWidget {
  final bool isOrder;
  final Menu menu;
  MenuList({this.isOrder, this.menu});

  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  
  @override
  Widget build(BuildContext context) {
    final GlobalBloc bloc = Provider.of<GlobalBloc>(context);
    return GestureDetector(
      onTap: ()=>widget.isOrder? null : _openBottomModal(widget.menu, bloc),
          child: Container(
        height: 80.0,
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            ClipRRect(
              borderRadius: new BorderRadius.circular(8.0),
              child: Image.network(widget.menu.photo,
                  height: 80, width: 80, fit: BoxFit.fitHeight),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.menu.name,
                      style:
                          TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    Text(
                      widget.menu.description,
                      style:
                          TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    RichText(
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: widget.menu.promoStatus
                                ? 'Rp ${widget.menu.promoPrice}'
                                : 'Rp ${widget.menu.price}'),
                        widget.menu.promoStatus
                            ? TextSpan(
                                text: 'Rp ${widget.menu.price}',
                                style: TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough))
                            : null
                      ]),
                    )
                  ],
                ),
              ),
            ),
            StreamBuilder<List<Menu>>(
                stream: bloc.orderBloc.menu,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Menu> menus = snapshot.data;
                    Iterable<Menu> check =
                        menus.where((i) => i.id == widget.menu.id);
                    if (check.length != 0) {
                      final selectedMenu =
                          menus.firstWhere((i) => i.id == widget.menu.id);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('x${selectedMenu.quantity}',
                            style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w600
                            )
                          ),
                          InkWell(
                            onTap: _openModal(selectedMenu, bloc),
                            child: Container(
                              width: 20,
                              height: 20,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5.0)
                              ),
                              child: Icon(MdiIcons.squareEditOutline, color: Colors.white,),
                            ),
                          )
                        ],
                      );
                    }
                  }
                },
            )
          ],
        ),
      ),
    );
  }

  _openBottomModal(Menu menu, GlobalBloc bloc){
    showModalBottomSheet(
      context: context, 
      builder: (context){
        return Container(
          height: MediaQuery.of(context).size.height - 200,
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: Column(),
        );
      });
  }

  _openModal(Menu menu, GlobalBloc bloc){
    showDialog(
      context: context,
      child: new AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
        ),
        title: Text('Add Notes to your dish', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          children: <Widget>[
            DashedSeparator(),
            Container(
              margin: const EdgeInsets.only(top:10.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Makes my foods spicy'
                ),
                maxLines: 4,
              ),
            ),
            SizedBox(height: 1.0,width: double.infinity,),
            SizedBox(
              height: 30.0,
              width: double.infinity,
              child: FlatButton(
                onPressed: (){},
                child: Text('Add Notes', style: TextStyle(fontWeight: FontWeight.bold)),
                color: Colors.red,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      )
    );
  }
}
