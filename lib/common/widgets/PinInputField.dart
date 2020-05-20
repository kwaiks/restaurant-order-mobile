import 'package:flutter/material.dart';

class InputPin extends StatefulWidget {
  final int total;
  final TextEditingController controller;
  ///Passing parameter back
  final ValueChanged<String> onChanged;
  InputPin({@required this.total,this.controller,@required this.onChanged});
  @override
  _InputPinState createState() => _InputPinState();
}

class _InputPinState extends State<InputPin> {
  bool isLoaded = false;
  List<String> _textList;
  FocusNode _focusNode;
  TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = widget.controller != null? widget.controller:TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener((){
      setState((){});
    });
    _textList = List<String>(widget.total);
    initializeValue();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  onChanged(String val){
    var replacedString = List<String>(widget.total);
    for(int i = 0; i<widget.total;i++){
      replacedString[i] = val.length > i ? val[i]:"";
    }
    if(val.length>widget.total){
      print(val);
    }
    setState((){
      _textList = replacedString;
    });
    widget.onChanged(val);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AbsorbPointer(
          absorbing: true,
          child: TextField(
            autofocus: true,
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            focusNode: _focusNode,
            controller: _textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none
            ),
            onChanged: (val)=>val.length>widget.total?null:onChanged(val),
          )),
        Row(children: _generateFields())
      ],
    );
  }

  void initializeValue(){
    for (int i = 0; i < _textList.length; i++) {
      _textList[i] = "";
    }
  }

  List<Widget> _generateFields() {
    var result = <Widget>[];
    for (int index = 0; index < widget.total; index++) {
      result.add(
        GestureDetector(
          onTap: onFocus,
                  child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: 50,
              height: 50,
              alignment: Alignment.centerLeft,
              child: Text(
                _textList[index].isNotEmpty?_textList[index]:'\u25CF',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)
              )),
        ));
    }
    return result;
  }

  void onFocus(){
    if(_textEditingController.text.length>widget.total){
      _textEditingController.text = _textEditingController.text.substring(0,widget.total);
    }
    if(_focusNode.hasFocus){
      _focusNode.unfocus();
    }
    _focusNode.requestFocus();
  }
}