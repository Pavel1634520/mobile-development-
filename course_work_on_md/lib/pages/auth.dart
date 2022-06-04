import 'package:course_work_on_md/domain/authuser.dart';
import 'package:course_work_on_md/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  bool showLogin = true;

   AuthService _authService= AuthService();

  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Padding(
        padding: EdgeInsets.only(top: 100),
        child: Container(
          child: Column(
            children: [
              Align(
                child: Text(
                  "CoolRep",
                  style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                child: Text(
                  "Рецепты для всех",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      );
    }

    Widget _input(Icon icon, String hint, TextEditingController controller,
        bool obscure) {
      return  Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: controller,
            obscureText: obscure,
            style: TextStyle(fontSize: 20, color: Colors.white),
            decoration: InputDecoration(
                hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 20,
                    color: Colors.white38),
                hintText: hint,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 2)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54, width: 2)),
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: IconTheme(
                    child: icon,
                    data: IconThemeData(color: Colors.white),
                  ),
                )),
          ),

      );
    }

    Widget _button(String text, void Function() func) {
      return RaisedButton(
          splashColor: Theme
              .of(context)
              .primaryColor,
          highlightColor: Theme
              .of(context)
              .primaryColor,
          color: Colors.white,
          onPressed: func,
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme
                    .of(context)
                    .primaryColor,
                fontSize: 20),
          ));
    }

    Widget _form(String label, void Function() func) {
      return Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 20, top: 10),
                child: _input(Icon(Icons.email_outlined), "Введите почту",
                    _emailController, false),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: _input(Icon(Icons.lock_outline), "Введите пароль",
                    _passwordController, true),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 50,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: _button(label, func),
                ),
              ),
            ],
          ));
    }

    void _loginButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      AuthUser? user = await _authService.signInWithEmailAndPassword(_email.trim(), _password.trim());
      if(user==null){
        Fluttertoast.showToast(
            msg: "Не удалось войти! Пожалуйста, проверьте ваш email(не используйте сочететания типа qwerty@mail...)/пароль(должен быть >=6 символов)!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else {
        _emailController.clear();
        _passwordController.clear();
      }
    }

    void _registerButtonAction() async{
      _email = _emailController.text;
      _password = _passwordController.text;

      if(_email.isEmpty || _password.isEmpty) return;

      AuthUser? user = await _authService.registerWithEmailAndPassword(_email.trim(), _password.trim());
      if(user==null){
        Fluttertoast.showToast(
            msg: "Не удалось зарегистрироваться! Пожалуйста, проверьте ваш email (не используйте сочететания типа qwerty@mail...)/пароль(должен быть >=6 символов)!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }else {
        _emailController.clear();
        _passwordController.clear();
      }
    }



    return  Scaffold(
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              _logo(),
              (
                  showLogin ? Column(children: [

                    _form("ВОЙТИ", _loginButtonAction),
                    Padding(padding: EdgeInsets.all(15),
                      child: GestureDetector(
                        child: Text("Нет аккаунта? Зарегистрируйтесь!",
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                        onTap: (){
                          setState(() {
                            showLogin = false;
                          });
                        },
                      ),

                    )
                  ],
                  ):
                  Column(children: [
                    _form("ЗАРЕГИСТИРОВАТЬСЯ", _registerButtonAction),
                    Padding(padding: EdgeInsets.all(15),
                      child: GestureDetector(
                        child: Text("Уже есть аккаунт? Войдите!",
                          style: TextStyle(fontSize: 20,color: Colors.white),
                        ),
                        onTap: (){
                          setState(() {
                            showLogin = true;
                          });
                        },
                      ),

                    )
                  ],
                  )
              )

            ],
          ),
        ),
      
    );
  }
}
