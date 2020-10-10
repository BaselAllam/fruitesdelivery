import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:senior/models/mainmodel.dart';
import 'package:senior/responsive/responsiveHomePage.dart';
import 'package:senior/widgets/fav.dart';



class Item extends StatefulWidget {

final String itemName;
final int itemPrice;
final String itemImage;
final int index;

Item(this.itemName, this.itemPrice, this.itemImage, this.index);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> with SingleTickerProviderStateMixin {

bool pressed = false;

AnimationController animi;


@override
void initState(){
  animi = AnimationController(duration: Duration(seconds: 1), reverseDuration: Duration(seconds: 2), lowerBound: 0.0, upperBound: 1.0, vsync: this);
  super.initState();
}

  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    return ScopedModelDescendant<MainModel>(
      builder: (context, child, MainModel model){
        return Container(
          margin: EdgeInsets.all(5.0),
          width: responsiveItemWidth(data),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                height: 105.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15.0), topLeft: Radius.circular(15.0)),
                  image: DecorationImage(
                    image: NetworkImage(widget.itemImage),
                    fit: BoxFit.fill
                  )
                ),
                alignment: Alignment.topRight,
                child: Fav(model.allProducts[widget.index].id),
              ),
              ListTile(
                title: Text(
                  widget.itemName.length > 15 ? '${widget.itemName.substring(0, 10)}...' :
                  '${widget.itemName}',
                  style:TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${widget.itemPrice.toString()}\$',
                  style:TextStyle(color: Colors.green, fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
                  shape: BoxShape.rectangle,
                ),
                padding: EdgeInsets.only(top: 2.0, bottom: 2.0),
                child: IconButton(
                  icon: AnimatedIcon(icon: AnimatedIcons.add_event, progress: animi),
                  color: Colors.white,
                  iconSize: 20.0,
                  onPressed: () {
                    setState(() {
                      if(pressed == false){
                        animi.forward();
                        pressed = true;
                      }else{
                        animi.reverse();
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}