const obj = {
  get a () {
    return 3
  },
  set a (value) {
    console.log(value);
    return obj.a = value
  }
}
console.log(obj.a);
obj.a = 10