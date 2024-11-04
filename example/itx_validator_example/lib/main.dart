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
 Map<String, dynamic> form = {
    "email": "",
  // "password": "", // uncomment this line to see the error
    "age": 0,
  };
  Map<dynamic, dynamic> errors = {};

  ItxSchema formSchema = ItxSchema.structure(
    {
      "email": ItxValidator<String>(label: "l'email").required(),
      "password":
          ItxValidator<String>(label: 'le mot de passe').required(),
      "age": ItxValidator<num>(label: 'l\'age').required(),
    },
  );


  void validate() {
    try {
      final res = formSchema.validateSync(form);
      setState(() {
        errors = res.$2;
      });
      print(res.$1);
      errors.forEach((key, value) {
        print('$key ===> $value');
      });
    } catch (e) {
      print(e);
    }
  }

    _onChange(String name, dynamic value) {
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
                        onChanged: (value) => _onChange('email', value),
                      ),
                        ErrorWIdget(name: errors['email']),
                      const SizedBox(height: 10.0),
                      TextField(
                        onChanged: (value) => _onChange('password', value),

                      ),
                      const SizedBox(height: 10.0),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) => _onChange('age', value),
                      ),
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

  const ErrorWIdget({this.name, key}) : super(key: key);
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

