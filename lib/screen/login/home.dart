part of login;

class HomePage extends StatelessWidget {

  final VoidCallback signin;
  final VoidCallback signup;

  HomePage({
    Key key,
    this.signin,
    this.signup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      decoration: BoxDecoration(
        color: Colors.lightBlue[50],
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.2),
            BlendMode.dstATop,
          ),
          image: AssetImage(SIGNINIMAGE),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            brightness: Brightness.light,
            elevation: 0.0,
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
          Container(
            padding: EdgeInsets.only(top: 75.0),
            child: Center(
              child: Icon(
                Icons.directions_run,
                color: Colors.blueAccent,
                size: 60.0,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),           
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[              
                Text(
                  "Long Life Burning",
                  style: TextStyle(
                    fontFamily: "Poppins-Bold", 
                    letterSpacing: .6,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30.0,
                    decoration: TextDecoration.none,
                    decorationStyle: TextDecorationStyle.dashed,  
                ),
                ),                
              ],
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 150.0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)
                    ),
                    color: Colors.blueAccent.withOpacity(.9),                    
                    onPressed: signup ?? () => print('signup'),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "SIGN UP",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: SizeConfig.screenWidth,
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.green.withOpacity(.8),
                    onPressed: signin ?? () => print('login'),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "LOGIN",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
}
