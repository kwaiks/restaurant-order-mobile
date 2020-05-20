import 'package:flutter/material.dart';
import '../../common/routes/Routers.dart';

class AuthenticationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:20.0,vertical:100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      'MESAN', style: TextStyle(
                        fontSize: 72.0,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      'Ordering become easier', style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                      width: double.infinity,
                        child: FlatButton(
                        onPressed: (){
                          Navigator.pushNamed(context, loginRoute);
                        },   
                        child: Text('LOGIN', style:TextStyle(fontWeight: FontWeight.bold)),
                        color: Colors.red,
                        textColor: Colors.white,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top:30.0),
                      child: SizedBox(
                        height: 50.0,
                        width: double.infinity,
                          child: FlatButton(
                          onPressed: (){
                            Navigator.pushNamed(context, registerRoute);
                          },   
                          child: Text('REGISTER'),
                          color: Colors.red,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}