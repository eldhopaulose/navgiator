part of 'package:navgiator/bloc/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  @override
  void initState() {
    super.initState();
    bloc.add(_GetData)
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: BlocBuilder(builder: (BuildContext context, state) { 
        if(state is Loading){
          return ProgressIndicator()
        }else if(state is Sucess){
          
        }
      }
          FutureBuilder(
          future: context
              .read<HomeBloc>().fetchData(), // Specify the future to be awaited.
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("loading"),
            );
          }
          if (snapshot.hasData) {
            final homeDetails = snapshot.data;
            return ListView.builder(
              itemCount: snapshot.data?.data?.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  width: double.infinity,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.amber,
                  ),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: ClipOval(
                          child: Image.network(snapshot.data?.data?[index].avatar ?? "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                                "${snapshot.data?.data?[index].firstName ?? ''}  ${snapshot.data?.data?[index].lastName ?? ''}"),
                            Text(snapshot.data?.data?[index].email ?? ''),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            // Handle the case when data is null
            return const Center(
              child: Text('No data available'),
            );
          }

          // Handle the case when the data is available.
        }),
      
      
      
      
      ,)
    );
  }
}
