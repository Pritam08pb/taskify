import 'package:flutter/material.dart';
import 'AddTaskPage.dart';
import 'task.dart';
// ignore: unused_import
import 'package:shared_preferences/shared_preferences.dart';

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
      home: const MyHomePage(title: 'Taskify'),
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

  List<Task> filteredTasks = []; // Add a new list to hold filtered tasks
  String currentTag = "All"; // Track the current tag selected


 @override
  void initState() {
    super.initState();
    // Assuming tasks are loaded from somewhere else, like SharedPreferences
    // loadTasks();
    tasks = []; // Initialize tasks list
    filteredTasks = tasks; // Initialize filtered tasks list
  }

  // Method to filter tasks based on tag
  void filterTasksByTag(String tag) {
    setState(() {
      currentTag = tag; // Update the current tag
      if (tag == "All") {
        filteredTasks = tasks; // Show all tasks if tag is "All"
      } else {
        filteredTasks = tasks.where((task) => task.tag == tag).toList(); // Filter tasks by tag
      }
    });
  }

  // adding task
  void addTask(Task task) {
    setState(() {
      tasks.add(task);
    });
  }

  // delete task
  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  //task completion
  void toggleTaskCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
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
                            deleteTask(index);
                          },
                          background: Container(
                            color: const Color.fromARGB(255, 250, 156, 73),
                            padding: const EdgeInsets.only(left: 16),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 239, 221),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero),
                            elevation: 0.6,
                            color: const Color.fromARGB(255, 241, 227, 208),
                            child: ListTile(
                              title: Text(
                                task.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "helvetica",
                                ),
                              ),
                              subtitle: Text(task.date.toString()),
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
}
