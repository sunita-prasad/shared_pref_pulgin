import 'package:flutter/material.dart';
import 'package:shared_pref/shared_pref.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              /** String Value **/
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      SharedPref pref = await SharedPref.getInstance();
                      print(await pref.setString("name", "Sunita"));
                    },
                    child: const Text("Set String"),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPref pref = await SharedPref.getInstance();
                      print("String : ${pref.getString("name")}");
                    },
                    child: const Text("Get String"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              /** Integer Value **/
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      SharedPref pref = await SharedPref.getInstance();
                      print(await pref.setInt("number", 123456789));
                    },
                    child: const Text("Set Integer"),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPref pref = await SharedPref.getInstance();
                      print("Integer : ${pref.getInt("number")}");
                    },
                    child: const Text("Get Integer"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              /** Boolean Value **/
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      SharedPref pref = await SharedPref.getInstance();
                      print(await pref.setBool("developer", true));
                    },
                    child: const Text("Set Boolean"),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPref pref = await SharedPref.getInstance();
                      print("Boolean : ${pref.getBool("developer")}");
                    },
                    child: const Text("Get Boolean"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              /** Double Value **/
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      SharedPref pref = await SharedPref.getInstance();
                      print(await pref.setDouble("salary", 8000.0));
                    },
                    child: const Text("Set Double"),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      SharedPref pref = await SharedPref.getInstance();

                      print("Double : ${pref.getDouble("salary")}");
                    },
                    child: const Text("Get Double"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
