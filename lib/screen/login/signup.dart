part of login;

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

  DateTime _date = DateTime(2000, 1, 1);
  Gender _gender = Gender.MALE;
  GlobalKey<FormState> fromKey;
  TextEditingController emailController;
  TextEditingController passwordController;
  TextEditingController confirmController;
  TextEditingController heightController;
  TextEditingController weightController;
  TextEditingController birthController;
  TextEditingController genderController;

  @override
  void initState() { 
    super.initState();
    fromKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmController = TextEditingController();
    heightController = TextEditingController();
    weightController = TextEditingController();
    genderController= TextEditingController();
  }

  @override
  void dispose() { 
    if (fromKey.currentState != null) {
      fromKey.currentState.dispose();
    }
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    heightController.dispose();
    weightController.dispose();
    genderController.dispose();
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

  Future<void> signUp() async {
    if (validateAndSave()) {
      try {
        String gender;
        String email = emailController.text.trim();
        String password = passwordController.text.trim();
        String confirmPassword = confirmController.text.trim();
        num height = num.parse(heightController.text.trim());
        num weight = num.parse(weightController.text.trim());
        if (_gender == Gender.MALE ) {
          gender = 'male'; 
        }
        else if (_gender == Gender.FEMALE) {
          gender = 'female'; 
        }
        if (password == confirmPassword && password.length >= 8) {
          await Configs.auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((result) async {
              if (result != null && result.user != null) {
                await Configs.store
                  .collection(UserOptions.collection)
                  .add({
                    UserOptions.uid_field: result.user.uid,
                    UserOptions.name_field: 'Anonymus',
                    UserOptions.height_field: height,
                    UserOptions.weight_field: weight,
                    UserOptions.dateOfBirth_field: _date,
                    UserOptions.gender_field: gender,
                  })
                  .then((ref) {
                    if (ref != null && ref.documentID.isNotEmpty) {
                      widget.signin();
                    }
                  });
              }
            });
        } else {
          print("Password and Confirm-password is not match.");
        }
      } catch (e) {
        print('Error : $e');
      }
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
                        buildTextFieldHeight(),
                        buildTextFieldWeight(),
                      ],
                    ),
                  ),
                  buildTextFieldBirth(),
              
                  ListTile(
                    title: Text(
                      'Male',
                    ),
                    leading: Radio(
                      value: Gender.MALE,
                      groupValue: _gender,
                      onChanged: (Gender value) {
                        setState(() {
                          _gender = value; 
                        });
                      }
                    ),
                  ),
                  ListTile(
                    title: Text(
                      'Female',
                    ),
                    leading: Radio(
                      value: Gender.FEMALE,
                      groupValue: _gender,
                      onChanged: (Gender value){
                        setState(() {
                          _gender = value; 
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

Widget buildTextFieldHeight() {
    return Container(
      width: 150,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        controller: heightController,
        decoration: InputDecoration.collapsed(hintText: "Height"),
        validator: (value) => value.isEmpty ? 'Height can\'t be empty' : null,
        style: TextStyle(
          fontSize: 18,
        ),
      )
    );
  }

  
  Widget buildTextFieldWeight() {
    return Container(
      width: 150,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
       controller: weightController,
        decoration: InputDecoration.collapsed(hintText: "Weight"),
        validator: (value) => value.isEmpty ? 'Weight can\'t be empty' : null,
        style: TextStyle(
          fontSize: 18,
        ),
      )
    );
  }

   Widget buildTextFieldBirth() {
    return Container(
       padding: EdgeInsets.all(12),
       margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.grey[50], borderRadius: BorderRadius.circular(16)),
      child: GestureDetector(
        onTap: () async => await showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => _buildBottomPicker(
            CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: _date,
              maximumYear: DateTime.now().year - 1,
              onDateTimeChanged: (DateTime t) {
                setState(() {
                  _date = t;
                });
              },
            ),
            title: 'Date of Birth',
            context: context,
          ),
        ),
        child: Container(
          alignment: AlignmentDirectional.center,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SafeArea(
              child: Text(
                DateFormat.yMMMMd().format(_date),
                style: TextStyle(
                  fontSize: 18,
                  color: CupertinoColors.inactiveGray,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  RaisedButton buildButtonSignup() {
    return RaisedButton(
      child: Text("sign up",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18, color: Colors.black)),
      onPressed: () async => await signUp(),
      padding: EdgeInsets.all(12)
    );           
  }

  Widget _buildBottomPicker(Widget picker, {String title, BuildContext context}) {
    return Container(
      height: SizeConfig.setHeight(268.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18.0),
          topRight: Radius.circular(18.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: DefaultTextStyle(
              style: TextStyle(
                color: CupertinoColors.inactiveGray,
                fontSize: 18.0,
              ),
              child: Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(
                  top: 18.0,
                  left: 24.0,
                  right: 24.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(title),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: CupertinoColors.activeBlue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: DefaultTextStyle(
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
              ),
              child: GestureDetector(
                onTap: () { },
                child: SafeArea(
                  child: picker,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
         