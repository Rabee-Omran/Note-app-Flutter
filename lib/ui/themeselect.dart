
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    return new Scaffold(
      appBar: AppBar(
        title: Text('الخلفية'),
      ),
      body: Container(
        child: Column(

          children: <Widget>[
              Row(crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                      child: Text('الوضع الليلي'),
                      onPressed: () => _themeChanger.setTheme(ThemeData.dark())),

                ],
              ),
            Row(crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                    child: Text('الوضع الافتراضي'),
                    onPressed: () => _themeChanger.setTheme(ThemeData.light())),

              ],
            ),





             ],
        ),
      ),
    );
  }
}
