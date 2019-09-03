import 'package:flutter/material.dart';
import 'package:long_life_burning/screen/index.dart';
import 'package:long_life_burning/utils/helper/constants.dart'

  show
    Constants,
    SizeConfig;

class SignUpPage extends StatelessWidget {
   final fromKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  String _confirmpassword;

  SignUpPage({
    
    Key key,
  }) : super(key: key);
   void validateAndSave(){
    final form = fromKey.currentState;
    if (form.validate()){
      form.save();
      print('Form is valid. Email : $_email, password :$_password');
    }else {
      print('Form is invalid. Email : $_email, password :$_password');    
    }
     
  }

  @override
 Widget build(BuildContext context) {
  
    return Scaffold(    
        appBar: AppBar( 
          title: Text("Long Life Burning App", style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.clear),
                color: Colors.white,
                onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (BuildContext context) => Index(),
                  )
                ),
              ),
            ],
         
        ),
        
        body: Container(
        
            color: Colors.grey[200],
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                          colors: [Colors.grey[300], Colors.blue[300]])),
                  margin: EdgeInsets.all(22),
                  padding: EdgeInsets.all(14),
                   child: Form(
                    key: fromKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[                      
                      buildTextFieldEmail(),
                      buildTextFieldPassword(),
                      buildTextFieldConfirmPassword(),
                      buildButtonSignIn()                                          
                    ],
                  ))),
            )));
  }
  
  

  RaisedButton buildButtonSignIn() {
    return RaisedButton(
        child: Text("sing in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black)),
            onPressed: validateAndSave,
            padding: EdgeInsets.all(12)
            );           
       
          
  }
  
  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.grey[50], borderRadius: BorderRadius.circular(16)),
        child: TextFormField(
            decoration: InputDecoration.collapsed(hintText: "Email"),
            validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
            style: TextStyle(fontSize: 18)));
  }
 
  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.grey[50], borderRadius: BorderRadius.circular(16)),
        child: TextFormField(
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Password"),
            validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
            style: TextStyle(fontSize: 18)));
  }
  Container buildTextFieldConfirmPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.grey[50], borderRadius: BorderRadius.circular(16)),
        child: TextFormField(
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "Confirm Password"),
            validator: (value) => value.isEmpty ? 'Confirm Password can\'t be empty' : null,
            style: TextStyle(fontSize: 18)));
  }
  
}
         