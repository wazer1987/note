class Circle {
  double pi = 3.14;
  num r = 20;
  get rFn {
    return this.r;
  }

  set setR(value) {
    this.r = value;
  }
}

void main(List<String> args) {
  var r = new Circle();
  print(r.rFn); // 20
  r.setR = 10;
  print(r.rFn);
}
