import 'package:flutter/material.dart';
import 'TaskDetailPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> tasks = [];

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Tugas telah dihapus !")),
    );
  }

  void _showDeleteDialog(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) { //Hapus Tugas
        return AlertDialog(
          title: Text("Hapus Tugas?"),
          content: Text("Yakin ingin menghapus tugas ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text("Batalkan"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                _deleteTask(index);
              },
              child: Text("Hapus"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Tugas")),
      body: tasks.isEmpty
          ? Center(child: Text("Belum ada tugas"))
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index]['title'] ?? ''),
                  subtitle: Text("Tanggal: ${tasks[index]['dueDate']}"),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _showDeleteDialog(index),
                  ),
                  onTap: () async {
                    var updatedTask = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailPage(
                          title: tasks[index]['title']!,
                          dueDate: tasks[index]['dueDate']!,
                        ),
                      ),
                    );
                    if (updatedTask != null) {
                      setState(() {
                        tasks[index] = updatedTask;
                      });
                    }
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton( //button tambah
        onPressed: () async {
          var newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailPage(),
            ),
          );
          if (newTask != null) {
            setState(() {
              tasks.add(newTask);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
