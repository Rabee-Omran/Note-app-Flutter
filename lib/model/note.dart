String s=" iVBORw0KGgoAAAANSUhEUgAAAgAAAAIACAIAAAB7GkOtAAAACXBIWXMAAAsTAAALEwEAmpwYAAAAIGNIUk0AAHolAACAgwAA+f8AAIDpAAB1MAAA6mAAADqYAAAXb5JfxUYAAJ3bSURBVHja7P15sGRLft+H/TLPXsvd+i69d7/X3W9m3rwZzAxmiGVmMACxCACDFEFChCBBYcuSRdEQZYsOWbbCCpO0bFkM0yIUDhJBISAHRdOiRMi0FASxL8S+zgxme/vrvfuutZ89M/1HVp176lTdOnmylnuqKn8xM9HvTd2+v8qT5/vL/H0yfz/EGANlypQpU7Z+htUQKFOmTJkKAMqUKVOmTAUAZcqUKVOmAoAyZcqUKVMBQJkyZcqUqQCgTJkyZcpUAFCmTJkyZSoAKFOmTJkyFQCUKVOmTJkKAMqUKVOmTAUAZcqUKVOmAoAyZcqUKVMBQJkyZcqUqQCgTJkyZcpUAFCmTJkyZSoAKFOmTJkyFQCUKVOmTJkKAMqUKVOmTAUAZcqUKVOmAoAyZcqUKVMBQJkyZcqUqQCgTJkyZcpUAFCmTJkyZSoAKFOmTJkKAMqUKVOmTAUAZcqUKVOmAoAyZcqUKVMBQJkyZcqUqQCgTJkyZcpUAFCmTJkyZSoAKFOmTJkyFQCUKVOmTJkKAMqUKVOmTAUAZcqUKVOmAoAyZcqUKVMBQJkyZcqUqQCgTJkyZcpUAFCmTJkyZSoAKFOmTJkyFQCUKVOmTJkKAMqUKVOmTAUAZcqUKVMmZfqyOMpSf0bz+ZEF/Arl1cJ+RHmlvFour1QAuNAIPR9PjFDuiDIGlJ3/iIbzHwFlLPkJhAAhtCZeZX5ExKv0FxH0Kv1FlFfKqzXyCpdZ/0sfABgAGQw/AsAIcsefARB2/iMiz5hQRs9FM/8ZL8Yryhhhkl4BgCboFZ27V5Sx5KVbW68QV6hl9IoBhXOv8Kp4JaLM/HEwYa8AgLBhr1QKaBr1jykDxhgDhABjlPsAKGOE9j8PCGkCT4xQRhg";

  class Note{

  int _id;
  String _name;
  String _title;
  String _description;
  String _image;



  Note(this._name, this._title, this._description,this._image);

  Note.map(dynamic obj){

    this._id = obj['id'];

    this._name = obj['name'];
    this._title = obj['title'];
    this._description = obj['description'];
    if (_image!=''){_image = obj['image'];}
    else{_image=s;}


  }

  String get description => _description;
  String get title => _title;
  String get name => _name;
  String get image {
    if(_image!='') return _image;

    else return _image=s;

  }
  int get id => _id;

  Map<String , dynamic> toMap(){
    var map = new Map<String , dynamic>();
    if(_id != null){
      map['id'] = _id;
    }

    map['name'] = _name;
    map['title'] = _title;
    map['description'] = _description;
    if (_image!=''){map['image'] = _image;}
    else{map['image'] =s;}


    return map;
  }





  Note.fromMap(Map<String , dynamic> map){

    this._id = map['id'];
    this._name = map['name'] ;
    this._title = map['title'];
    this._description = map['description'] ;
    if (_image!=null){_image = map['image'] ;}
    else{ _image=s;}

  }

}