//imports
import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {
  //sink to add in pipe,stream to get data from pipe,by pipe i mean data flow

  //List of employees
  List<Employee> _employeeList = [
    Employee(1, "Employee One", 10000.0),
    Employee(2, "Employee Two", 20000.0),
    Employee(3, "Employee Three", 30000.0),
    Employee(4, "Employee Four", 40000.0),
    Employee(5, "Employee Five", 50000.0)
  ];

  //Stream controllers
  final _employeeListStreamController = StreamController<List<Employee>>();

  //for increment
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  //for decrement
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  //Stream getter
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;
  //Sink getter
  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

  //Constructor to 
  EmployeeBloc() {
    //add data
    _employeeListStreamController.add(_employeeList);
    //listen to changes
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  //Core functions
  _incrementSalary(Employee employee) {
    double salary = employee.salary;

    double incrementedSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary = salary + incrementedSalary;

    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;

    double decrementedSalary = salary * 20 / 100;

    _employeeList[employee.id - 1].salary = salary - decrementedSalary;

    employeeListSink.add(_employeeList);
  }

  //dispose
  void dispose() {
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListStreamController.close();
  }
}
