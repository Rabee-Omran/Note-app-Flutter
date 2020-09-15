import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zoom_widget/zoom_widget.dart';
import 'package:sqllite2/model/note.dart';
import 'package:sqllite2/utils/database_helper.dart';
import 'package:sqllite2/utils/image_utilty.dart';

class NoteInfo extends StatefulWidget {
  final  Note note;
  NoteInfo(this.note);


  @override
  _NoteInfoState createState() => new _NoteInfoState();
}

class _NoteInfoState extends State<NoteInfo> {
  DatabaseHelper db = new DatabaseHelper();


  String ss=" iVBORw0KGgoAAAANSUhEUgAAAgAAAAIACAIAAAB7GkOtAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAJ3bSURBVHja7P15sGRLft+H/TLPXsvd+i69d7/X3W9m3rwZzAxmiGVmMACxCACDFEFChCBBYcuSRdEQZYsOWbbCCpO0bFkM0yIUDhJBISAHRdOiRMi0FASxL8S+zgxme/vrvfuutZ89M/1HVp176lTdOnmylnuqKn8xM9HvTd2+v8qT5/vL/H0yfz/EGANlypQpU7Z+htUQKFOmTJkKAMqUKVOmTAUAZcqUKVOmAoAyZcqUKVMBQJkyZcqUqQCgTJkyZcpUAFCmTJkyZSoAKFOmTJkyFQCUKVOmTJkKAMqUKVOmTAUAZcqUKVOmAoAyZcqUKVMBQJkyZcqUqQCgTJkyZcpUAFCmTJkyZSoAKFOmTJkyFQCUKVOmTJkKAMqUKVOmTAUAZcqUKVOmAoAyZcqUKVMBQJkyZcqUqQCgTJkyZcpUAFCmTJkyZSoAKFOmTJkKAMqUKVOmTAUAZcqUKVOmAoAyZcqUKVMBQJkyZcqUqQCgTJkyZcpUAFCmTJkyZSoAKFOmTJkyFQCUKVOmTJkKAMqUKVOmTAUAZcqUKVOmAoAyZcqUKVMBQJkyZcqUqQCgTJkyZcpUAFCmTJkyZSoAKFOmTJkyFQCUKVOmTJkKAMqUKVOmTAUAZcqUKVMmZfqyOMpSf0bz+ZEF/Arl1cJ+RHmlvFour1QAuNAIPR9PjFDuiDIGlJ3/iIbzHwFlLPkJhAAhtCZeZX5ExKv0FxH0Kv1FlFfKqzXyCpdZ/0sfABgAGQw/AsAIcsefARB2/iMiz5hQRs9FM/8ZL8Yryhhhkl4BgCboFZ27V5Sx5KVbW68QV6hl9IoBhXOv8Kp4JaLM/HEwYa8AgLBhr1QKaBr1jykDxhgDhABjlPsAKGOE9j8PCGkCT4xQRhg";

  String name = '';
  String title = '';
  String description = '';
  String image='';
  Image s;
  String v ;





//  image =Utility.imageFromBase64String(widget.note.image);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.note.name;
    title = widget.note.title;
    description = widget.note.description;
    if(widget.note.image=='NoImage'){
      print("ffd"+image);
      image= widget.note.image;
    }else{ print("fsdsdsadhfgfd"+image);}


    if(image!=ss) {
      print("ffd"+image);
      s=Utility.imageFromBase64String(image);
      v='ok';
    }
    else if(image=='NoImage'){
      print("f"+image);
      s=Utility.imageFromBase64String(ss);
    v='ok';}else{ print("ef"+image);}
  }





  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text('التفاصيل'),
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Text(
                ' اسم المادة ',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0,
                    fontFamily: 'Amiri',
                    color: Colors.redAccent),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),

                width: 220.0,
                child: Card(

                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: Colors.redAccent, width: 0.5)),
                  borderOnForeground: true,
                  elevation: 2.0,
                  child:new Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child:  new Directionality(

                      textDirection: TextDirection.rtl,
                      child: Text(
                        '$name',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0,
                        ),
                      ),
                    ),),


                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Text(
                ' عنوان الملاحظة  ',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0,
                    fontFamily: 'Amiri',
                    color: Colors.redAccent),
              ),
              Container(

                width:300.0,
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                          color: Colors.redAccent, width: 0.5)),
                  borderOnForeground: true,
                  elevation: 2.0,
                  child:
                  new Container(
                    padding: EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: new Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        '$title',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0,
                        ),
                      ),
                    ),),


                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),
              Text(
                ' الملاحظة ',
                style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 20.0,
                    fontFamily: 'Amiri',
                    color: Colors.redAccent),
              ),
              Container(
                width: 385.0,
                child: Card(
                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.redAccent[200], width:0.5)),
                  borderOnForeground: true,
                  elevation: 2.0,
                  child:
                  new Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child:new Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        '$description',
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0,
                        ),
                      ),
                    ) ,),

                ),
              ),
              Padding(padding: EdgeInsets.only(top: 20.0)),

              v=='ok'? Center(

                child: Column(

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(

                      ' صورة ',
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0,
                          fontFamily: 'Amiri',
                          color: Colors.redAccent),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                     Container(

                      width:width-20,
                      height:520,
                      child: Card(

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              side: BorderSide(
                                  color: Colors.redAccent, width:0.5)),

                          color: Colors.redAccent,
                        elevation: 5,
                        child:Zoom(
                          backgroundColor:Colors.redAccent ,
                          colorScrollBars: Colors.redAccent,

                            doubleTapZoom: true,
                          enableScroll: true,
                            width: 400,
                            height:  600,
                            onPositionUpdate: (Offset position){
                            },
                            onScaleUpdate: (double scale,double zoom){

                            },
                          child: s,

                        )
                      )
                      ,
                    )

                  ],
                ),
              ):Container(height:0),
              Padding(padding: EdgeInsets.only(top: 60.0)),
            ],
          ),
        ],
//         alignment: Alignment.center,
      ),
    );
  }
}
