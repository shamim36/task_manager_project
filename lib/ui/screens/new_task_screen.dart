import 'package:flutter/material.dart';
import 'package:task_manager_project/ui/widgets/profile_summary_card.dart';
import 'package:task_manager_project/ui/widgets/task_item_card.dart';
import 'package:task_manager_project/ui/widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ProfileSummaryCard(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SummaryCard(count: '09', tittle: 'Canceled'),
                SummaryCard(count: '09', tittle: 'Completed'),
                SummaryCard(count: '09', tittle: 'Progress'),
                SummaryCard(count: '09', tittle: 'New Task'),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(itemCount: 5,itemBuilder: (context,index){
              return TaskItemCard(tittle: 'Tittle will be here',description: 'Descriptions',date: 'Date: 12-12-2020',taskLabel: 'New',);
            },),
          ),
        ],
      ),
    );
  }
}


