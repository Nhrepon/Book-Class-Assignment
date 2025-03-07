import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Addqoute extends StatefulWidget {
  const Addqoute({super.key});
  static const String name = "add-new";

  @override
  State<Addqoute> createState() => _AddqouteState();
}

class _AddqouteState extends State<Addqoute> {
  final TextEditingController title = TextEditingController();
  final TextEditingController author = TextEditingController();
  final TextEditingController img = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool progressbar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Addqoute.name),
        backgroundColor: Colors.yellow,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: const EdgeInsets.all(16),
        child: qouteForm(),

        ),
      ),
    );
  }

  Widget qouteForm() {
    return Form(
      key: formKey,
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              const SizedBox(height: 20,),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: title,
                decoration: InputDecoration(
                  hintText: 'Enter a Title',
                  hintStyle: const TextStyle(
                    color: Colors.green,
                    fontSize: 18
                  ),
                  hintMaxLines: 1,
                  labelText: 'Title *',
                  labelStyle: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter a valid title';
                  }
                  return null;
                },
              ),

              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: author,
                decoration: InputDecoration(
                  hintText: 'Enter an author name',
                  hintStyle: const TextStyle(
                      color: Colors.green,
                      fontSize: 18
                  ),
                  hintMaxLines: 1,
                  labelText: 'Author *',
                  labelStyle: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter a valid title';
                  }
                  return null;
                },
              ),

              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: img,
                decoration: InputDecoration(
                  hintText: 'Enter a image link',
                  hintStyle: const TextStyle(
                      color: Colors.green,
                      fontSize: 18
                  ),
                  hintMaxLines: 1,
                  labelText: 'Image *',
                  labelStyle: const TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                  border: const OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (String? value){
                  if(value?.trim().isEmpty ?? true){
                    return 'Enter a valid title';
                  }
                  return null;
                },
              ),


              //const SizedBox(height: 20,),
              Visibility(
                visible: progressbar == false,
                replacement: Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                  style: const ButtonStyle(

                  ),
                    onPressed: (){
                    if(formKey.currentState!.validate()){
                      addNewQuote();
                    }
                    },
                    child: const Text("Add Qoute", style: TextStyle(
                      fontSize: 18,

                    ),)
                ),
              )
            ],
          ),
      //.childrenPadding(const EdgeInsets.only(bottom: 24)),
        );
  }



  Future<void> addNewQuote()async{
    progressbar = true;
    setState(() {});
    Uri uri = Uri.parse("https://crud.teamrabbil.com/api/v1/CreateProduct");
    Map<String, dynamic> reqBody = {
      "ProductName": title.text.trim(),
      "ProductCode": author.text.trim(),
      "Img": img.text.trim(),
      "UnitPrice": "11",
      "Qty": "11",
      "TotalPrice": "11",
    };
    Response response = await post(
        uri,
        headers: {
          'content-type':'application/json'
        },
        body: jsonEncode(reqBody));


    setState(() {});
    progressbar = false;

    if(response.statusCode == 200 ){
      clearText();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Success!")));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed!")));
    }
  }

  void clearText(){
    title.clear();
    author.clear();
    img.clear();
  }



}

// extension WidgetExtension on Widget {
//   Widget paddingAll(double value) => Padding(padding: EdgeInsets.all(value), child: this);
//
//   Widget padding(EdgeInsets padding) => Padding(padding: padding, child: this);
// }
//
// extension ColumnExtension on Column {
//   Column childrenPadding(EdgeInsets padding) {
//     return Column(
//       children: children.map((e) => e.padding(padding)).toList(),
//     );
//   }
// }
