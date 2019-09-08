part of login;

@immutable
class SignInPage extends StatelessWidget {

  SignInPage({
    Key key,
  }) : super(key: key);
  
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  String _email = "";
  String _password = "";
  
  bool validateAndSave(){
    final form = fromKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    }else{
      return false;
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        final  AuthResult authResult = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email,password: _password);
        final FirebaseUser user = authResult.user;
        print('signin : ${user.uid}');
      } catch (e) {
        print('Error : $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Long Life Burning App",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
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
        color: Colors.blueGrey[200],
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              // image: DecorationImage(
              // image: AssetImage("lib/image/fabio-comparelli-uq2E2V4LhCY-unsplash.jpg"),
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Colors.grey[300],
                  Colors.blue[300],
                ]
              )
            ),
            margin: EdgeInsets.all(40),
            padding: EdgeInsets.all(30),
            child: Form(
              key: fromKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildTextFieldEmail(),
                  buildTextFieldPassword(),
                  buildButtonSignIn(),
                ],
              ),
            ),            
          ),        
        ),
      ),
    );
  }
 
  Widget buildButtonSignIn() {
    return RaisedButton(
      child: Text("Log in",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      onPressed: validateAndSubmit,
      padding: EdgeInsets.all(12),
    );
  }
  
  Widget buildTextFieldEmail() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        decoration: InputDecoration.collapsed(hintText: "Email"),
        style: TextStyle(
          fontSize: 18,
        ),
        onSaved: (value) => _email = value,
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
      ),
    );
  }

  Widget buildTextFieldPassword() {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration.collapsed(hintText: "Password"),
        style: TextStyle(
          fontSize: 18,
        ),
        onSaved: (value) => _password = value,
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      ),
    );
  }
  
}