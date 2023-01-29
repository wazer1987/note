db.createCollection('test')
db.test.insertMany([{"name":"张三","age":18},{"name":"李四","age":30}])
db.test.find()
db.test.find({"name":"张三"})
db.test.insert({"name":"北城韩雨","age":20.0})
// 覆盖更新
db.test.update({"name":"北城韩雨"},{"age":30})
// 局部更新
db.test.update({"name":"北城韩雨"},{$set:{"age":60}},{multi:true})
db.test.remove({"age":30})

// 统计查询
db.test.count()

// 按条件查询 查询 age为30 的有多少条
db.test.count({"age":30})