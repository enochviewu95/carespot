import 'package:carespot/bloc/login_bloc.dart';
import 'package:carespot/services/authentication.dart';
import 'package:carespot/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String _email = '';
  LoginBloc? _loginBloc;



  void onGoogleSignClick() {
    final auth = AuthenticationService();
    final credentials = auth.signInWithGoogle();
    setState(() {
      _email = credentials.toString();
    });
    // auth.signOut();
  }


  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc(AuthenticationService());
  }


  @override
  void dispose() {
    _loginBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: ComponentColors.primaryColor),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              StreamBuilder(
                stream: _loginBloc?.email,
                builder: (BuildContext context,AsyncSnapshot snapshot)=> TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    icon: const Icon(Icons.mail_outline),
                    errorText: snapshot.error != null ? snapshot.error.toString():'',
                  ),
                  onChanged: _loginBloc?.emailChanged.add,
                ),
              ),
              StreamBuilder(
                stream: _loginBloc?.password,
                builder: (BuildContext context, AsyncSnapshot snapshot)=> TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    icon: const Icon(Icons.security),
                    errorText: snapshot.error != null ? snapshot.error.toString():'',
                  ),
                  onChanged: _loginBloc?.passwordChanged.add,              ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height/20,),
              _buildLoginAndCreateButtons(),
              // Text('This is email $_email'),
              // TextButton.icon(
              //   style: ButtonStyle(
              //     backgroundColor: MaterialStateProperty.all(Colors.blue),
              //     elevation: MaterialStateProperty.all(10.0),
              //   ),
              //   onPressed: () => onGoogleSignClick(),
              //   label: const Padding(
              //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              //     child: Text(
              //       'Sign In with google',
              //       style: TextStyle(fontSize: 20, color: Colors.white),
              //     ),
              //   ),
              //   icon: Image.asset(
              //     'assets/images/google.png',
              //     width: 30.0,
              //   ),
              // )
            ],
          ),
        )
      )),
    );
  }

  Widget _buildLoginAndCreateButtons(){
    return StreamBuilder(
      initialData: 'Login',
      stream: _loginBloc?.loginOrCreateButton,
      builder: ((BuildContext context,AsyncSnapshot snapshot){
        if(snapshot.data == 'Login'){
          return _buttonsLogin();
        }else if(snapshot.data == 'Create Account'){
          return _buttonsCreateAccount();
        }else{
          return Container();
        }
      }),
    );
  }

  Column _buttonsLogin(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StreamBuilder(
          initialData: false,
          stream: _loginBloc?.enableLoginCreateButton,
          builder: (BuildContext context,AsyncSnapshot snapshot)=>
            ElevatedButton(
                child: const Text('Login'),
                onPressed: snapshot.data
              ? () => _loginBloc?.loginOrCreateChanged.add('Login')
              :null,
              style: ElevatedButton.styleFrom(
                primary: Colors.lightGreen.shade200,
                elevation: 16.0,
                onSurface: Colors.grey.shade100,
              ),
              ),
            ),
        TextButton(
          child: const Text('Create Account'),
          onPressed: (){
            _loginBloc?.loginOrCreateButtonChanged.add('Create Account');
          },
        )
      ],
    );
  }

  Column _buttonsCreateAccount(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        StreamBuilder(
          initialData: false,
          stream: _loginBloc?.enableLoginCreateButton,
          builder: (BuildContext context, AsyncSnapshot snapshot)=>
            ElevatedButton(
              child: const Text('Create Account'),
              onPressed: snapshot.data
              ? ()=> _loginBloc?.loginOrCreateChanged.add('Create Account'):null,
              style: ElevatedButton.styleFrom(
                elevation: 16.0,
                primary: Colors.lightGreen.shade200,
                onSurface: Colors.grey.shade100,
              ),
            ),
        )
      ],
    );
  }
}
