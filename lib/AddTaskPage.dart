import 'package:flutter/material.dart';
import 'task.dart';

class AddTaskPage extends StatefulWidget {
  final Function(Task) onTaskAdded;

  const AddTaskPage({super.key, required this.onTaskAdded});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  late String _taskName;
  late DateTime _selectedDate;
  late String _selectedTag;
  late  String _taskdescp;

  @override
  void initState() {
    super.initState();
    
    _selectedDate = DateTime.now();
    _selectedTag = "Work";
     _taskdescp = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Task Name',
                  border: OutlineInputBorder(gapPadding: 4)),
              onChanged: (value) {
                _taskName = value;
              },
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    const Text('Category:'),
                    DropdownButton<String>(
                      dropdownColor: const Color.fromARGB(255, 249, 200, 131),
                      value: _selectedTag,
                      onChanged: (value) {
                        setState(() {
                          _selectedTag = value!;
                        });
                      },
                      items: ['Birthday', 'Work', 'Personal', 'Wishlist']
                          .map((tag) => DropdownMenuItem(
                                value: tag,
                                child: Text(tag),
                              ))
                          .toList(),
                    ),
                  ],
                ),
                Center(
                  child: Column(
                    children: [
                      const Text('Select Date:'),
                      TextButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              initialDate: _selectedDate,
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                            ).then((value) {
                              if (value != null) {
                                setState(() {
                                  _selectedDate = value;
                                });
                              }
                            });
                          },
                          child: Row(
                            children: [
                              const Icon(
                                Icons.calendar_today,
                                size: 18,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Informations',
                  border: OutlineInputBorder(gapPadding: 4),
                  ),
                  
              maxLines: 4,
              onChanged: (value) {
                 _taskdescp = value;
              },
            ),
            const SizedBox(height: 30.0),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 249, 200, 131),
                  foregroundColor: const Color.fromARGB(255, 68, 69, 69),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(10, 40),
                ),
                onPressed: () {
                  Task newTask = Task(
                    name: _taskName,
                    date: _selectedDate,
                    tag: _selectedTag,
                     taskdescp: _taskdescp,
                  );
                  widget.onTaskAdded(newTask);

                  Navigator.pop(context);
                },
                child: const Text('Add Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
