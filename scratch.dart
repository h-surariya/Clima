import 'dart:io';

void main() {
  performTasks();
}

void performTasks()  async{
  task1();
  var ans = await task2();
  task3(ans);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future task2()  async{
  Duration dration = Duration(seconds: 3);
  String result;
  await Future.delayed(dration, (){
    result = 'task 2 data';
    print('Task 2 complete');

  });
  return result;

}

void task3(String ans) {
  String result = 'task 3 data';
  print('Task 3 complete');
  print (ans);
}