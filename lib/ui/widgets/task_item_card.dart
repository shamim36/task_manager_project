import 'package:flutter/material.dart';
import 'package:task_manager_project/data/models/task.dart';
import 'package:task_manager_project/data/network_caller/network_caller.dart';
import 'package:task_manager_project/data/utility/urls.dart';
import 'package:task_manager_project/ui/widgets/snack_message.dart';

enum TaskStatus {
  New,
  Progress,
  Completed,
  Cancelled,
}

class TaskItemCard extends StatefulWidget {
  const TaskItemCard({
    super.key,
    required this.task,
    required this.chipColor, required this.onStatusChange, required this.showProgress,
  });

  final MaterialColor chipColor;
  final Task task;

  final VoidCallback onStatusChange;
  final Function(bool) showProgress;

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {

  Future<void> updateTaskStatus(String status) async {
    widget.showProgress(true);
    final response = await NetworkCaller().getRequest(Urls.updateTaskStatus(widget.task.sId ?? '', status));
    if(response.isSuccess){
      widget.onStatusChange();
    }
    widget.showProgress(false);
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.task.title ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              widget.task.description ?? '',
            ),
            Text(
              'Date : ${widget.task.createdDate}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(
                  label: Text(
                    widget.task.status ?? 'New',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: widget.chipColor,
                ),
                Wrap(
                  children: [
                    IconButton(
                      onPressed: () {
                        showUpdateStatusModal();
                      },
                      icon: const Icon(
                        Icons.edit_document,
                        color: Colors.green,
                      ),
                    ),
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: const Icon(
                    //     Icons.delete_forever_rounded,
                    //     color: Colors.red,
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showUpdateStatusModal() {


    List<ListTile> items = TaskStatus.values
        .map((e) => ListTile(
              title: Text(e.name),
              onTap: (){
                updateTaskStatus(e.name);
                Navigator.pop(context);
                showSnackMessage(context, 'Status Updated to ${e.name}');
              },
            ))
        .toList();

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: items,
              
            ),
            actions: [
              ButtonBar(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  
                ],
              ),
            ],
          );
        });
  }
}
