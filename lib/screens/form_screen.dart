import 'package:flutter/material.dart';
import 'package:nosso_primeiro_projeto/data/task_inherited.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key, required this.taskContext});

  final BuildContext taskContext;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController dificultyController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  bool valueValidator(String? value){
    if(value != null && value.isEmpty){
      return true;
    }
    return false;
  }

  bool difficultyValidator(String? value){
    if(value != null && value.isEmpty){
      if(int.parse(value) > 5 || int.parse(value) < 1){
        return true;
      }
    }
    return false;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text('Nova Tarefa', style: TextStyle(
            color: Colors.white,
            fontSize: 20
          ),),
        ),

        body: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 375,
              height: 650,

              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1),
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (String? value){
                          if(valueValidator(value)){
                            return 'Insira o nome da Tarefa';
                          }
                          else {
                            return null;
                          }
                        },
                        controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nome da Tarefa',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value){
                          if(difficultyValidator(value))  {
                            return 'Insira uma dificuldade entre 1 e 5';
                          }
                          else {
                            return null;
                          }
                        },
                        controller: dificultyController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Dificuldade da Tarefa',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value){
                          if(valueValidator(value)){
                            'Insira uma url da imagem valida';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.url,
                        controller: imageController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Imagem',
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    height: 100,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.blue)
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageController.text, fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image.asset('assets/images/nophoto.png');
                        },
                      ),
                    )

                  ),

                  SizedBox(
                    height: 10,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text('Adicionar', style: TextStyle(
                      color: Colors.white,
                    ),),
                    onPressed: (){
                      if(_formKey.currentState!.validate()){
                        // print(nameController.text);
                        // print(dificultyController.text);
                        // print(imageController.text);
                        TaskInherited.of(widget.taskContext).newTask(nameController.text, imageController.text, int.parse(dificultyController.text));
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Criando uma nova tarefa')),);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
