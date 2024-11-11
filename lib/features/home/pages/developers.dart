import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class Developers extends StatelessWidget {
  const Developers({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blue[400],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: Text("Developers Details",style: GoogleFonts.nunito(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
        iconTheme: IconThemeData(
          color: Colors.white
        ),

      ),

      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            
               Column(
                children: [
                  Padding(
                 padding: const EdgeInsets.only(top: 20.0),
                 child: ListTile(
                  
                  leading: Icon(Icons.android_outlined,size: 30,),
                  title: Text("Android version",style: GoogleFonts.nunito(fontSize: 20,
                  fontWeight: FontWeight.bold),
                  
                  
                  ),
                  
                  subtitle: Text("0.0.1"),
                  ),
               ),

                ListTile(
                  leading: Icon(Icons.apple,size: 30,),
                  title: Text("IOS version",style: GoogleFonts.nunito(fontSize: 20,
                  fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("0.0.1"),

                ),

                ListTile(
                  leading: Icon(Icons.mail,size: 30,),
                  title:  Text("Help & Support",style: GoogleFonts.nunito(fontSize: 20,
                  fontWeight: FontWeight.bold),
                  ), 
                  subtitle: Text("vsense.tech@gmail.com"),

                ),
                ],
               ),
                   

                    Align(
                      alignment: Alignment(0, 0),
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Text(
                          'designed & developed by @Vsense technologies',style: GoogleFonts.nunito(fontSize: 16,fontWeight: FontWeight.bold),
                        ),),
                ),

          ],
          
          
        ),
        
      ),
      
    );
  }
}