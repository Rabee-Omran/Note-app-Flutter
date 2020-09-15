import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sqllite2/model/note.dart';
import 'package:sqllite2/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqllite2/utils/image_utilty.dart';

import '../theme.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NoteScreenState();
  }
}

class NoteScreenState extends State<NoteScreen> {
  File image;
  String imgString;
  picker() async {

    await ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      setState(() {
        if (imgFile != null) {
          image = imgFile;
        }
        imgString = Utility.base64String(imgFile.readAsBytesSync());
        print(imgString);
      }
        );
    });

  }

  DatabaseHelper db = new DatabaseHelper();

  TextEditingController _titleController;
  TextEditingController _nameController;
  TextEditingController _descriptionController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _titleController = new TextEditingController(text: widget.note.title);
    _nameController = new TextEditingController(text: widget.note.name);
    _descriptionController =
        new TextEditingController(text: widget.note.description);
   imgString=widget.note.image;


  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: (widget.note.id != null)
            ? Text(
          'تعديل',
          style: TextStyle(color: Colors.white),
        )
            : Text('إضافة ملاحظة', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
          ),
          Column(
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Padding( padding: EdgeInsets.all(5.0)),
              Container(
                width: width-60,

                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,

                  controller: _nameController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.subject,
                      color: Colors.green,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid)),
                    labelText: "اسم المادة",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  style: TextStyle(

                    fontSize: 15.0,
                  ),
                ),

              ),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Container(
                width: width-30,


                child: TextField(

                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textAlign: TextAlign.right,

                  controller: _titleController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.title,
                      color: Colors.green,
                      textDirection: TextDirection.ltr,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid)),
                    labelText: "عنوان الملاحظة",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  style: TextStyle(

                    fontSize: 15.0,
                  ),
                ),

              ),
              Padding(
                padding: EdgeInsets.all(9.0),
              ),
              Container(
                width: width-20,


                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,

                  controller: _descriptionController,
                  decoration: InputDecoration(
                    contentPadding:
                    const EdgeInsets.symmetric(vertical: 110.0),
                    prefixIcon: Icon(
                      Icons.note_add,
                      color: Colors.green,
                    ),
                    enabledBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(

                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(
                            color: Colors.green,
                            style: BorderStyle.solid)),
                    labelText: "الملاحظة",
                    labelStyle: TextStyle(color: Colors.green),
                  ),
                  style: TextStyle(

                    fontSize: 15.0,
                  ),
                ),

              ),
              Padding(padding: EdgeInsets.all(10.0)),
              Center(
                child: (widget.note.id != null)? image == null ? Text(' الصورة الحالية ') : Image.file(image,height: 300,): image == null ? Text('لا يوجد صورة بعد') : Image.file(image,height: 300,),
              ),
              Padding(padding: EdgeInsets.all(10.0)),
              FloatingActionButton(

                onPressed: picker,
                backgroundColor:Colors.green ,
                child: Icon(Icons.camera,color: Colors.white,),
              ),
              Padding(padding: EdgeInsets.all(5.0)),
              RaisedButton(
                onPressed: () => {
                  if (_nameController.text.trim().isEmpty ||
                      _descriptionController.text.trim().isEmpty||
                      _titleController.text.trim().isEmpty
                  )
                    {_neverSatisfied()}else{
                    if (widget.note.id != null)
                      {


                        db
                            .updateNote(Note.fromMap({
                          'id': widget.note.id,
                          'name': _nameController.text,
                          'description': _descriptionController.text,
                          'title': _titleController.text,
                          'image':imgString,
                        }))
                            .then((_) {
                          Navigator.pop(context, 'update');
                        })

                      }
                    else
                      {
                        db
                            .saveNote(Note(
                            _nameController.text,
                            _titleController.text,
                            _descriptionController.text,
                            imgString),
                        )
                            .then((_) {
                          Navigator.pop(context, 'save');
                        })
                      }
                  }},
                child: (widget.note.id != null)
                    ? Text(
                  'تعديل',
                  style: TextStyle(color: Colors.white),
                )
                    : Text('حفظ', style: TextStyle(color: Colors.white)),
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    side:
                    BorderSide(color: Colors.lightGreen, width: 3.0)),
              ),

            ],
          ),
          Padding( padding: EdgeInsets.only(top:30.0)),
        ],
      ),

    );
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                new Directionality(
                    textDirection: TextDirection.rtl,
                    child: Text('يرجى ملئ جميع الحقول'))
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('موافق',style: TextStyle(color: Colors.green),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
