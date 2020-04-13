import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:noteme/domain/notes/details/form/note_form_event.dart';
import 'package:noteme/framework/hardware/camera/camera_screen.dart';
import 'package:noteme/framework/i18n/local_factory.dart';
import 'package:noteme/framework/ioc/injection.iconfig.dart';
import 'package:noteme/generated/locale_base.dart';
import 'package:noteme/theme/colors.dart';
import 'package:noteme/theme/widgets/form/text_input_form_control.dart';
import 'package:noteme/theme/widgets/form/validators/required_validator.dart';
import 'package:noteme/theme/widgets/text_primary.dart';

import 'note_form_bloc.dart';
import 'note_form_state.dart';

class NoteForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController tagsController;
  final TextEditingController contentController;
  final List<String> attachments;

  const NoteForm(
      {Key key,
      this.titleController,
      this.tagsController,
      this.contentController,
      this.attachments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locale = NoteMeLocaleFactory.of(context);

    return Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: BlocProvider<NoteFormBloc>(
            create: (BuildContext context) => getIt<NoteFormBloc>(),
            child: BlocBuilder<NoteFormBloc, NoteFormState>(
                builder: (context, state) {
              return Form(
                  key: this.key,
                  child: Column(children: <Widget>[
                    _buildInputs(locale),
                    _buildAttachments(),
                    SizedBox(
                      height: 10,
                    ),
                    _buildCamera(context),
                  ]));
            })));
  }

  Widget _buildInputs(LocaleBase locale) {
    return Column(children: <Widget>[
      TextNoteMeInputFormControl(
        placeholder: locale.notes.title,
        controller: this.titleController,
        validator: (value) => requiredNoteMeValidator(locale, value),
      ),
      SizedBox(height: 10),
      TextNoteMeInputFormControl(
        placeholder: locale.notes.tags,
        controller: this.tagsController,
      ),
      SizedBox(height: 10),
      Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        decoration: BoxDecoration(
            color: backgroundNoteMeColor,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
            )),
        child: TextNoteMeInputFormControl(
          placeholder: locale.notes.content,
          controller: this.contentController,
          keyboardType: TextInputType.multiline,
          minLines: 7,
          maxLines: 10,
          validator: (value) => requiredNoteMeValidator(locale, value),
        ),
      ),
      SizedBox(
        height: 10,
      )
    ]);
  }

  InkWell _buildAttachments() {
    return InkWell(
      onTap: () async {
        //BlocProvider.of(context).add(NoteFormTakePictureEvent);
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: backgroundNoteMeColor,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(10.0),
                topRight: const Radius.circular(10.0),
                bottomLeft: const Radius.circular(10.0),
                bottomRight: const Radius.circular(10.0),
              )),
          child: attachments.length != 0
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: attachments.length,
                  itemBuilder: (context, idx) {
                    return InkWell(
                        onTap: () => _openAttachment(idx, context),
                        child: PrimaryText(attachments[idx]?.toString(), 10));
                  })
              : Text(attachments.length.toString())),
    );
  }

  _openAttachment(int idx, BuildContext context) {
    final attachment = attachments[idx];
    final file = File(attachment);

    showDialog(
        context: context,
        child: Dialog(
            backgroundColor: backgroundNoteMeColor, child: Image.file(file)));
  }

  InkWell _buildCamera(BuildContext context) {
    return InkWell(
      onTap: () async {
        _openCamera(context);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
        decoration: BoxDecoration(
            color: backgroundNoteMeColor,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(10.0),
              topRight: const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
            )),
        child: Image.asset(
          'assets/photo_icon.png',
          height: 48,
          width: 48,
        ),
        width: double.infinity,
      ),
    );
  }

  Future<void> _showDialog(BuildContext formContext) {
    return showDialog(
        context: formContext,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: backgroundNoteMeColor,
              content: SingleChildScrollView(
                  child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery();
                    },
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(formContext);
                    },
                  )
                ],
              )));
        });
  }

  _openGallery() {}

  _openCamera(BuildContext context) async {
    final file = await ImagePicker.pickImage(source: ImageSource.camera);
    if (file == null) {
      return;
    }

    attachments.add(file.path);

    BlocProvider.of<NoteFormBloc>(context)
        .add(NoteFormAddedAttachmentEvent(file.path, attachments));
  }
}
