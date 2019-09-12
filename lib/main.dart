import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: new Home(), debugShowCheckedModeBanner: false));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();

  String _infoText = "Informe seus dados!";

  void _resetField(){
    setState(() {
      _weightController.clear();
      _heightController.clear();
      _infoText = "Informe seus dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate(){
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text) / 100;

    double imc = (weight / (height * height));

    setState(() {
      if(imc < 18.6){
        _infoText = "Abaixo do Peso (${imc.toStringAsPrecision(3)})";
      } else if(imc < 24.9){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(3)})";
      } else if(imc < 29.9){
        _infoText = "Levemente acima do peso (${imc.toStringAsPrecision(3)})";
      } else if(imc < 34.9){
        _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
      } else if(imc < 39.9){
        _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
      } else if(imc > 40.0){
        _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBarWidget(),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                buildIcon(),
                Padding(
                    padding: EdgeInsets.only(top: 7.0),
                    child: buildTextFields("Peso (Kg)", _weightController)),
                Padding(
                    padding: EdgeInsets.only(top: 7.0),
                    child: buildTextFields("Altura (cm)", _heightController)),
                Padding(
                  padding: EdgeInsets.only(top: 7.0),
                  child: buildButton(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7.0),
                  child: buildResult(_infoText),
                ),
              ],
            ),
          )
        ));
  }

  AppBar buildAppBarWidget() {
    return AppBar(
      title: Text("Calculadora de IMC 1.1"),
      centerTitle: true,
      backgroundColor: Colors.teal,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            _resetField();
          },
        )
      ],
    );
  }

  Icon buildIcon() {
    return Icon(Icons.person_outline, size: 120.0, color: Colors.teal);
  }

  TextFormField buildTextFields(String label, TextEditingController controller) {
    return TextFormField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.teal, fontSize: 18.0),
      decoration: InputDecoration(
          labelText: label, labelStyle: TextStyle(color: Colors.teal)),
      controller: controller,
      validator: (value) {
        if(value.isEmpty){
          return "preencha o campo corretamente!";
        }
      },
    );
  }

  RaisedButton buildButton() {
    return RaisedButton(
      child: Text("Calcular",
          style: TextStyle(color: Colors.white, fontSize: 18.0)),
      color: Colors.teal,
      padding: new EdgeInsets.all(7.0),
      onPressed: () {
        if(_formKey.currentState.validate()){
          _calculate();
        }
      },
    );
  }

  Text buildResult(String infoText) {
    return Text(
      infoText,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.teal, fontSize: 16.0, fontWeight: FontWeight.bold),
    );
  }
}
