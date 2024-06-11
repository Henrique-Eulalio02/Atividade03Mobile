import 'package:atividade04/bloc/manage_bloc.dart';
import 'package:atividade04/model/note.dart';
import 'package:atividade04/view/add_note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListNote extends StatelessWidget {
  const ListNote({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageBloc, ManageState>(builder: (BuildContext context, ManageState state) { 
      List<Note> noteList = state.noteList;   
      return ListView.builder(itemCount: noteList.length, itemBuilder: (context, position) {
        return ListTile(
          onTap: () {
            BlocProvider.of<ManageBloc>(context).add(UpdateRequest(noteId: noteList[position].noteId));
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddNote()));
          },
          title: Text(noteList[position].title),
          subtitle: Text(noteList[position].description),
          trailing: GestureDetector(
            onTap: () {
              BlocProvider.of<ManageBloc>(context).add(DeleteEvent(noteId: noteList[position].noteId));
            },
            child: const Icon(Icons.delete)),
        );
      });
     },);
  }
}