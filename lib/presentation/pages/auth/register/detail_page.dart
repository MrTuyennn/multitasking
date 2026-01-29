import 'package:flutter/material.dart';
import 'package:multitasking/app/log/logger_service_impl.dart';
import 'package:multitasking/presentation/pages/provider/couter.dart';
import 'package:provider/provider.dart';

import 'model/todo.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.todo});

  final Todo todo;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    logger.d('calll Api ${widget.todo.toJson()}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Detail Page ${widget.todo.id}'),
          Text('Title: ${widget.todo.title}'),
          Text('Description: ${widget.todo.description}'),
          Selector<CouterProvider, int>(
            builder: (_, count, _) {
              return Text(count.toString());
            },
            selector: (_, p) => p.count,
          ),
          GestureDetector(
            onTap: () {
              context.read<CouterProvider>().increment();
            },
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.blue,
              child: Text('Increment'),
            ),
          ),
        ],
      ),
    );
  }
}
