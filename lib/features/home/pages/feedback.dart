import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:skf_project/core/common/loader/loader.dart';
import 'package:skf_project/core/common/widgets/indications/snackbar.dart';
import 'package:skf_project/features/home/bloc/home_bloc.dart';
import 'package:flutter/services.dart';
class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
    _FeedbackFormState createState() => _FeedbackFormState();

 // State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _feedbackController = TextEditingController();
  int _charCount = 0;
  final int _maxWords = 150;

  int _countWords(String text) {
    List<String> words =
        text.split(RegExp(r'\s+')).where((word) => word.isNotEmpty).toList();
    return words.length;
  }

  @override 
    void initState(){
      super.initState();
      _feedbackController.addListener(_updateWordCount);
    }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }


  @override 
  void _updateWordCount(){
    setState(() {
      _charCount = _feedbackController.text.trim().isEmpty
      ? 0
      :_feedbackController.text.length;


    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is SubmitFeedbackSuccessState){
          Snackbar.showSnackbar(message: state.message, leadingIcon: Icons.done, context: context);
        }
        else if(state is SubmitFeedbackFailureState){
          Snackbar.showSnackbar(message: state.message, leadingIcon: Icons.error_outline, context: context);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blue.shade400,
        appBar: AppBar(
          iconTheme:const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue.shade400,
          title: Text(
            "Feedback",
            style: GoogleFonts.nunito(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is SubmitFeedbackLoadingState) {
                return const Center(
                  child: Loader(),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Get in touch with us",
                        style: GoogleFonts.nunito(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Icon(
                      Icons.contact_page_outlined,
                      size: 35,
                      color: Colors.blue,
                    ),
                   const  SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      //height: 30,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: TextFormField(
                          controller: _feedbackController,
                          minLines: 5,
                          maxLines: 8,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(_maxWords),
                          ],
                          textAlign: TextAlign.start,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            //  contentPadding: EdgeInsets.only(bottom: 160),
                
                            border: const OutlineInputBorder(),
                            hintText: ' Type Your Feedback Here..',
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                 const  BorderSide(color: Colors.black, width: 1),
                            ),
                
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(
                        0.83, 0),
                      child: Text(
                        
                       '$_charCount /  $_maxWords words',
                      ),
                    ),
                
                
                  
                 const   SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[400],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () {
                        BlocProvider.of<HomeBloc>(context).add(
                          SubmitFeedbackEvent(message: _feedbackController.text),
                        );
                        _feedbackController.clear();
                      },
                      child: Text(
                        "Submit",
                        style: GoogleFonts.nunito(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
