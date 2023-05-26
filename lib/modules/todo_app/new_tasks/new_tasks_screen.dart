import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';

class NewTasksScreen extends StatelessWidget {


 @override
  Widget build(BuildContext context) {
  var tasks=AppCubit.get(context).newTasks;
   //  انا هون بدي لسن فقط ما في داغي اعمل بلوك خاص الها ينفع السن علية ب  blocConsumer
  //ينهع السن علية باي مكات انا عايزو حتا نشاللة لو حلسن علية حول ويدجت مثلا 
    return tasksbuilder(tasks: tasks);//عملنا هيك و حطيناها بالكمبوننتس لان رح نستخدما باكتر من محل و يلي بيختلق نوع الللبستا فقط
   // import tasks from shared/components/moduls/constants
  }
}
