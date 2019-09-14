part of login;

@immutable
class SignInPage extends StatefulWidget {
  
  SignInPage({
    Key key,
  }) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _email;
  String _password;

  
  @override
  void initState() { 
    super.initState();
    fromKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    if (fromKey.currentState != null) {
      fromKey.currentState.dispose();
    }
    super.dispose();
  }
  
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
        await UserOptions.auth.signInWithEmailAndPassword(email: _email, password: _password).then((result) {
          if (result != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Index(),
              ),
            );
          }
        });
      } catch (e) {
        print('Error : $e');
      }
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      key: scaffoldKey,
=======
>>>>>>> master
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
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
        decoration: BoxDecoration(
          color: Colors.blueGrey[200],
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.1),
            BlendMode.dstATop,
          ),
            image: AssetImage(SIGNINIMAGE),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Colors.grey[300],
                  Colors.blue[300],
                ]
              )
            ),
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
                  buildButtonSignIn(),
                ],
              ),
            ),            
          ),        
        ),
      ),
    );
  }
 
  RaisedButton buildButtonSignIn() {
    return RaisedButton(
      child: Text(
        "Log in",
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
  
  
  Container buildTextFieldEmail() {
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

  Container buildTextFieldPassword() {
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
    //  catchError((error) {
    //   print(error.message);
    //   scaffoldKey.currentState.showSnackBar(SnackBar(
    //     content: Text(error.message, style: TextStyle(color: Colors.white)
    //     ),
    //     backgroundColor: Colors.red,
    //    )
    //   );
    //  }
  //  );
}