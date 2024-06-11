import 'package:atividade04/bloc/manage_bloc.dart';
import 'package:atividade04/model/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNote extends StatelessWidget {
  AddNote({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary, 
        title: const Text("Gerenciar BD"),),
      body: BlocBuilder<ManageBloc, ManageState>(
        builder: (context, ManageState state) {
          if (state is UpdateState) {
            String noteId = (state).noteId;
            List<Note> noteList = state.noteList;

            for (Note note in noteList) {
              if (note.noteId == state.noteId) {
                titleController.text = note.title;
                descrController.text = note.description;
              }
            }
          }

          return Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Título"),
              ),
              TextFormField(
                controller: descrController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
              (state is UpdateState ? updateState(context) : insertState(context)),
            ],
          );
        }
      ),
    );
  }

  Widget insertState(context) {
    return ElevatedButton(onPressed: () {
      BlocProvider.of<ManageBloc>(context).add(SubmitEvent(note: Note.withData(
        title: titleController.text,
        description: descrController.text
      )));

      titleController.text = "";
      descrController.text = "";
    }, child: const Text("Insira no banco"));
  }

  Widget updateState(context) {
    return Row(
          children: [
          ElevatedButton(onPressed: () {
            BlocProvider.of<ManageBloc>(context).add(SubmitEvent(note: Note.withData(
              title: titleController.text,
              description: descrController.text
            )));

            titleController.text = "";
            descrController.text = "";
          }, child: const Text("Atualize no banco")),
          ElevatedButton(onPressed: () {
            BlocProvider.of<ManageBloc>(context).add(UpdateCancel());
          }, child: const Text("Cancele o Update")),
      ],
    );
  }
}