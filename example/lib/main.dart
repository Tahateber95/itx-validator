
import 'package:flutter/material.dart';
import 'package:itx_validator/itx_validator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Itx Validator Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Itx Validator Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 Map<String, dynamic> form = {};

  Map<dynamic, dynamic> errors = {};

  ItxSchema formSchema = ItxSchema.structure(
    {
      "email": ItxValidator<String>()
      .required(message: 'Email is required')
      .email(message: 'Email is invalid'),
      "password":
          ItxValidator<String>().required(
            message: "Password is required"
          ),
      "age": ItxValidator<num>().required(
        message: "Age is required"
      ),
    },
  );


  void validate() {
    try {
      final res = formSchema.validate(form);
      setState(() {
        errors = res.$2;
      });
    } catch (e) {
      print(e);
    }
  }

   _onValueChange(String name, dynamic value) {
    form[name] = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body:  Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                color: Colors.black12,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        onChanged: (value) => _onValueChange('email', value),
                      ),
                        ErrorWIdget(name: errors['email']),
                      const SizedBox(height: 10.0),
                      TextField(
                        onChanged: (value) => _onValueChange('password', value),

                      ),
                       ErrorWIdget(name: errors['password']),
                      const SizedBox(height: 10.0),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => _onValueChange('age', int.tryParse(value) ),
                      ),
                       ErrorWIdget(name: errors['age']),
                      const SizedBox(height: 10.0),
                      MaterialButton(
                        onPressed: validate,
                        color: Colors.white,
                        highlightColor: Colors.red,
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
}



class ErrorWIdget extends StatelessWidget {
  final String? name;

   const ErrorWIdget({this.name, super.key});
  @override
  Widget build(BuildContext context) {
    return name == null || name!.isEmpty
        ? const SizedBox.shrink()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 7.0),
              Row(
                children: [
                  const Icon(Icons.error_outline,
                      size: 14.0, color: Colors.red),
                  const SizedBox(width: 3.0),
                  Flexible(
                    child: Text(
                      name as String,
                      style: const TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                  )
                ],
              )
            ],
          );
  }
}

