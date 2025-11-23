import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterProvider(
      counter: counter,
      increment: incrementCounter,
      child: MaterialApp(home: const HomePage()),
    );
  }
}

class CounterProvider extends InheritedWidget {
  final int counter;
  final VoidCallback increment;

  const CounterProvider({
    super.key,
    required this.counter,
    required this.increment,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant CounterProvider oldWidget) {
    return oldWidget.counter != counter;
  }

  static CounterProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CounterProvider>()!;
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("InheritedWidget Example")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CounterText(),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ScreenTwo()),
              );
            },
            child: const Text("Go to Screen Two"),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CounterText extends StatelessWidget {
  const CounterText({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = CounterProvider.of(context).counter;

    return Text("Counter: $counter", style: const TextStyle(fontSize: 28));
  }
}

class ScreenTwo extends StatelessWidget {
  const ScreenTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = CounterProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Screen Two")),
      body: Center(
        child: Text(
          "Screen Two Count: ${provider.counter}",
          style: const TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: provider.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
