import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.red, // Change the color here
        ),
      ),
      home: const MyHomePage(),
    );
  }
}
#hafeez code from github
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var weightcontroler = TextEditingController();
  var feetcontroler = TextEditingController();
  var inchcontroler = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var result;
  var sms = "";
  var photopath = "assets/image/photo.png";
  //for meter
  var _w = 20.0;
  final _h = 20.0;
  bool flag = true;
  var them = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BMI Tester",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: 370,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),
              const Text(
                "Body Mass Index made by AHT",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: weightcontroler,
                decoration: const InputDecoration(
                    label: Text("Enter Your Weight (in KG)"),
                    prefixIcon: Icon(Icons.line_weight),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: feetcontroler,
                decoration: const InputDecoration(
                    label: Text("Enter Your Height in (feet)"),
                    prefixIcon: Icon(Icons.height),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: inchcontroler,
                decoration: const InputDecoration(
                    label: Text("Enter Remaning inches"),
                    prefixIcon: Icon(Icons.height),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  var weight = weightcontroler.text.toString();
                  var feet = feetcontroler.text.toString();
                  var inches = inchcontroler.text.toString();
                  if (weight != "" && feet != "" && inches != "") {
                    var intweight = int.parse(weight);
                    var intfeet = int.parse(feet);
                    var intinches = int.parse(inches);

                    var totalInch = (intfeet * 12) + intinches;
                    var totalCm = totalInch * 2.54;
                    var totalMeter = totalCm / 100;
                    var bmi = intweight / (totalMeter * totalMeter);
                    if (bmi > 30 && bmi < 35) {
                      sms = "You Are Obese Fat";
                      photopath = "assets/image/photo1.png";
                      them = Colors.orange;
                      _w = bmi * 6;
                    } else if (bmi >= 35) {
                      sms = "You Are Extreme Obese";
                      photopath = "assets/image/photo1.png";
                      them = Colors.red;
                      _w = bmi * 6;
                    } else if (bmi >= 25 && bmi <= 30) {
                      sms = "You Are OverWeight";
                      photopath = "assets/image/photo4.png";
                      them = Colors.yellow;
                      _w = bmi * 6;
                    } else if (bmi < 18.5) {
                      sms = "You Are UnderWeight";
                      photopath = "assets/image/photo2.png";
                      them = Colors.blue;
                      _w = bmi * 6;
                    } else {
                      sms = "You Are Healthy";
                      photopath = "assets/image/photo3.png";
                      them = Colors.green;
                      _w = bmi * 6;
                    }
                    //  print(sms);
                    setState(() {
                      result = "BMI = ${bmi.toStringAsFixed(2)}";
                    });
                  } else {
                    setState(() {
                      result = "Fill All field";
                    });
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text(
                  "Calculate",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 5),
              AnimatedContainer(
                alignment: Alignment.center,
                width: _w,
                height: _h,
                color: them,
                curve: Curves.fastEaseInToSlowEaseOut,
                duration: const Duration(seconds: 2),
                child: Text(
                  result ?? " ",
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
              const SizedBox(height: 5),
              Text(sms),
              const SizedBox(height: 5),
              CircleAvatar(
                backgroundImage: AssetImage(photopath),
                radius: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
