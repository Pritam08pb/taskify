import 'package:flutter/material.dart';
import 'AddTaskPage.dart';
import 'task.dart';
import 'DetailsPage.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';

import 'SplashScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 241, 227, 208),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 1, 119, 255)),
        useMaterial3: true,
      ),
      home:SplashScreen()  ,
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
  List<Task> tasks = [];
  List<Task> filteredTasks = [];
  String currentTag = "All";
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _initializeSharedPreferences();
    super.initState();
    tasks = [];
    filteredTasks = tasks;
  }

  Future<void> _initializeSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadTasks();
  }

  void _loadTasks() {
    List<String>? tasksJson = _prefs.getStringList('tasks');
    if (tasksJson != null) {
      setState(() {
        tasks =
            tasksJson.map((taskJson) => Task.fromJsonString(taskJson)).toList();
        filteredTasks = tasks;
      });
    }
  }

  Future<void> _saveTasks() async {
    List<String> tasksJson = tasks.map((task) => task.toJsonString()).toList();
    await _prefs.setStringList('tasks', tasksJson);
  }

  void addTask(Task task) {
    setState(() {
      tasks.add(task);
      _saveTasks();
      setState(() {});
    });
  }

//Tag Filteration
  void filterTasksByTag(String tag) {
    setState(() {
      currentTag = tag;
      if (tag == "All") {
        filteredTasks = tasks;
      } else {
        filteredTasks = tasks.where((task) => task.tag == tag).toList();
      }
    });
  }

  // delete task

  void delete(int index) {
    setState(() {
      if (index >= 0 && index < tasks.length) {
        Task deletedTask = filteredTasks.removeAt(index);
        tasks.remove(deletedTask);
        _saveTasks();
        setState(() {});
      }
    });
  }

  //task completion
  void toggleTaskCompletion(int index) {
    setState(() {
      if (currentTag != 'All') {
        filteredTasks[index].isCompleted = !filteredTasks[index].isCompleted;
      } else {
        tasks[index].isCompleted = !tasks[index].isCompleted;
      }
      _saveTasks();
    });
  }

  //for demo purpose
  void pressed() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title, style: const TextStyle(fontFamily: "biocat")),
        actions: [
          PopupMenuButton<String>(
            color: Color.fromARGB(255, 249, 200, 131),
            onSelected: (value) {
              if (value == 'clear') {
                _clearAllCache();
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  height: 20,
                  value: 'clear',
                  child: Center(
                      child: const Text(
                    'Clear All',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 54, 53, 53),
                    ),
                  )),
                ),
              ];
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            filterTasksByTag("All");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 249, 200, 131),
                            foregroundColor:
                                const Color.fromARGB(255, 68, 69, 69),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(10, 30),
                          ),
                          child: const Text(
                            "All",
                            style: TextStyle(
                                fontFamily: "helvetica",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            filterTasksByTag("Birthday");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 249, 200, 131),
                            foregroundColor:
                                const Color.fromARGB(255, 68, 69, 69),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(10, 30),
                          ),
                          child: const Text(
                            "Birthday",
                            style: TextStyle(
                                fontFamily: "helvetica",
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            filterTasksByTag("Work");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 249, 200, 131),
                            foregroundColor:
                                const Color.fromARGB(255, 68, 69, 69),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(10, 30),
                          ),
                          child: const Text("Work",
                              style: TextStyle(
                                  fontFamily: "helvetica",
                                  fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            filterTasksByTag("Personal");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 249, 200, 131),
                            foregroundColor:
                                const Color.fromARGB(255, 68, 69, 69),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(5, 30),
                          ),
                          child: const Text("Personal",
                              style: TextStyle(
                                  fontFamily: "helvetica",
                                  fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {
                            filterTasksByTag("Wishlist");
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 249, 200, 131),
                            foregroundColor:
                                const Color.fromARGB(255, 68, 69, 69),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(10, 30),
                          ),
                          child: const Text("Wishlist",
                              style: TextStyle(
                                  fontFamily: "helvetica",
                                  fontWeight: FontWeight.w500)),
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 8,
                  child: ListView.builder(
                    itemCount: filteredTasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (filteredTasks.isEmpty) {
                        return const Center(
                          child: Text('No tasks available'),
                        );
                      } else {
                        final task = filteredTasks[index];
                        return Dismissible(
                          key: Key(task.name),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            delete(index);
                          },
                          background: Container(
                            color: const Color.fromARGB(255, 250, 156, 73),
                            padding: const EdgeInsets.only(left: 16),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.delete,
                                    size: 32,
                                    color: Colors.white,
                                  ),
                                  SizedBox(width: 6),
                                  Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 239, 221),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            elevation: 0.6,
                            color: const Color.fromARGB(255, 241, 227, 208),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailsPage(task: task),
                                  ),
                                );
                              },

                              // onTap: () => {
                              //   Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => inside(
                              //                 task: task,
                              //               )))
                              // },

                              child: ListTile(
                                title: Text(
                                  task.name.toString().length >= 24
                                      ? task.name.toString().substring(0, 24)
                                      : task.name.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "helvetica",
                                  ),
                                ),
                                subtitle:
                                    Text(task.date.toString().substring(0, 16)),
                                leading: Checkbox(
                                  checkColor:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  activeColor:
                                      const Color.fromARGB(255, 250, 156, 73),
                                  value: task.isCompleted,
                                  onChanged: (value) {
                                    toggleTaskCompletion(index);
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 19.0,
            right: 19.0,
            child: SizedBox(
              width: 62,
              height: 62,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddTaskPage(
                        onTaskAdded: addTask,
                      ),
                    ),
                  );
                },
                backgroundColor: const Color.fromRGBO(157, 196, 255, 0.909),
                tooltip: 'Add',
                child: const Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _clearAllCache() async {
    await _prefs.clear();
    setState(() {
      tasks.clear();
      filteredTasks.clear();
    });
  }
}
