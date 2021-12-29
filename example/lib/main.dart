import 'package:example/sample_widget.dart';
import 'package:flutter/material.dart';
import 'package:pageviewj/pageviewj.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(),
        body: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 360,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 300,
                child: PageViewJ(
                  transform: SlowTransform(),
                  itemBuilder: pageViewItem,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 400,
                child: PageViewJ.aniBuilder(
                  aniItemBuilder: heroAniItem,
                ),
              ),
              const SizedBox(
                height: 300,
                child: PageViewJ.aniBuilder(
                  aniItemBuilder: pageviewAniItem,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 300,
                child: PageViewJ(
                  modifier: const Modifier(
                      viewportFraction: .73,
                      padEnds: false,
                      scrollDirection: Axis.vertical),
                  transform: StackTransform(),
                  itemBuilder: pageViewItem,
                ),
              ),
              SizedBox(
                height: 300,
                child: PageViewJ(
                  transform: CubeTransform(),
                  itemBuilder: pageViewItem,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 300,
                child: LayoutBuilder(builder: (context, constraints) {
                  return PageViewJ(
                    modifier: const Modifier(viewportFraction: .73),
                    transform: RotateTransform(),
                    itemBuilder: pageViewItem,
                  );
                }),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 300,
                child: PageViewJ(
                  modifier: const Modifier(scrollDirection: Axis.vertical),
                  transform: ClipTransform(),
                  itemBuilder: pageViewItem,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 300,
                child: PageViewJ(
                  modifier: const Modifier(
                      scrollDirection: Axis.horizontal, clipBehavior: Clip.none),
                  transform: FlipTransform(),
                  itemBuilder: pageViewItem,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
