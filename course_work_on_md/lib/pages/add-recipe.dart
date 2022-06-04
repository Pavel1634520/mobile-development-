import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:course_work_on_md/domain/authuser.dart';
import 'package:course_work_on_md/services/database.dart';
import 'package:flutter/material.dart';

import '../domain/recipe.dart';

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  State<AddRecipe> createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  @override
  late Recipe recipe = Recipe(
      author: '',
      uid: '',
      title: '',
      complexity: '',
      miniDescription: '',
      description: '',
      ingredients: '');
  AuthUser? user;
  String title = '';
  String miniDescription = '';
  String description = '';
  String ingredients = '';
  String complexity = 'Низкая сложность';

  Widget build(BuildContext context) {
    void _saveRecipe() async {
      recipe.title = title;
      recipe.miniDescription = miniDescription;
      recipe.description = description;
      recipe.ingredients = ingredients;
      recipe.complexity = complexity;
      recipe.isOnline = false;
      await FirebaseFirestore.instance
          .collection('recipes')
          .doc(recipe.uid)
          .set(recipe.toMap());
      //await DatabaseService().addOrUpdateRecipe(recipe);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Рецепт добавлен'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.of(context).pop();
    }

    var levelMenuItems = <String>[
      'Низкая сложность',
      'Средняя сложность',
      'Высокая сложность',
      'Невероятно сложно'
    ].map((String value) {
      return new DropdownMenuItem<String>(
        value: value,
        child: new Text(value),
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(title: Text("Новый рецепт"), centerTitle: true),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: 'Название рецепта',
                            icon: Icon(Icons.new_label)),
                        onChanged: (text) {
                          title = text;
                        }),
                    TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: 'Мини-описание рецепта',
                            icon: Icon(Icons.new_label)),
                        onChanged: (text) {
                          miniDescription = text;
                        }),
                    TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: 'Описание рецепта',
                            icon: Icon(Icons.new_label)),
                        onChanged: (text) {
                          description = text;
                        }),
                    TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                            labelText: 'Ингредиенты(через запятую)',
                            icon: Icon(Icons.new_label)),
                        onChanged: (text) {
                          ingredients = text;
                        }),
                    DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                          label: Text('Уровень сложности приготовления'),
                          icon: Icon(Icons.new_label)),
                      items: levelMenuItems,
                      value: complexity,
                      onChanged: (String? val) =>
                          setState(() => complexity = val!),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                  onPressed: () {
                    if (title == '' ||
                        miniDescription == "" ||
                        description == "" ||
                        ingredients == '') {
                      showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Внимание!'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: const <Widget>[
                                    Text('Все поля должны быть заполнены!'),
                                  ],
                                ),
                              ),
                              actions: [
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "ОК",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                ),
                              ],
                            );
                          });
                    } else {
                      _saveRecipe();



                    }
                  },
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Добавить',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
