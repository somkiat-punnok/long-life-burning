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

  GlobalKey<FormState> fromKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  TextEditingController emailController;
  TextEditingController passwordController;
  
  @override
  void initState() { 
    super.initState();
    fromKey = GlobalKey<FormState>();
    scaffoldKey = GlobalKey<ScaffoldState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    if (fromKey.currentState != null) {
      fromKey.currentState.dispose();
    }
    if (scaffoldKey.currentState != null) {
      scaffoldKey.currentState.dispose();
    }
    emailController.dispose();
    passwordController.dispose();
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
  
  Future<void> signIn() async {
    if (validateAndSave()) {
      try {
        String email = emailController.text.trim();
        String password = passwordController.text.trim();
        await Configs.auth.signInWithEmailAndPassword(email: email, password: password).then((result) async {
          if (result != null && result.user != null) {
            await Configs.store
              .collection(UserOptions.collection)
              .where(
                UserOptions.uid_field,
                isEqualTo: result.user.uid,
              )
              .snapshots()
              .listen((data) {
                if (data.documents.isNotEmpty) {
                  UserOptions.name = data.documents[0].data[UserOptions.name_field];
                  UserOptions.weight = data.documents[0].data[UserOptions.weight_field];
                  UserOptions.height = data.documents[0].data[UserOptions.height_field];
                  UserOptions.dateOfBirth = DateTime.fromMicrosecondsSinceEpoch(data.documents[0].data[UserOptions.dateOfBirth_field].microsecondsSinceEpoch);
                  UserOptions.gender = data.documents[0].data[UserOptions.gender_field].toLowerCase() != 'female' ? Gender.MALE : Gender.FEMALE;
                }
              });
            UserOptions.user = result.user;
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Index(),
              ),
            );
          }
        })
        .catchError((err) {
          print('Error: ${err.message}');
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text(
              err.message,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.red,
          ));
        });
      } catch (e) {
        print('Error: $e');
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
        "Sign in",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
      onPressed: () async => await signIn(),
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
        controller: emailController,
        decoration: InputDecoration.collapsed(hintText: "Email"),
        style: TextStyle(
          fontSize: 18,
        ),
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
        controller: passwordController,
        obscureText: true,
        decoration: InputDecoration.collapsed(hintText: "Password"),
        style: TextStyle(
          fontSize: 18,
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
      ),
    );
  }

}