part of login;

enum SingingCharacter { male, female }
SingingCharacter _character = SingingCharacter.male;

@immutable
class SignUpPage extends StatefulWidget {

  final VoidCallback signin;
  
  SignUpPage({
    Key key,
    this.signin,
  }) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  GlobalKey<FormState> fromKey;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmController;
  // TextEditingController hightController = TextEditingController();
  // TextEditingController weightController = TextEditingController();

  String _email;
  String _password;

  @override
  void initState() { 
    super.initState();
    fromKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
  }

  @override
  void dispose() { 
    fromKey.currentState.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  bool validateAndSave(){
    final form = fromKey.currentState;
    if (form.validate()){
      form.save();
      return true;
    }else {
      return false;   
    }
  }

  void validateAndSubmit() {
    if(validateAndSave()){
      try {
        UserOptions.auth.createUserWithEmailAndPassword(email: _email, password: _password).then((result) {
          if (result != null && result.user != null) {
            print('signup result: $result');
            widget.signin();
          }
        });
      } catch (e) {
        print('Error : $e');
      }
    }
  }

  void signUp() {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmController.text.trim();
    if (password == confirmPassword && password.length >= 8) {
      UserOptions.auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((user) {
          print("Sign up user successful.");
        })
        .catchError((error) {
          print(error.message);
        });
    } else {
      print("Password and Confirm-password is not match.");
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
                ],
              ),
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
                  buildTextFieldConfirmPassword(),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        // buildTextFieldHight(),
                        // buildTextFieldWeight(),
                      ],
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Male',
                    ),
                    leading: Radio(
                      value: SingingCharacter.male,
                      groupValue: _character,
                      onChanged: (SingingCharacter value) {
                        setState(() {
                          _character = value; 
                        });
                      }
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Female',
                    ),
                    leading: Radio(
                      value: SingingCharacter.female,
                      groupValue: _character,
                      onChanged: (SingingCharacter value){
                        setState(() {
                          _character = value; 
                        });
                      }
                    ),
                  ),                
                  buildButtonSignup(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.grey[50], borderRadius: BorderRadius.circular(16)),
        child: TextFormField(
          controller: emailController,
            decoration: InputDecoration.collapsed(hintText: "Email"),
            validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
            onSaved: (value) =>_email =value,
            style: TextStyle(fontSize: 18)
              )
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
       controller: passwordController,
        obscureText: true,
        decoration: InputDecoration.collapsed(hintText: "Password"),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) =>_password =value,
        style: TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  Widget buildTextFieldConfirmPassword() {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
       controller: confirmController,
        obscureText: true,
        decoration: InputDecoration.collapsed(hintText: "Confirm Password"),
        validator: (value) => value.isEmpty ? 'Confirm Password can\'t be empty' : null,
        style: TextStyle(
          fontSize: 18,
        ),
      )
    );
  }

// Widget buildTextFieldHight() {
//     return Container(
//       width: 150,
//       padding: EdgeInsets.all(12),
//       margin: EdgeInsets.only(top: 12),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: TextFormField(
//         controller: hightController,
//         decoration: InputDecoration.collapsed(hintText: "Hight"),
//         validator: (value) => value.isEmpty ? 'Hight can\'t be empty' : null,
//         style: TextStyle(
//           fontSize: 18,
//         ),
//       )
//     );
//   }

  
//   Widget buildTextFieldWeight() {
//     return Container(
//       width: 150,
//       padding: EdgeInsets.all(12),
//       margin: EdgeInsets.only(top: 12),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(16),
//       ),
//       child: TextFormField(
//        controller: weightController,
//         decoration: InputDecoration.collapsed(hintText: "Weight"),
//         validator: (value) => value.isEmpty ? 'Weight can\'t be empty' : null,
//         style: TextStyle(
//           fontSize: 18,
//         ),
//       )
//     );
//   }

  
  RaisedButton buildButtonSignup() {
    return RaisedButton(
        child: Text("sign up",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black)),
             onPressed:validateAndSubmit,
            padding: EdgeInsets.all(12)
  );           
  }
}
         