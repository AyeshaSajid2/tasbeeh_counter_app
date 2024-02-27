import 'package:counter_app/main_screens/tasbeeh_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
          Container(
            color: Color(0xff23190d),
            child: Column(
              children: [
                Expanded(
                    flex: 1,
                    child: Container(

                    )
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: 300,
                    height: double.infinity,
                    child: Image.asset(
                      'assets/images/rail.png',
                    //  fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            ),
      
          ),

          Column(
              children: [
                SizedBox(height: 25,),
                Text(
                  'Happy Ramadan Kareem',
                  style: GoogleFonts.abhayaLibre(
                    fontSize: 45,
                    color: Color(0xffd6a75f),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Ramdan is blessings from Allah!',
                  style: GoogleFonts.abhayaLibre(
                  fontSize: 28.0,
                  color: Color(0xffd6a75f),
                  fontWeight: FontWeight.normal,
                ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
      
      
          ],
        ),
      
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (builder)=> TasbeehScreen()));
            },
          splashColor: Color(0xffd6a75f),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          child: Icon(Icons.arrow_forward),
      ),
      ),
    );
  }
}

