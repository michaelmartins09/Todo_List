import 'package:flutter/material.dart';
import 'package:todo_list/src/helper/DataBasePrefs.dart';
import 'package:todo_list/src/model/task.dart';
import 'package:todo_list/src/styles/colors.dart';

import 'add_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int qntTask;

  @override
  void initState() {
    qntTask = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.20),
        child: Container(
          decoration: BoxDecoration(
            gradient: defaultGradiend,
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Lista de tarefas", style: TextStyle(color: Colors.white, fontSize: 34)),
                ),
              ),
              Divider(),
              Row(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Icon(Icons.list, color: Colors.white),
                    ),
                  ),
                  Text(qntTask.toString(), style: TextStyle(color: Colors.white, fontSize: 18))
                ],
              )
            ],
          )
        )
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: FutureBuilder<List<Task>>(
              future: DataBasePrefs.db.tasks(),
              builder: (BuildContext context, AsyncSnapshot<List<Task>> tasks){
                if (tasks.data != null && tasks.data.length == 0) {
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.list, color: Colors.grey, size: 200,),
                        SizedBox(width: 50),
                        Text("Você ainda não possui tarefas", style: TextStyle(color: Colors.grey, fontSize: 30), textAlign: TextAlign.center,),
                      ],
                    ),
                  );
                }else if (tasks.data == null){
                  return Center(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.list, color: Colors.grey, size: 200),
                        SizedBox(width: 50),
                        Text("Preparando Banco de Dados", style: TextStyle(color: Colors.grey, fontSize: 30), textAlign: TextAlign.center,),
                      ],
                    ),
                  );
                }else{
                  qntTask = tasks.data.length;
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: tasks.data.length,
                    itemBuilder: (context, index){
                      return Card(
                        elevation: 3,
                        color: Colors.white,
                        child: Container(
                          width: double.maxFinite,
                          child: ListTile(
                            dense: true,
                            leading: Container(
                              decoration: BoxDecoration(
                                color: defaultBackground,
                                borderRadius: BorderRadius.circular(3)
                              ),
                              width: 5,
                            ),
                            title: Text(tasks.data[index].title, style: TextStyle(color: defaultBackground, fontWeight: FontWeight.bold)),
                            subtitle: Text(tasks.data[index].subTitle, style: TextStyle(color: Colors.grey)),
                            trailing: IconButton(icon: Icon(Icons.check), color: defaultBackground, onPressed: (){
                              showDeleteTask(tasks.data[index], context);
                            }),
                          ),
                        ),
                      ); 
                    },
                  );
                }
              },
            )
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: defaultGradiend,
            shape: BoxShape.circle
          ),
          child: Icon(Icons.add),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddPage()
          ));
        },
        tooltip: "Adicionar Tarefa",
      ),
    );
  }

  showDeleteTask(Task task, BuildContext context){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          backgroundColor: Colors.white,
          title: Card(
            margin: EdgeInsets.all(0),
            color: Colors.deepPurple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    shape: BoxShape.circle
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Icon(Icons.check, size: 35, color: Colors.white,),
                ),
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(child: Text("Finalizar Tarefa?", style: TextStyle(color: Colors.deepPurple))),
            )
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text("Não", style: TextStyle(color: Colors.deepPurple)),
            ),
            RaisedButton(
              onPressed: (){
                DataBasePrefs.db.deleteTask(task.id);
                setState(() {});
                Navigator.pop(context);
              },
              color: Colors.deepPurple,
              child: Text("Sim", style: TextStyle(color: Colors.white)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              ),
            )
          ],
        );
      }
    );
  }

}