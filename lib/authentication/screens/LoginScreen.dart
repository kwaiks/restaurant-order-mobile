import 'package:flutter/material.dart';
import 'package:mesan_mobile/common/widgets/Container.dart';

import '../../common/routes/Routers.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isValid = false;
  final phoneNumber = TextEditingController();

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  checkNumber(){
    print('wew');
    setState((){
      isValid = phoneNumber.text.length > 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
          MainContainer(child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Enter your phone number',style: TextStyle(fontSize:24,fontWeight: FontWeight.w600),),
              Container(
                margin: const EdgeInsets.only(top:10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      height: 40.0,
                      width: 50.0,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image(
                            image: AssetImage('assets/images/indonesia.png'),
                            width: 15,
                            height: 15,),
                          Text('+62',style:TextStyle(fontSize:14)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: phoneNumber,
                        style: TextStyle(fontSize: 20),
                        enableSuggestions: false,
                        decoration: new InputDecoration(
                          hintText: 'Phone Number',
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        onChanged: (value){
                          print(value);
                          setState((){
                            isValid = value.length > 5;
                          });
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                height: 50.0,
                child: SizedBox.expand(
                    child: FlatButton(
                      onPressed: isValid? (){
                        Navigator.pushNamed(context, verifyRoute, arguments: ScreenArguments(phoneNumber: '08233'));
                      }:null,
                      child: Text('Continue'),
                      color: Colors.red,
                      textColor: Colors.white,
                      disabledColor: Colors.grey,
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
