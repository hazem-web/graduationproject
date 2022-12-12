import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduationproject/Authentication/Screens/register_screen.dart';
import 'package:provider/provider.dart';

import '../Provider/auth_provider.dart';

class  LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Sign in",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
              const Text("Welcome Back",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
              const SizedBox(height: 20,),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                validator: (value) {
                  if(value!.isEmpty || !value.contains("@")){
                    return "Please enter your email";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: const Text('Email',),
                  prefixIcon: const Icon(Icons.email,color: Colors.grey,),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey,style: BorderStyle.solid)
                  ),
                  border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey,style: BorderStyle.solid)
                  ),

                ),
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _password,
                obscureText:Provider.of<AuthProvider>(context).obscure ,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if(value!.isEmpty || value.length < 3){
                    return "Please enter your password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  label: const Text('Password',),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey,style: BorderStyle.solid)
                  ),
                  border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.grey,style: BorderStyle.solid)
                  ),
                  prefixIcon: const Icon(Icons.lock,color: Colors.grey,),
                  suffixIcon: IconButton(icon: const Icon(Icons.remove_red_eye),onPressed: () {
                    Provider.of<AuthProvider>(context,listen: false).password();
                  },),
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                     Provider.of<AuthProvider>(context,listen: false).login(email: _email.text, password: _password.text,context: context);
                    }
                  },
                  style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.teal)),
                  child: const Text('Sign in',style: TextStyle(fontSize: 20),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account?',),
                  TextButton(
                    onPressed: () {
                      Get.to(RegisterScreen());
                    },
                    child: const Text('Sign Up',style: TextStyle(color: Colors.teal),),
                  ),
                ],
              ),
              // Sign in with google logo
              const SizedBox(height: 40,),
              GestureDetector(
                  onTap: (){
                   Provider.of<AuthProvider>(context,listen: false).googleSign();
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          //color: Themes.isDarkMode(context)?Colors.grey:Colors.black12,
                          color: Colors.white,
                          blurRadius: 2,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/google.png',height: 20,),
                        const SizedBox(width: 10,),
                        const Text('Sign in with Google',),
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}