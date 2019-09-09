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

  final GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _email;
  String _password;
  
  @override
  void initState() { 
    super.initState();
    checkAuth(context);
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
      final  AuthResult authResult = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
      final FirebaseUser user = authResult.user;
      user != null;
       Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Index(user: user)),
        );
      print('signin : ${user.uid}');
      } catch (e) {
        print('Error : $e');
      }
    }
  }

  Future checkAuth(BuildContext context)async {
    FirebaseUser user = await _auth.currentUser();
    if (user != null){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Index(user: user,)
          )
        );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
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
            image: AssetImage(Constants.loginImage),
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
     
  
}