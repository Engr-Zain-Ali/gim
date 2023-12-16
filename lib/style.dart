import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
TextStyle appStyle(double size,FontWeight fw,Color color){
  return GoogleFonts.poppins(
    fontSize:size,
    color:color,
    fontWeight:fw,
  );
}
TextStyle appStyle2(double size,FontWeight fw,Color color,double height){
  return GoogleFonts.poppins(
    height: height,
    fontSize: size,
    fontWeight: fw,
    color: color,
  );
}