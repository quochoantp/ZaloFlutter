

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
   File? file;
  final ImagePicker _picker = ImagePicker();
  TextEditingController descriptionTextEditingController = TextEditingController();

  pickImageFromGallery() async {
    Navigator.pop(context);
    XFile? imagefile = await _picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 680,
      maxWidth: 970,
    );
    setState((){
      this.file = File(imagefile!.path);
    });

  }
  captureImageWithCamera() async{
    Navigator.pop(context);
    XFile? imagefile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 680,
      maxWidth: 970,
    ) ;
    setState((){
       this.file = File(imagefile!.path);
    });
  }
   close(){
    Navigator.pop(context);
  }

  takeImage(mContext){
     return showDialog(
       context: mContext,
       builder: (context){
         return SimpleDialog(
           title: Text("New Post",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold ),),
           children: <Widget>[
             SimpleDialogOption(
               child: Text("Capture Image with Camera",style: TextStyle(color: Colors.black),),
               onPressed: captureImageWithCamera,
             ),
             SimpleDialogOption(
               child: Text("Select Image from Gallery",style: TextStyle(color: Colors.black),),
               onPressed: pickImageFromGallery,
             ),
             SimpleDialogOption(
               child: Text("Cancel",style: TextStyle(color: Colors.black),),
               onPressed: close,
             ),
           ],
         );
       }
     );
  }

  displayUploadScreen(){
    return Container(
      color: Theme.of(context).accentColor.withOpacity(0.5),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.add_photo_alternate,color: Colors.blue, size: 150),
          Padding(padding: EdgeInsets.only(top:20.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9.0),),
              child: Text("Upload Image",style: TextStyle(color: Colors.white,fontSize: 20.0),),
              color: Colors.green,
              onPressed: () => takeImage(context),
            ),
          ),
        ],
      ),

    );
  }

  removeImage(){
    setState((){
      file = null;
    });
  }

  displayUploadFormScreen(){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: removeImage),
        title: Text("New Post",style: TextStyle(fontSize: 24.0, color: Colors.black,fontWeight: FontWeight.bold),),
        actions: <Widget>[
          FlatButton(
            onPressed: ()=> print("tapped"),
            child: Text("Đăng", style: TextStyle(color: Colors.lightBlue,fontWeight: FontWeight.bold,fontSize: 16.0),),

          )
        ],
      ),
      body:ListView(
        children: <Widget>[
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  decoration: BoxDecoration(image: DecorationImage(image: FileImage(file!), fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 12.0),),
          ListTile(
            leading: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.grey[200],
              backgroundImage: NetworkImage('https://scr.vn/wp-content/uploads/2020/08/%E1%BA%A2nh-hot-girl-l%C3%A0m-avt.jpg'),
            ),
            title:Container(
              width: 250.0,
              child: TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: descriptionTextEditingController,
                decoration: InputDecoration(
                  hintText: "Cảm xúc của bạn hôm nay như thế nào?",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
              ),
            )
          )
        ],
      ) ,
    );
  }
  @override
  Widget build(BuildContext context) {
 return file == null ? displayUploadScreen() : displayUploadFormScreen();
    throw UnimplementedError();
  }
}