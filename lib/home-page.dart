part of 'package:navgiator/bloc/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  final String pin;

  const HomePage({super.key, required this.pin});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  // void initState() {
  //   super.initState();
  //   context.read<HomeBloc>().add(_GetData);
  // }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // body: BlocBuilder<HomeBloc, HomeState>(
      //   builder: (context, state) {
      //     if(state  is _loading)
      //       return CircularProgressIndicator()
      //           else if (stat is  Sucesss)
      //             // return list veiew
      //             else{
      //               return Center(child: Text("No data found"),)
      //     }
      //   },
      // ),
      body: Center(child: Text("Home")),
    );
  }
}
