import 'package:flutter/material.dart';
import 'task.dart';

class DetailsPage extends StatelessWidget {
  final Task task;

  const DetailsPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                task.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(6),color:const Color.fromARGB(255, 249, 200, 131),),
             
                width: 140,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: Text(
                      'Tag: ${task.tag}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Date: ${task.date.toString().substring(0, 16)}',
              style:const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                height: 250,
                width: double.infinity,
               
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(color: Colors.black,width: 1)),
                 
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Text(
                      task.taskdescp,
                      style:const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
