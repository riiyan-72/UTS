import 'package:flutter/material.dart';

class TaskDetailPage extends StatefulWidget {
  final String? title;
  final String? dueDate;

  TaskDetailPage({this.title, this.dueDate});

  @override
  _TaskDetailPageState createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final TextEditingController _titleController = TextEditingController();
  String? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title ?? '';
    _dueDate = widget.dueDate;
  }

  Future<void> _selectDueDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (pickedDate != null) {
      setState(() {
        _dueDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title == null ? "Tugas Baru" : "Edit Tugas"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Judul Tugas"),
            ),
            SizedBox(height: 10), //buttron pilih tanggal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_dueDate == null ? "Belum ada tanggal !" : "Tanggal: $_dueDate"),
                ElevatedButton(
                  onPressed: () => _selectDueDate(context),
                  child: Text("Pilih Tanggal"),
                ),
              ],
            ),
            SizedBox(height: 20), //button simpan tugas
            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty) {
                  Navigator.pop(context, {
                    'title': _titleController.text,
                    'dueDate': _dueDate ?? "Tidak ada tanggal !",
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Judul tugas tidak boleh kosong!")),
                  );
                }
              },
              child: Text("Simpan Tugas"),
            ),
          ],
        ),
      ),
    );
  }
}
