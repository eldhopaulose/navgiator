part of 'package:navgiator/bloc/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder(
          future: context
              .read<HomeBloc>()
              .add(_GetData), // Specify the future to be awaited.
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
                itemCount: 1,
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
                            child: Image.network(
                              "${homeData?.avatar ?? ''}",
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
                                  "${homeData?.firstName ?? ''}  ${homeData?.lastName ?? ''}"),
                              Text("${homeData?.email ?? ''}"),
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
    );
  }
}
