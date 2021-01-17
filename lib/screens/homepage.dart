import 'package:flutter/material.dart';
import '../folmulae/armstrong.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Controller to handle values from text field
  TextEditingController numController = new TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Final Output method resultString whose output is further shown in alert box
  String resultString() {
    int parsed = int.parse(numController.text);
    int temp1 = parsed;
    int temp2 = parsed;
    bool res = ArmstrongNumbers.isArmstrongNumber(parsed);
    bool res1, res2;
    String elseResult = "";
    if (res == true) {
      return "${numController.text} is an Armstrong Number ";
    } else {
      elseResult = elseResult + "$parsed is not an Armstrong Number\n";
      while (temp1 > 0) {
        res1 = ArmstrongNumbers.isArmstrongNumber(temp1);
        if (res1 == true) {
          elseResult =
              elseResult + "Armstrong Numbers:-\n" + "Previous - $temp1 \n";
          break;
        }
        temp1--;
      }
      while (temp2 >= parsed) {
        res2 = ArmstrongNumbers.isArmstrongNumber(temp2);
        if (res2 == true) {
          elseResult = elseResult + "Next - $temp2";
          break;
        }
        temp2++;
      }
      return elseResult;
    }
  }

// Alert Box for final output
  showAlertDialog(BuildContext context) {
    //button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    //AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Answer"),
      content: Text("${resultString()}"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: new EdgeInsets.all(60.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //Text Field for user input
              TextFormField(
                validator: (s) {
                  if (s.isEmpty) {
                    return "Please enter any number";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                controller: numController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  hintText: 'Please enter a number...',
                  hintStyle: TextStyle(color: Colors.grey),
                  filled: true,
                ),
              ),
              // Button to perform armstrong check operation..by calling alert box dialog
              Container(
                margin: EdgeInsets.all(25),
                child: FlatButton(
                  child: Text(
                    'Check',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  onPressed: () {
                    if (formKey.currentState.validate()) {
                      showAlertDialog(context);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
