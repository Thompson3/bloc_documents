// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:bloc_class/business_logic/cubit/counter_cubit.dart';
import 'package:bloc_class/business_logic/cubit/internet_cubit.dart';
import 'package:bloc_class/constants/enums.dart';
import 'package:bloc_class/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirstHomeScreen extends StatefulWidget {
  const FirstHomeScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<FirstHomeScreen> createState() => FirstHomeScreenState();
}

class FirstHomeScreenState extends State<FirstHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /// since it rebuild and listens, i had to keep after blocListener for smooth operation
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi) {
                  return Text(
                    'Wi-Fi',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.green,
                        ),
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile) {
                  return Text(
                    'Mobile',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.red,
                        ),
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.grey,
                        ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            Divider(
              height: 5,
            ),
            // This Bloc handles multiples which is the cubit(has the instructor) and the state(passes the instruction from cubit the desired file)
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Adding'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Reducing'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                String counterText = state.counterValue.toString();
                if (state.counterValue < 0) {
                  counterText = 'Is below, please add numbers $counterText';
                } else if (state.counterValue == 1) {
                  counterText = 'Yes, you just added $counterText';
                } else if (state.counterValue == 3) {
                  counterText = 'Keep going, boss $counterText';
                } else if (state.counterValue == 5) {
                  counterText = 'Thank you, boss $counterText';
                }

                return Text(
                  counterText,
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.deepPurple,
              child: Text('To Home screen'),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                        value: CounterCubit(),
                        child: HomeScreen(
                            title: 'Home Page', color: Colors.yellow))));
              },
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Colors.greenAccent,
              child: Text(
                'Go to Third Screen',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/second');
              },
            ),
          ],
        ),
      ),
    );
  }
}
