import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Review Evolve Lessions',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Todo  Task List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _task = '';
  bool _isEditingTask = false;
  String _editingTask = '';
  List<String> _tasks = ['task one', 'task  two'];
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //update the state when the user types.
    _textController.addListener(() {
      _task = _textController.text;
    });
  }

  void _addTask(task) {
    if (task.length == 0) return;
    if (_tasks.contains(task)) return;

    setState(() {
      _tasks.add(task);
    });

    _clear();
  }

  void _removeTask(task) {
    if (!_tasks.contains(task)) return;

    setState(() {
      _tasks.remove(task);
    });

    _clear();
  }

  void _editTask(String task) {
    setState(() {
      _isEditingTask = true;
      _task = task;
      _editingTask = task;
      _textController.text = task;
    });
  }

  void _clear() {
    //clear task value
    setState(() {
      _task = '';
      _editingTask = '';
      _textController.text = '';
    });
  }

  void _updateTask(String task) {
    setState(() {
      if (_tasks.contains(_editingTask)) {
        _tasks[_tasks.indexOf(_editingTask)] = _task;
      }
    });
    _isEditingTask = false;
    _clear();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    onChanged: (value) {
                      print('changed value : $value');
                      setState(() {
                        _task = value;
                      });
                    },
                    onSubmitted: (value) {
                      _addTask(value);
                    },
                    textAlign: TextAlign.center,
                  ),
                ),
                if (!_isEditingTask)
                  IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.white,
                    style: IconButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () => _addTask(_task),
                  ),
                if (_isEditingTask)
                  IconButton(
                    icon: const Icon(Icons.save),
                    color: Colors.white,
                    style: IconButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () => _updateTask(_task),
                  ),
              ],
            ),
            SizedBox.fromSize(size: Size(12, 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    'List of My Tasks',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Expanded(child: ListTile(title: Text(_tasks[index]))),
                      IconButton(
                        onPressed: () {
                          _editTask(_tasks[index]);
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            19,
                            197,
                            197,
                          ),
                        ),
                        icon: const Icon(Icons.edit),
                        color: Colors.white,
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _tasks.removeAt(index);
                          });
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                        ),
                        icon: const Icon(Icons.remove_sharp),
                        color: Colors.white,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
