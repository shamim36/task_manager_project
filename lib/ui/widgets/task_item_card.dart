import 'package:flutter/material.dart';

class TaskItemCard extends StatelessWidget {
  const TaskItemCard({
    super.key,required this.tittle,required this.description,required this.date,required this.taskLabel
  });

  final String tittle,description,date,taskLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 6,),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tittle,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,),),
            Text(description,),
            Text(date,style: TextStyle(fontWeight: FontWeight.bold,),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Chip(label: Text(taskLabel,style: TextStyle(color: Colors.white,),),backgroundColor: Colors.blue,),
                Wrap(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.edit_document,color: Colors.green,),),
                    IconButton(onPressed: (){}, icon: Icon(Icons.delete_forever_rounded,color: Colors.red,),),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}