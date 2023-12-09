import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Your BMI'),
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
  int _counter = 0;
  var weightController = TextEditingController();
  var feetController = TextEditingController();
  var inchController = TextEditingController();
  var result = "";
  var shouldShowMessageAsError = false;
  var backgroundColor = Colors.indigo.shade50;
  var resultMessage = "";

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(widget.title, style: TextStyle(color: Colors.white),),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color(0xffc2e90b),
                Color(0xffa1c49d),
              ],
              center: Alignment.bottomLeft,
              // stops: [0.3, 0.5],
            )
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Text('BMI', style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
                ),
                TextField(
                  controller: weightController,
                  decoration: InputDecoration(
                    label: Text('Enter you wieght*'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.line_weight_sharp),
                    errorText: shouldShowMessageAsError ? "Please enter the wieght." : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: feetController,
                  decoration: InputDecoration(
                    label: Text('Enter your height(in feet)*'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.height_sharp),
                    errorText: shouldShowMessageAsError ? "Please enter the height in feet." : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: inchController,
                  decoration: InputDecoration(
                    label: Text('Enter your height(in inches)*'),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.height_sharp),
                    errorText: shouldShowMessageAsError ? "Please enter the height in inch." : null,
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: (){
                      var weightValue = weightController.text.toString();
                      var feetValue = feetController.text.toString();
                      var inchValue = inchController.text.toString();
                      if(weightValue!="" && feetValue!="" &&  inchValue!=""){
                        result = "";
                        var heightInInches = (int.parse(feetValue) * 12) + int.parse(inchValue);
                        var heightInMeter = heightInInches * 0.0254;
                        var bmiValue = int.parse(weightValue)/(heightInMeter * heightInMeter).roundToDouble();
                        result = "Your BMI is ${bmiValue.toStringAsFixed(2)}";
                        shouldShowMessageAsError = false;
                        if(bmiValue > 25){
                          resultMessage = "You are OverWeight!!";
                          backgroundColor = Colors.orange.shade200;
                        }else if(bmiValue < 18){
                          resultMessage = "You are UnderWeight!!";
                          backgroundColor = Colors.red.shade200;
                        }else{
                          resultMessage = "You are Healthy!!";
                          backgroundColor = Colors.green.shade200;
                        }
                        setState(() {

                        });
                      }else{
                        result = "";
                        shouldShowMessageAsError = true;
                        setState(() {

                        });
                      }
                    },
                    child: Text('Calculate')
                ),
                SizedBox(
                  height: 15,
                ),
                Text(result,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(resultMessage,
                  style: TextStyle(
                      fontSize: 15
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
