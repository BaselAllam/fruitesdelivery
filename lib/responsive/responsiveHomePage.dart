import 'package:flutter/material.dart';



responsiveHomePage(MediaQueryData data) {

  double _deviceHeight = data.size.height;

  if(_deviceHeight <= 550){
    return data.size.height/2;
  }else if(_deviceHeight <= 750){
    return data.size.height/2.8;
  }else if(_deviceHeight <= 950){
    return data.size.height/3.2;
  }else{
    return data.size.height/4;
  }
}



responsiveItemWidth(MediaQueryData data){

  double _deviceWidth = data.size.width;

  if(_deviceWidth <= 420){
    return data.size.width/2;
  }else{
    return data.size.width/3;
  }
}



responsiveGrid(MediaQueryData data) {

  double _deviceHeight = data.size.height;

  if(_deviceHeight <= 550){
    return 0.6;
  }else if(_deviceHeight <= 750){
    return 0.7;
  }else if(_deviceHeight <= 820){
    return 1.1;
  }else{
    return 0.1;
  }
}