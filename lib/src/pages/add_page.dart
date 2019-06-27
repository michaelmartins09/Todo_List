import 'package:flutter/material.dart';
import 'package:todo_list/src/helper/DataBasePrefs.dart';
import 'package:todo_list/src/model/task.dart';
import 'package:todo_list/src/styles/colors.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController title = TextEditingController();
  TextEditingController subTitle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            gradient: defaultGradiend,
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: IconButton(icon: Icon(Icons.arrow_back), color: defaultColor, onPressed: (){
                    Navigator.pop(context);
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Adicionar tarefa", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ],
            ),
          )
        )
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  controller: title,
                  decoration: InputDecoration(
                    labelText: "Título",
                  ),
                ),

                TextFormField(
                  controller: subTitle,
                  decoration: InputDecoration(
                    labelText: "SubTitulo",
                  ),
                ),

                SizedBox(height: 50),
                
              ],
            ),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: defaultGradiend,
            shape: BoxShape.circle
          ),
          child: Icon(Icons.check),
        ),
        onPressed: () {
          if (title.text.isNotEmpty && subTitle.text.isNotEmpty) {
            DataBasePrefs.db.insertTask(Task(title: title.text, subTitle: subTitle.text, isFinished: false));
            Future.delayed(Duration(milliseconds: 500), (() => Navigator.pop(context)));  
          }
        },
        tooltip: "Finalizar",
      ),
    );
  }
}