import 'package:flutter/cupertino.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sqllite2/theme.dart';
import 'package:sqllite2/model/note.dart';
import 'package:sqllite2/ui/themeselect.dart';
import 'package:sqllite2/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:sqllite2/ui/note_screen.dart';
import '../theme.dart';
import 'note_info.dart';

class ListViewNotes extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ListViewNotesState();
  }
}

class ListViewNotesState extends State<ListViewNotes> {

  List<Note> items = new List();
  DatabaseHelper db = new DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(items);
    db.getAllNotes().then((notes) {
      setState(() {
        print(items);
        notes.forEach((employee) {
        print(items);

          items.add(Note.fromMap(employee));
        print(items);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(

        localizationsDelegates: [
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('ar'), // English
          const Locale('ar'), // Hebrew
          const Locale.fromSubtags(languageCode: 'ar'), // Chinese *See Advanced Locales below*
          // ... other locales the app supports
        ],
        theme: theme.getTheme(),
        title: ' الملاحظات',
        home: Scaffold(
          key: scaffoldState,
          appBar: AppBar(
            actions: <Widget>[
              IconButton(icon: Icon(Icons.wb_sunny),onPressed:()=> Navigator.push(
            context,MaterialPageRoute(builder: (context) => HomePage()),)
    )],
            title: Text('الملاحظات'),
            centerTitle: true,
            backgroundColor: Colors.blueAccent,
          ),
          body: items.length==0?
              Center(child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[


                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: <Widget>[

                      Text('لا يوجد ملاحظات لديك , قُم بالإضافة '),
                      IconButton(
                          icon: Icon(Icons.add,),color: Colors.green,
                          iconSize: 30,
                          onPressed: () => _createNewNote(context)),
                    ],
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 5)),
                Image.asset('img/a.png',height: 64,width: 64,)
              ],)
              )

              :Center(
            child: ListView.builder(
                itemCount: items.length,
                padding: const EdgeInsets.all(15.0),
                itemBuilder: (context, position) {

                  return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[

                          new Directionality(
                            textDirection: TextDirection.rtl,
                            child: new Expanded(
                                child: ListTile(
                                  title: Text(
                                    '${items[position].name}',
                                    style: TextStyle(
                                      fontSize: 20.0,),
                                  ),
                                  subtitle: Text(
                                    '${items[position].title}',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.blue),
                                  ),
                                  leading: Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(1.0)),
                                      CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius: 19.0,
                                        child: Text(
                                          '${items[position].id}',
                                          style: TextStyle(
                                              fontSize: 22.0, color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () =>
                                      _navigateToNoteInfo(context, items[position]),
                                )),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                showSimpleDialog(
                                    context, items[position], position);
                              }),
                          IconButton(
                            icon: Icon(
                              Icons.mode_edit,
                              color: Colors.green,
                            ),
                            onPressed: () =>
                                _navigateToNote(context, items[position]),
                          ),
                        ],

                      ),
                      Divider(
                        height: 5.0,
                      ),

                    ],
                  );
                }),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.green,
              onPressed: () => _createNewNote(context)),

            drawer: Drawer(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 200.0),
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'img/a.png',
                            height: 190.0,
                            width: 190.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                          ),
                          Text(
                            'My Note',
                            style: TextStyle(fontSize: 20.0, fontStyle: FontStyle.italic),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                          ),

                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[


                              Text(
                                'Developed By : Rabee Omran',
                                style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                              ),

                              GestureDetector(
                                onTap: () {
                                  launch('https://www.facebook.com/RabeeOmran2/');
                                },
                                child: Image.asset(
                                  'img/f.png',
                                  height: 40.0,
                                  width: 40.0,
                                ),
                              ),


                            ],

                          ),
                        ],
                      )),
                ))
          // Populate the Drawer in the next step.
        ));
  }

  _deleteNote(BuildContext context, Note note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
        showSnackBar('حذف');
      });
    });
  }

  void _navigateToNote(BuildContext context, Note note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );

    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          print('hjhj');
          print(items);
          items.clear();

          notes.forEach((note) {
            items.add(Note.fromMap(note));
            print('hjhj');
            print(items);
          });
          showSnackBar('تعديل');
        });
      });
    }
  }

  void _navigateToNoteInfo(BuildContext context, Note note) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteInfo(note)),
    );
  }

  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Note('', '', '',''))),
    );

    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {


          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));

          });
        });
      });
    }
  }

  String myValue = '';
  void setValueOn(String value) {
    myValue = value;
  }

  Future showSimpleDialog(BuildContext context, Note note, int position) async {
    switch (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text(
              ' هل فعلاً ترغب بحذف الملاحظة رقم ${note.id} ؟',
              style: TextStyle(fontSize: 17.0),
            ),
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(right: 138.0)),
                  new Directionality(
                    textDirection: TextDirection.rtl,
                    child: new SimpleDialogOption(
                      child: Text('لا'),
                      onPressed: () {
                        Navigator.pop(context, setValueOn('No'));
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: 10.0)),
                  new Directionality(
                    textDirection: TextDirection.rtl,
                    child: new SimpleDialogOption(
                        child: Text('نعم'),
                        onPressed: () {
                          _deleteNote(context, items[position], position);


                          Navigator.pop(context, setValueOn('YES'));
                        }),
                  ),
                ],
              )
            ],
          );
        })) {
    }
  }


}

final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();

showSnackBar(x) {
  scaffoldState.currentState.showSnackBar(new SnackBar(
      content: new Directionality(
          textDirection: TextDirection.rtl,
          child: Text('تم $x الملاحظة بنجاح'))));
}

