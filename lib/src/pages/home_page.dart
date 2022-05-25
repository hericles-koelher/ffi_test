import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:ffi_test/src/generated/generated_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final numberFieldController = TextEditingController();
  int count = 0;
  List<int> primeNumbers = List.empty();
  bool showResult = false;

  @override
  void initState() {
    super.initState();

    numberFieldController.addListener(() {
      setState(() {
        showResult = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FFI Test"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Insira um limite superior (exclusivo) para realizar uma busca por números primos!",
                textAlign: TextAlign.center,
              ),
              TextField(
                controller: numberFieldController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              if (showResult)
                Text(
                  "Primos encontrados: $count",
                ),
              if (showResult)
                SizedBox(
                  height: 30,
                  child: Scrollbar(
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: count,
                      itemBuilder: (_, index) {
                        return Text(primeNumbers[index].toString());
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        if (index != count - 1) {
                          return const Text(", ");
                        } else {
                          return const Text("");
                        }
                      },
                    ),
                  ),
                ),
              ElevatedButton(
                onPressed: () async {
                  if (numberFieldController.text.isNotEmpty) {
                    debugPrint("Implementação em C foi chamada");

                    var lib = PrimesFFI(
                      Platform.isAndroid
                          ? DynamicLibrary.open('libprimes.so')
                          : DynamicLibrary.process(),
                    );

                    var pointerPrimes = lib
                        .findPrimesUpTo(int.parse(numberFieldController.text));

                    setState(() {
                      showResult = true;
                      count = pointerPrimes.ref.count;
                      primeNumbers =
                          pointerPrimes.ref.numbers.asTypedList(count);
                    });

                    // POr algum motivo liberar isso tá dando um bug
                    // malloc.free(pointerPrimes.ref.numbers);
                    malloc.free(pointerPrimes);
                  }
                },
                child: const Text("Descobrir (Versão C vanilla)"),
              ),
              ElevatedButton(
                  onPressed: () {
                    if (numberFieldController.text.isNotEmpty) {
                      debugPrint("Implementação em Cython foi chamada");

                      // var lib = PrimesFFI(
                      //   Platform.isAndroid
                      //       ? DynamicLibrary.open('libprimes_python.so')
                      //       : DynamicLibrary.process(),
                      // );

                      // var pointerPythonPrimes = lib.pythonFindPrimesUpTo(
                      //     int.parse(numberFieldController.text));

                      // setState(() {
                      //   showResult = true;
                      //   count = pointerPythonPrimes.ref.count;
                      //   primeNumbers =
                      //       pointerPythonPrimes.ref.numbers.asTypedList(count);
                      // });

                      // malloc.free(pointerPythonPrimes.ref.numbers);
                      // malloc.free(pointerPythonPrimes);
                    }
                  },
                  child: const Text("Descobrir (Versão Cython)")),
            ],
          ),
        ),
      ),
    );
  }
}
