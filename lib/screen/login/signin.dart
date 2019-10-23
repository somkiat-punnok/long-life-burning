part of login;

@immutable
class SignInPage extends StatefulWidget {

  final NavBarProvider provider;

  SignInPage({
    Key key,
    this.provider,
  }) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  UserProvider userProvider;
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
        await Configs.auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((result) async {
            if (result != null && result.user != null) {
              Configs.login = true;
              await checkAuth(userProvider, result.user)
                .then((_) => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => Index(),
                  ),
                ));
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
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Long Life Burning ",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            color: Colors.white,
            onPressed: () {
              widget.provider.reset();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => Index(),
                )
              );
            },
          ),
        ],
      ),
       body: Container(
        decoration: BoxDecoration(
          color: Colors.black38,
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.dstATop,
          ),
            image: AssetImage(SIGNINIMAGE),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
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
        )
      ),
    );
  }

  RaisedButton buildButtonSignIn() {
    return RaisedButton(
       shape: RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(30.0)),
      color: Colors.green.withOpacity(.8),
      child: Text(
        "Log in",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
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
         keyboardType: TextInputType.emailAddress,
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