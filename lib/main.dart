import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
      brightness:Brightness.light,
      primaryColor: Colors.blue,
      accentColor: Colors.cyan,
  ),
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String studentName, studentID, studyProgramID;
  double studentGPA;

  getStudentName(name){
    this.studentName = name;
  }

  getStudentID(id){
    this.studentID = id;
  }

  getStudyProgramID(programId){
    this.studyProgramID = programId;
  }
  getProgramGpa(gpa){
    this.studentGPA = double.parse(gpa);
  }
  createData(){
    DocumentReference documentReference = Firestore.instance.collection("students").document(studentName);

    //create map
    Map<String,dynamic> student = {
      'student name':studentName,
      'program id':studyProgramID,
      'student id':studentID,
      'gpa':studentGPA
    };
    documentReference.setData(student).whenComplete((){
      print('$studentName created');
    });
  }
  readData(){
    DocumentReference documentReference = Firestore.instance.collection('students').document(studentName);
    documentReference.get().then((datasnapshot){
      print(datasnapshot.data['student name']);
      print(datasnapshot.data['student id']);
      print(datasnapshot.data['program id']);
      print(datasnapshot.data['gpa']);
    });
  }
  updateData(){
    DocumentReference documentReference = Firestore.instance.collection("students").document(studentName);

    //create map
    Map<String,dynamic> student = {
      'student name':studentName,
      'program id':studyProgramID,
      'student id':studentID,
      'gpa':studentGPA
    };
    documentReference.setData(student).whenComplete((){
      print('$studentName updated');
    });
  }
  deleteData(){
   DocumentReference documentReference = Firestore.instance.collection('students').document(studentName);
   documentReference.delete().whenComplete((){
     print('$studentName deleted');
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crud operations'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding:EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                labelText: 'Name',
                focusColor: Colors.red,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue)
                )
              ),
              onChanged: (String name){
                getStudentName(name);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Student ID',
                  focusColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                  )
              ),
              onChanged: (String id){
                getStudentID(id);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'Study Programe ID',
                  focusColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                  )
              ),
              onChanged: (String programId){
                getStudyProgramID(programId);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  labelText: 'GPA',
                  focusColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)
                  )
              ),
              onChanged: (String gpa){
                getProgramGpa(gpa);
              },
            ),
          ),
          Row(
            children: <Widget>[
              Padding(
                padding:  EdgeInsets.all(5.0),
                child: RaisedButton(
                  color: Colors.red,
                  child:Text('create'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)
                  ),
                  onPressed: (){
                    createData();
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(5.0),
                child: RaisedButton(
                  color: Colors.blue,
                  child:Text('read'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)
                  ),
                  onPressed: (){
                    readData();
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(5.0),
                child: RaisedButton(
                  color: Colors.yellow,
                  child:Text('update'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)
                  ),
                  onPressed: (){
                    updateData();
                  },
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(5.0),
                child: RaisedButton(
                  color: Colors.green,
                  child:Text('delete'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)
                  ),
                  onPressed: (){
                    deleteData();
                  },
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text('name'),
              ),
              Expanded(
                child: Text('sid'),
              ),
              Expanded(
                child: Text('pid'),
              ),
              Expanded(
                child: Text('gpa'),
              ),
            ],
          ),

          StreamBuilder(
            stream:Firestore.instance.collection('students').snapshots(),
            builder: (context,snapshot){
              if(snapshot.hasData){
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.documents.length,
                    itemBuilder: (context,index){
                    DocumentSnapshot documentSnapshot = snapshot.data.documents[index];
                    return Row(
                      children: <Widget>[
                        Expanded(
                            child:Text(documentSnapshot['student name'])
                        ),
                        Expanded(
                            child:Text(documentSnapshot['student id'])
                        ),
                        Expanded(
                            child:Text(documentSnapshot['program id'])
                        ),
                        Expanded(
                            child:Text(documentSnapshot['gpa'].toString())
                        ),
                      ],
                    );
                    }
                );
              }else{
                return Align(
                  alignment:FractionalOffset.bottomCenter,
                  child:CircularProgressIndicator()
                );
              }
            },

          )
        ],
      ),
    );
  }
}





