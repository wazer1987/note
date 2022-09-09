class Phone {
  @deprecated
  activate() {
    this.turnOn();
  }

  turnOn() {
    print('开机');
  }
}

void main(List<String> args) {
  var p = new Phone();
  p.activate();
}
