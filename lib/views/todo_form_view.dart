import 'package:flutter/material.dart';
import 'package:todo_list/models/todo_model.dart';

class TodoFormView extends StatefulWidget {
  final TodoModel todoModel;
  const TodoFormView({Key key, this.todoModel}) : super(key: key);

  @override
  _TodoFormViewState createState() => _TodoFormViewState();
}

class _TodoFormViewState extends State<TodoFormView> {
  final _formKey = GlobalKey<FormState>();
  TodoModel request;

  void initState() {
    super.initState();
    request = widget.todoModel ?? TodoModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.todoModel != null ? 'Alter' : 'New')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Title'),
                  initialValue: request.title,
                  onSaved: (newValue) {
                    request.title = newValue;
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Title empty!";
                    }
                    return null;
                  },
                ),
                CheckboxListTile(
                  title: Text('Check'),
                  value: request.check,
                  onChanged: (value) {
                    setState(() {
                      request.check = value;
                    });
                  },
                ),
                FlatButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      request.save();
                      Navigator.pop(context);
                    }
                  },
                  child: Text('SUBIMIT'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
