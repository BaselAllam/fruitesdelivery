import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:senior/models/mainmodel.dart';
import 'package:senior/responsive/responsiveHomePage.dart';
import 'package:senior/screens/result.dart';
import 'package:senior/widgets/item.dart';
import 'package:senior/widgets/loading.dart';



class HomePage extends StatefulWidget {

final MainModel model;

HomePage(this.model);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

List<String> drawerItemTitle = [
  'My Account', 'Add Item', 'Setting', 'Contact Us', 'About Us'
];

List<IconData> drawerItemIcon = [
  Icons.account_circle, Icons.add, Icons.settings, Icons.phone, Icons.info
];

List drawerClasses = [
  'account', 'addItem', 'setting', 'contact', 'about',
];

final TextEditingController searchController = TextEditingController();

bool pressed = false;


@override
void initState(){
  widget.model.fetchProduct(null);
  super.initState();
}


@override
void dispose(){
  widget.model.allProducts.clear();
  super.dispose();
}

  @override
  Widget build(BuildContext context) {
    var data = MediaQuery.of(context);
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: drawerItemTitle.length,
            itemBuilder: (context, index){
              return Container(
                child: ListTile(
                  leading: Icon(
                      drawerItemIcon[index],
                      color: Colors.black,
                      size: 20.0
                    ),
                  title: Text(
                      drawerItemTitle[index],
                      style: TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                  trailing: Icon(
                      Icons.navigate_next,
                      color: Colors.black,
                      size: 20.0
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, drawerClasses[index]);
                    },
                ),
              );
            }
          ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Container(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              height: 200.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pic3'),
                  fit: BoxFit.fill
                ),
              ),
              child: Container(
                    padding: EdgeInsets.only(bottom: 15.0),
                    decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/pic'),
                      fit: BoxFit.fill
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ListTile(
                        leading: Builder(
                          builder: (BuildContext context){
                            return IconButton(
                            icon: Icon(Icons.menu),
                            color: Colors.white,
                            iconSize: 20.0,
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                          );
                          },
                        ),
                        title: pressed == false ? Text(
                          'Senior',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          ),
                        ) : Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                          height: 40.0,
                              child: TextField(
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(color: Colors.black, width: 0.5),
                                  ),
                                  labelText: 'ex: Apple',
                                  labelStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                                ),
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.search,
                                controller: searchController,
                              ),
                            ),
                        trailing: IconButton(
                          icon: Icon(pressed == false ? Icons.search : Icons.close),
                          color: Colors.white,
                          iconSize: 20.0,
                          onPressed: () {
                            setState(() {
                              pressed = !pressed;
                            });
                          }
                        ),
                      ),
                      Text(
                        'Season Sale',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        '-40%',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 55.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        'off',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
            ),
            ListTile(
              leading: Text(
                'Popular...',
                style:TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.navigate_next, color: Colors.black, size: 20.0),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {return Result('Popular');}));
              },
            ),
            Container(
              height: responsiveHomePage(data),
              child: itemScroll()
            ),
            ListTile(
              leading: Text(
                'New Arrival...',
                style:TextStyle(color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              trailing: Icon(Icons.navigate_next, color: Colors.black, size: 20.0),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {return Result('New Arrival');}));
              },
            ),
            Container(
              height: responsiveHomePage(data),
              child: itemScroll()
            ),
          ],
        ),
      ),
    );
  }
 itemScroll() {
   return ScopedModelDescendant<MainModel>(
     builder: (context, child, MainModel model){
       if(model.isProductloading == true){
         return Center(child: Loading());
       }else if(model.allProducts.length < 1){
         return Center(child: Text('No Item Found!'));
       }else{
         return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: model.allProducts.length,
            itemBuilder: (context, index){
              return Item(model.allProducts[index].name, model.allProducts[index].price, model.allProducts[index].image, index);
          },
        );
       }
     }
   );
 } 
}