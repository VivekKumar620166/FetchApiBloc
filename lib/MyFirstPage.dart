import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ProductDetails.dart';
import 'Product_Bloc.dart';
import 'product_event.dart';
import 'product_state.dart';


class MyFirstPage extends StatelessWidget {
  const MyFirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(FetchProduct()),
      child: Scaffold(
        drawer: Drawer(
          width: MediaQuery.of(context).size.width * 0.7, // Use 70% of screen width for drawer
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 50),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Icon(Icons.person_add_rounded, size: 40, color: Colors.white),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            child: Text(
                              "Mr.Vivek ",
                              style: TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 45),
                InkWell(

                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.edit, color: Colors.black),
                        SizedBox(width: 15,),
                        Text(
                          "Profile Setting",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),

                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: (){

                    },
                    child: Row(
                      children: [
                        Icon(Icons.home, color: Colors.black),
                        // SizedBox(width: MediaQuery.of(context).size.width * 0.1),
                        SizedBox(width: 15,),
                        Text(
                          "Address",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),



                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),

                  InkWell(
                    onTap: (){

                    },
                    child: Row(
                      children: [
                        Icon(Icons.delivery_dining, color: Colors.black),
                        SizedBox(width:15),
                        Text(
                          "Orders",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),


                      ],
                    ),
                  ),


                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: (){

                    },
                    child: Row(
                      children: [
                        Icon(Icons.account_balance_sharp, color: Colors.black),
                        SizedBox(width: 15,),
                        Text(
                          "Account Setting",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )


                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: (){

                    },
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.black),
                        SizedBox(width:15),
                        Text(
                          "Log Out",
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),


                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
         surfaceTintColor: Colors.white,
          title: Center(child: const Text("Product Fetching")),

        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductError) {
              return Center(child: Text('Error: ${state.message}'));
            } else if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return const Center(child: Text('No products found'));
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  var product = state.products[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailsScreen(
                            imageUrl: product.image!,
                            title: product.title!,
                            price: product.price!,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Image.network(
                                product.image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                product.title!,
                                style: const TextStyle(fontSize: 16),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                '\$${product.price}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}