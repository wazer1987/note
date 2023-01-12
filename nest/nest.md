# Nest

## 安装

```js
 npm i @nestjs/cli -g
```

## 创建

```js
nest new project-name
```

## 项目启动

### 启动

```js
npm run start 就启动了
```

### 结构目录

```markdown
1. 首先就是我们的main 文件 当我们 npm run start 的时候 就是执行了main文件
2. 然后每个业务都有 module文件  service 文件   和 controller 文件
3. 每个文件都采用装饰器 的写法帮你完成了一些服务
```

- main.ts

```typescript
// nest 核心
import { NestFactory } from '@nestjs/core';
// AppModule模块
import { AppModule } from './app.module';
// 启动服务
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(3000);
}
bootstrap();
```

- app.module.ts

```typescript
// 引入装饰器
import { Module } from '@nestjs/common';
// 引入控制层
import { AppController } from './app.controller';
// 引入服务层
import { AppService } from './app.service';
// 使用装饰器 如果我们还有别的接口模块 就会在controllers 里 注入 如下
// controllers: [AppController,CatController],
@Module({
  imports: [],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
```

- app.controller.ts

```typescript
// 每一个 controller 我们就可以理解为是一个功能模块 最后这些controller的文件都会 传入 module的 Module 装饰器里

import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
// 装饰器里面可以传对应的路径基本参数 这样访问就是 localhost:3000/v1/
// @Controller('/v1') 
@Controller() 
export class AppController {
  // 这里就是依赖注入 相当于 在当前 AppController 自动帮我实例了一个 AppService 挂载到了当前实例上
  constructor(private readonly appService: AppService) {}
  // 跟我们controller 装饰器一样 这里也可以传入路径localhost:3000/v1/hello 
  // @Get('hello') 这相当于一个 get请求
  @Get()  
  getHello(): string {
    return this.appService.getHello();
  }
}
```

- app.service.ts

```typescript
import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World! <br/> nest';
  }
}
// 最后页面访问 localhost3000 返回3000端口
```

- app.controller.spec.ts

```typescript
// 这个就是 单元测试文件了
import { Test, TestingModule } from '@nestjs/testing';
import { AppController } from './app.controller';
import { AppService } from './app.service';

describe('AppController', () => {
  let appController: AppController;

  beforeEach(async () => {
    const app: TestingModule = await Test.createTestingModule({
      controllers: [AppController],
      providers: [AppService],
    }).compile();

    appController = app.get<AppController>(AppController);
  });

  describe('root', () => {
    it('should return "Hello World!"', () => {
      expect(appController.getHello()).toBe('Hello World!');
    });
  });
});
```

## 控制器和路由

### 常用命令

```js
一下就是nest cli 给我们提供的一些常用命令 比如 nest g co cat 就创建了一个名为 cat的文件夹 下面有一些cat的控制器

application   │ application │ Generate a new application workspace         │
│ class         │ cl          │ Generate a new class                         │ 
│ configuration │ config      │ Generate a CLI configuration file            │
│ controller    │ co          │ Generate a controller declaration            │
│ decorator     │ d           │ Generate a custom decorator                  │
│ filter        │ f           │ Generate a filter declaration                │
│ gateway       │ ga          │ Generate a gateway declaration               │
│ guard         │ gu          │ Generate a guard declaration                 │
│ interceptor   │ itc         │ Generate an interceptor declaration          │
│ interface     │ itf         │ Generate an interface                        │
│ middleware    │ mi          │ Generate a middleware declaration            │
│ module        │ mo          │ Generate a module declaration                │
│ pipe          │ pi          │ Generate a pipe declaration                  │
│ provider      │ pr          │ Generate a provider declaration              │
│ resolver      │ r           │ Generate a GraphQL resolver declaration      │
│ service       │ s           │ Generate a service declaration               │
│ library       │ lib         │ Generate a new library within a monorepo     │
│ sub-app       │ app         │ Generate a new application within a monorepo │
│ resource      │ res         │ Generate a new CRUD resource
```

### 创建controller

```js
// 这样就在我们的工程目录下 创建了一个 cat 的 文件夹 下面 cat.controller 文件 和 cat.ontroller.spec.ts测试文件
nest g co cat
```

```typescript
import { Controller } from '@nestjs/common';
@Controller('cat')
export class CatController {}
```

```js
// 同时 还会 在我们的 app.module.ts 里面 把我们的 CatController 注入进去
app.module.ts 文件

import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { CatController } from './cat/cat.controller';

@Module({
  imports: [],
  // 这里使用命令 nest g co cat 之后  CatController自动被写入了 Module 里
  controllers: [AppController, CatController],
  providers: [AppService],
})
export class AppModule {}

```

### 创建service

```js
// 会自动在我们的创建好的 cat 文件下 创建 cat.service.ts文件
nest g s cat
```

```js
// 这里我们需要把我们写好的 cat.service.ts 注入到我们的cat.controller.ts里面

import { Controller } from '@nestjs/common';
import { CatService } from './cat.service';

@Controller('cat')
export class CatController {
  // 向这样 就会默认 在我们的   CatController 实例上 挂在 CatService 实例 就可以调用了 CatService方法
  constructor(private readonly apiService: CatService) {}
  // 这样访问get请求的 访问cat 就走到我们的 cat模块里了
  @Get()
  say() {
    return this.apiService.say();
  }
}
```

## 请求传参

### get

```markdown
1. 可以在 controller 里的函数 里面的参数 使用装饰器的形式 拿到参数
```

```typescript
// 查询字符串形式
http://localhost:3000/cat?name=zs&age=14
// 接收参数
import { Controller, Get, Query } from '@nestjs/common';
import { query } from 'express';
import { CatService } from './cat.service';

@Controller('cat')
export class CatController {
  constructor(private readonly apiService: CatService) {}
  @Get()
  // 需要在 方法名称里 写   @Query() query: Record<string, any> 接收
  say(@Query() query: Record<string, any>) {
    console.log(query, '====query');
    return query;
    // return this.apiService.say();
  }
}

```

### 动态路由传参

```markdown
1. 需要在 控制器的 Get 装饰器里 写入 动态传入的参数名称
2. 需要在 方法参数里 写入 @params(参数名称) 参数名称
3. delete 也一致 只不过 要用@delete 装饰器
```

```typescript
// 访问路径
http://localhost:3000/cat/user/5

import { Controller, Get, Param, Query } from '@nestjs/common';
import { CatService } from './cat.service';

@Controller('cat')
export class CatController {
  constructor(private readonly apiService: CatService) {}
  // 1. 需要在 Get 装饰器里 写入  你的动态参数 比如这里我们是叫id
  @Get('/user/:id')
  // 2. 然后在方法里参数里 写入 params 注册你的动态参数   
  say1(@Param('id') id: string) {
    return id; // 最后这里页面返回是 5
  }
}
```

```typescript
// 也可以如下方式取接收 

import { Controller, Get, Param, Query } from '@nestjs/common';
// import { query } from 'express';
import { CatService } from './cat.service';

@Controller('cat')
export class CatController {
  constructor(private readonly apiService: CatService) {}
  // 动态路由接收参数	
  @Get('/age/:age')
  // 采用如下函数参数去接收
  say2(@Param() params: { age: number }) {
    return Number(params.age);
  }
}
```

### post

```markdown
1. 使用@Post() 装饰器 装饰方法
2. 在方法参数中 使用@Body装饰器 来装饰参数 即可拿到post参数
3. put请求 和post 一样 只不过要用@put 装饰器
```

```typescript
// POST 请求
http://localhost:3000/cat/login

import { Body, Controller, Get, Param, Post, Query } from '@nestjs/common';
import { CatService } from './cat.service';

@Controller('cat')
export class CatController {
  constructor(private readonly apiService: CatService) {}
    
  @Post('/login')
  2. 使用 @Body 装饰器 来装饰 方法参数 
  say3(@Body() userForm: { username: string; password: string }) {
    return userForm;
  }
}
```

## 提供者

```markdown
1. 可以理解为字段的实力类
2. 主要是校验前端传给的数据
3. 前端传给的数据 不可能什么字段都接 所以就需要校验你
```

- 使用

```markdown
1. 首先就创建 实力类文件 通常我们已dto的后缀来标识
2. 也可以继承接口
```

```typescript
// CreateCat.dto.ts 文件 
import { Cat } from '../interface/cat.interface';

export class CreateCat implements Cat {
  name: string;
  age: number;
  height: string;
}

// cat.interface.ts 文件
export interface Cat {
  name: string;
  age: number;
  height: string;
}
```

```typescript
import { Body, Controller, Get, Param, Post, Query, Req } from '@nestjs/common';
import { Request } from 'express';
import { CatService } from './cat.service';
// 引入我们的实例类型
import { CreateCat } from './dto/CreateCat.dto';

@Controller('cat')
export class CatController {
  constructor(
    private readonly apiService: CatService,
    private readonly createCatentity: CreateCat,
  ) {}
  @Post('/catdetail')
  // 这里就可以有类型判断了  
  say4(@Body() info: CreateCat) {
    console.log(info, '==info');
    return info;
  }
}
```

### 依赖注入

```typescript
import { Body, Controller, Get, Param, Post, Query, Req } from '@nestjs/common';
import { Request } from 'express';
import { CatService } from './cat.service';
import { CreateCat } from './dto/CreateCat.dto';

@Controller('cat')
export class CatController {
  constructor(
    private readonly apiService: CatService,
    // 如果这里我们可以以注入的方式 直接可以在当前实例上调用 那么则需要在 Module 装饰器里的 providers中提供
    // import { CreateCat } from './cat/dto/CreateCat.dto';
    //    @Module({
    //      imports: [],
    //      controllers: [AppController, CatController],
    //      providers: [AppService, CatService, CreateCat],
    //    })
     
    private readonly createCatentity: CreateCat,
  ) {}
  @Post('/catdetail')
  say4(@Body() info: CreateCat) {
    // 这样就可以直接在当前实例上使用了  
    console.log(this.createCatentity, '==createCatentity');

    console.log(info, '==info');
    return info;
  }
}
```

## 中间件

### 创建

```js
// 这样就创建了一个 叫 logger的中间件  
nest g mi logger

logger.middleware.spec.ts
logger.middleware.ts
```

### 使用

- 注册中间件

```markdown
1. 需要在  app.module.ts 文件中 注入
```

```typescript
import { MiddlewareConsumer, Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { CatController } from './cat/cat.controller';
import { CatService } from './cat/cat.service';
import { CreateCat } from './cat/dto/CreateCat.dto';
// 引入中间件
import { LoggerMiddleware } from './logger.middleware';

@Module({
  imports: [],
  controllers: [AppController, CatController],
  providers: [AppService, CatService, CreateCat],
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    // 这里代表 当你访问 cat 的路由路径的时候 会先走你的 LoggerMiddleware 中间件
    // forRoutes 方法里也可以写入 通配符 forRoutes({ path: 'ab*cd', method: RequestMethod.ALL });
    // 以上路由 只有 包含 abcd ab_cd ... 等等路由字符都会匹配到 走这个中间件  
    consumer.apply(LoggerMiddleware).forRoutes('cat');
  }
}
```

```typescript
//logger.middleware.ts 文件

import { Injectable, NestMiddleware } from '@nestjs/common';

@Injectable()
export class LoggerMiddleware implements NestMiddleware {
  use(req: any, res: any, next: () => void) {
    // 这里就可以做一些事情  
    console.log(req, '===req');
    // 然后调用 你的路由处理函数  
    next();
  }
}

```

- 多个中间件

```typescript
import { MiddlewareConsumer, Module, RequestMethod } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { CatController } from './cat/cat.controller';
import { CatService } from './cat/cat.service';
import { CreateCat } from './cat/dto/CreateCat.dto';
import { LoggerMiddleware } from './logger.middleware';
import { TestMiddlMiddleware } from './test-middl.middleware';

@Module({
  imports: [],
  controllers: [AppController, CatController],
  providers: [AppService, CatService, CreateCat],
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    // 这里代表 当你访问 cat 的路由路径的时候 会先走你的 LoggerMiddleware 中间件
    consumer
      // 可以应用多个中间件 只有cat 路由下的 get请求方法才会走此中间件
      .apply(LoggerMiddleware, TestMiddlMiddleware)
      .forRoutes({ path: 'cat', method: RequestMethod.GET });
  }
}
```

- 排除

```typescript
consumer
  .apply(LoggerMiddleware)
  // 也可以排除 同个路由下的某个方法 不走此中间件	
  .exclude(
    { path: 'cats', method: RequestMethod.GET },
    { path: 'cats', method: RequestMethod.POST },
    'cats/(.*)',
  )
  .forRoutes(CatsController);
```

### 函数式中间件

```markdown
1. 使用方法 和我们的 nest g mi 创建出来的一致
2. 只不过 此中间件是个函数 接收如下参数 
```

```typescript
export function logger(req, res, next) {
  console.log(`Request...`);
  next();
};
```

```typescript
// 在 AppModule  中使用
consumer
  .apply(logger)
  .forRoutes(CatsController);
```

### 全局中间件

```markdown
1. 这里就需要像koa 一样 使用 use方法了
2. 我们可以在 main.ts  中的 bootstrap 函数中使用
```

```typescript
// 全局中间件
const app = await NestFactory.create(AppModule);
app.use(logger);
await app.listen(3000);
```

## 异常处理

```markdown
1. 当我们请求或者访问找不到路径的时候 nest 会自动抛出异常
2. 走的都是 HttpException类
```

### 抛出异常

```typescript

http://localhost:3000/cat/error  这个路径是可以正常访问的  不会走到catch里 

import {
  Body,
  Controller,
  Get,
  HttpException,
  HttpStatus,
  Param,
  Post,
  Query,
  Req,
} from '@nestjs/common';

@Get('/error')
  say5() {
    try {
      return {
        message: '调用成功',
      };
    } catch (error) {
      throw new HttpException(
          http://localhost:3000/cat/error/3 这样就会走到catch 里了 抛出了 HttpException 异常
        {
          status: HttpStatus.FORBIDDEN,
          error: 'This is a custom message',
        },
        HttpStatus.FORBIDDEN,
      );
    }
  }
```

### 自定义异常

```markdown
1. 我们可以通过 继承 HttpException 异常基类 来自定义异常
```

```typescript
export class ForbiddenException extends HttpException {
  constructor() {
    super('Forbidden', HttpStatus.FORBIDDEN);
  }
  // 自定义方法
}

// 使用 
@Get()
async findAll() {
  throw new ForbiddenException();
}
```

### 异常基础类

```markdown
1. nest 内置了一些异常基础类
2. 有服务错误的 网关失败的 等等
BadRequestException无效请求400
UnauthorizedException未授权401
NotFoundException未找到资源404
ForbiddenException禁止访问指定资源403 
NotAcceptableExceptionaccept头中未在列的响应内容406
RequestTimeoutException请求超时408
ConflictException冲突异常409
GoneException请求资源不再可用410
HttpVersionNotSupportedExceptionHTTP版本不支持505
PayloadTooLargeException提交请求的载荷（数据）过大413
UnsupportedMediaTypeException不支持的媒体类型415
UnprocessableEntityException无法处理的实体422
InternalServerErrorException内部服务器错误（一般错误）500
NotImplementedException不支持的功能501
ImATeapotExceptionTeapot418MethodNotAllowedExceptionaccept头中不可接受的请求方式405
BadGatewayException上游服务的异常导致502
ServiceUnavailableException服务不可用503
GatewayTimeoutException网关相应超时504
PreconditionFailedException请求头中给定的前提条件false412

```

```typescript
// 使用@Get('/error')
  say5() {
    // 使用内置类 抛出异常  
    throw new ServiceUnavailableException();
  }
```

### 异常过滤器

```markdown
1. 当我们需要根据不同的异常类型 做不同的 业务逻辑的时候 比如 编写日志 就可以使用到异常过滤器
```

- 定义

```typescript
http-exception.filter.ts 
import {
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
} from '@nestjs/common';
import { Request, Response } from 'express';

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();
    const request = ctx.getRequest<Request>();
    const status = exception.getStatus();
    console.log('走了异常过滤器');

    response.status(status).json({
      statusCode: status,
      timestamp: new Date().toISOString(),
      path: request.url,
    });
  }
}

```

- 使用

```markdown
1. 可以在 路由上使用
2. 也可以在controller 上使用 
3. 也可以在全局使用
```

```typescript
// 这里要调用   UseFilters 去使用 装饰器里传入 刚刚定义好的 异常过滤器
import { UseFilters } from '@nestjs/common';
@Get('/error')
@UseFilters(HttpExceptionFilter)
say5() {
   throw new ServiceUnavailableException();
}

// 在controller 层上使用 就是把 @UseFilters(HttpExceptionFilter) 加载 @controller下面
```

```typescript
// 全局使用
引入过滤器
import { HttpExceptionFilter } from 'xxxxxx';
// 然后使用
const app  = await NestFactory.create(AppModule)
app.useGlobalFilters(HttpExceptionFilter())
```

## 管道

```markdown
1. 主要是 用来 转换数据 校验数据的
2. 可以理解为 参数传递的时候 经过管道处理后 在返回给 路由
3. nest 提供了一些内置管道 方便 对数据进行处理
```

```typescript
// 比如 转换 整数 等等
ValidationPipe
ParseIntPipe
ParseFloatPipe
ParseBoolPipe
ParseArrayPipe
ParseUUIDPipe
ParseEnumPipe
DefaultValuePipe
ParseFilePipe
```

```typescript
// 引入了 内置管道 用来把字符串转换为 数字
import { ParseIntPipe,} from '@nestjs/common';
@Get('/pipe/:id')
  // 在参数装饰器中使用	
  say6(@Param('id', ParseIntPipe) id: number) {
    console.log(typeof id); number
    return { id };
  }
```

### 自定义管道

```typescript
import { PipeTransform, Injectable, ArgumentMetadata } from '@nestjs/common';

@Injectable()
export class ValidationPipe implements PipeTransform {
  transform(value: any, metadata: ArgumentMetadata) {
    // value 是你传递的参数  
    console.log(value, '====value');
    // metadata 是元数据 比如参数字段 和 传参的类型是params 还是等等  
    console.log(metadata, '====metadata');
    return value;
  }
}
```

```typescript
// 使用方法 和我们的 内置管道使用方法一致
 @Get('/pipe/:id')
  async findOne(
    @Param('id', ValidationPipe)
    id: number,
  ) {
    // return this.catsService.findOne(id);
    return '成功';
  }
```

### 字段校验

```markdown
1. 首先 也是用管道去做的 
2. 需要依赖两个库 class-validator 用来校验字段  class-transformer 用来把参数生成实例类的
```

```typescript
// 首先我们还是要  有一个数据模型类 然后里面 用 class-validator 给我们提供的生成器函数 来写校验
import { IsNotEmpty, IsNumber, IsString } from 'class-validator';

export class RegisterInfoDTO {
  // 用   IsNotEmpty 提供的 装饰器 来校验字段
  @IsNotEmpty({ message: '用户名不能为空' })
  readonly accountName: string | number;
  @IsNotEmpty({ message: '真实姓名不能为空' })
  @IsString({ message: '真实姓名必须是 String 类型' })
  readonly realName: string;
  @IsNotEmpty({ message: '密码不能为空' })
  readonly password: string;
  @IsNotEmpty({ message: '重复密码不能为空' })
  readonly repassword: string;
  @IsNotEmpty({ message: '手机号不能为空' })
  @IsNumber()
  readonly mobile: number;
  readonly role?: string | number;
}

```

```typescript
// 然后在路由中 我们把接收的参数类型指定为我们上面写的数据模型 这里直接就应用我们的管道 
// @UsePipes(ValidationPipe)
@Post('/user')
  say6(@Body(ValidationPipe) userInfo: RegisterInfoDTO) {
    console.log(userInfo, '===userInfo');
    return '成功';
  }
```

```typescript
// 管道

import {
  ArgumentMetadata,
  BadRequestException,
  Injectable,
  PipeTransform,
} from '@nestjs/common';
import { validate } from 'class-validator';
import { plainToClass } from 'class-transformer';

@Injectable()
export class ValidationPipe implements PipeTransform {
  async transform(value: any, { metatype }: ArgumentMetadata) {
    console.log(`value:`, value, 'metatype: ', metatype);
    if (!metatype || !this.toValidate(metatype)) {
      // 如果没有传入验证规则，则不验证，直接返回数据
      return value;
    }
    // 将我们传递过来的参数 转换为类
    const object = plainToClass(metatype, value);
    console.log(object, '====object');
    // 然后校验 我们定义好的 dto数据模型的规则 如果有错误 errors 就会有长度
    const errors = await validate(object);
    console.log(errors, '====errors');

    if (errors.length > 0) {
      const msg = Object.values(errors[0].constraints)[0]; // 只需要取第一个错误信息并返回即可
      // Logger.error(`Validation failed: ${msg}`);
      // 然后抛出异常   
      throw new BadRequestException(`Validation failed: ${msg}`);
    }
    return value;
  }

  private toValidate(metatype: any): boolean {
    const types: any[] = [String, Boolean, Number, Array, Object];
    return !types.includes(metatype);
  }
}
```

### 全局管道

```typescript
async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  // 使用全局管道  
  app.useGlobalPipes(new ValidationPipe());
  await app.listen(3000);
}
bootstrap();
```

### 提供默认值

```typescript
// 当参数 为空的时候 或者验证不通过 我们可以提供一个默认值 在走进默认管道
@Get()
async findAll(
  @Query('activeOnly', new DefaultValuePipe(false), ParseBoolPipe) activeOnly: boolean,
  @Query('page', new DefaultValuePipe(0), ParseIntPipe) page: number,
) {
  return this.catsService.findAll({ activeOnly, page });
}
```

## 守卫

```markdown
1. 守卫是一个使用 @Injectable() 装饰器的类。 守卫应该实现 CanActivate 接口
2. 可以作用在 全局 controller 和 路由方法中
```

### 使用

```typescript
import { Injectable, CanActivate, ExecutionContext } from '@nestjs/common';
import { Observable } from 'rxjs';

@Injectable()
export class UserGuard implements CanActivate {
  canActivate(
    context: ExecutionContext,
  ): boolean | Promise<boolean> | Observable<boolean> {
    const request = context.switchToHttp().getRequest();
    // 在这里 就可以拿到 请求对象 参数 路径 等
    const authorization = request.header('authorization');
    if (!authorization) {
      console.log(222);

      return false;
    }
    // 在这里面就可以校验逻辑 返回 true 或者 false  或者自己抛出异常等    
    return authorization === 'token';
  }
}

```

```typescript
// 在路由方法中使用
import { Body, Controller, Post, Get, UseGuards } from '@nestjs/common';
import { UserInfo } from './user.dto';
import { UserGuard } from './user.guard';
import { UserPipe } from './user.pipe';
@UseGuards(UserGuard) // 也可以在 controller 中使用
@Controller('user')
export class UserController {
  user_info: UserInfo;
  @Post('/login')
  login(@Body(UserPipe) userInfo: UserInfo) {
    this.user_info = userInfo;
    return {
      token: 'token',
    };
  }
  @UseGuards(UserGuard)
  @Get('/userinfo')
  getUser() {
    return this.user_info;
  }
}
```

```typescript
// 全局中使用 

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  // 由于main.ts启动时并未初始化依赖注入容器，所以依赖必须手动传入，一般情况下不建议使用全局守卫，因为依赖注入得自己解决。
  app.useGlobalGuards(new UserGuard(new UserService()));
  await app.listen(3000);
}

bootstrap();

```

## 拦截器

```markdown
1.  拦截器 需要手动调用 在会执行最终的处理程序 也就是 要在拦截器方法里调用 方法 来 执行最后的路由
2.  拦截器 和守卫一样 分为 全局 和 controller 还是有 路由
```

### 定义

```typescript
import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

@Injectable()
export class LoggingInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    // 进入 路由的时候 会先执行这个拦截器
    console.log('Before...');

    const now = Date.now();
    console.log(now, '====now');
    // 然后手动调用 next.handle() 函数 pipe 后面 是 当你路由程序执行完毕之后  在调用的函数
    return next
      .handle()
      .pipe(tap(() => console.log(`After... ${Date.now() - now}ms`)));
  }
}
```

```typescript
import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Observable } from 'rxjs';
import { map, tap } from 'rxjs/operators';

@Injectable()
export class LoggingInterceptor implements NestInterceptor {
  intercept(context: ExecutionContext, next: CallHandler): Observable<any> {
    // 进入 路由的时候 会先执行这个拦截器
    console.log('Before...');

    const now = Date.now();
    console.log(now, '====now');
    // 然后手动调用 next.handle()  函数 pipe 后面 是 当你路由程序执行完毕之后  在调用的函数
    //   next.handle() 可以理解为就是你的路由处理程序 pipe 就是 后续处理程序
    return next.handle().pipe(
      map((data) => {
        console.log(data, '===data');
        return data === '成功' ? '走拦截器' : '不走拦截器';
      }),
    );
  }
}
```



### 使用

```typescript
import { Controller, Get, UseInterceptors } from '@nestjs/common';
import { LoggingInterceptor } from './interceptors';
@Controller('interceptors')
export class InterceptorsController {
  // 进入这个路由的时候 会先进入到拦截器 然后拦截器 手动调用 执行这个路由的程序 
  @UseInterceptors(LoggingInterceptor)
  @Get()
  interceptor() {
    return '成功';
  }
}

```

```typescript
// 在 controller 层使用
@UseInterceptors(new LoggingInterceptor())
export class CatsController {}

// 在全局使用
const app = await NestFactory.create(ApplicationModule);
app.useGlobalInterceptors(new LoggingInterceptor());
```

## 自定义装饰器

```markdown
1. 我们可以 自定义类装饰器 和 参数装饰器等
```

### 定义

```dart
import { createParamDecorator, ExecutionContext } from '@nestjs/common';
// 这里的data: unknown 就是你传入装饰器的参数
export const User = createParamDecorator((data: unknown, ctx: ExecutionContext) => {
  // 拿到了 上下文对象 获取到了参数 user  
  const request = ctx.switchToHttp().getRequest();
  return request.user;
});
```

### 使用

```typescript
// 这样直接就可以拿到 user 这个参数 不用在自己获取了
@Get()
async findOne(@User() user: UserEntity) {
  console.log(user);
}
```

### 实例

```typescript
// 假设这是前台传入的参数
{
  "id": 101,
  "firstName": "Alan",
  "lastName": "Turing",
  "email": "alan@email.com",
  "roles": ["admin"]
}
// 下面是我们的装饰器而当使用 我们需要获取 firstName 参数

@Get()
// 给我们的自定义装饰器 传入了参数 firstName
async findOne(@User('firstName') firstName: string) {
  console.log(`Hello ${firstName}`);
}

// 根据 装饰器传入的参数 返回 固定的数据

import { createParamDecorator, ExecutionContext } from '@nestjs/common';

export const User = createParamDecorator((data: string, ctx: ExecutionContext) => {
  const request = ctx.switchToHttp().getRequest();
  const user = request.user;

  return data ? user && user[data] : user;
});
```

## 数据库的使用

### Mongoose

- 安装

```typescript
npm install --save @nestjs/mongoose mongoose
```

- 使用

```markdown
1. 首先我们需要 在我们的根路径中 创建数据库链接 
2. 我们把我们的服务抽离成一个模块
```

```typescript
// 根服务 app.module.ts

import { AppController } from './app.controller';
import { AppService } from './app.service';

import { MongooseModule } from '@nestjs/mongoose';
import { UserModule } from './user/user.module';

@Module({
  // 建立数据库链接 和导入我们的模块 这我们链接的 test 库 UserModule 就是把我们的一个服务抽离除了一个模块
  imports: [MongooseModule.forRoot('mongodb://localhost/test'), UserModule],
  controllers: [AppController, InterceptorsController],
  providers: [AppService],
})
export class AppModule {
}

```

- UserModule 模块

```markdown
1.  跟我们的 app.module.ts 模块一样 里面也要注入自己的 contreoller 和 service等
```

```typescript
import { Module } from '@nestjs/common';
import { UserController } from './user.controller';
import { UserService } from './user.service';
import { MongooseModule } from '@nestjs/mongoose';
import { UserSchema } from './user.schema';
@Module({
  // 这里的 name:'User' 为数据库表名称与 service 中注入的表名称对应两者不一样会报错
  // 这里就是 创建集合 集合名称叫做User 字段是下面的数据模型
  imports: [MongooseModule.forFeature([{ name: 'User', schema: UserSchema }])],
  // 注入我们的controller层   
  controllers: [UserController],
  // 注入我们的service层   
  providers: [UserService],
})
export class UserModule {}
```

-  数据模型 user.schema.ts

```typescript
// 这一步 就是需要创建 集合里 具体的字段了 然后需要导出你的字段类 和 你的字段模型
// 字段模型 是在 module文件里 创建结合的时候使用的  
// 而 字段类 是在你 做增删改查的时候使用的
user.schema.ts
// 创建数据模型
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';
export type UserDocument = User & Document;
// 设置字段
@Schema()
export class User extends Document {
  @Prop()
  name: string;
  // 设置值为必填
  @Prop({ required: true })
  age: number;
  @Prop()
  height: number;
}
// 创建集合 设置字段
export const UserSchema = SchemaFactory.createForClass(User);
```

- 调用 service

```markdown
1. 创建好了数据类 和 我们就可以调用了
```

```typescript
import { Injectable } from '@nestjs/common';
import { User, UserDocument } from './user.schema';
import { CreateUserDto } from './user.dto';
import { Model } from 'mongoose';
import { InjectModel } from '@nestjs/mongoose';
@Injectable()
export class UserService {
  //@InjectModel  这里就是你要在哪个集合下面 创建数据 我们创建的集合名称叫User 所以这里我们在User下创建数据
  constructor(@InjectModel('User') private userTest: Model<UserDocument>) {}
  // 添加
  async create(createUserDto: CreateUserDto): Promise<User> {
    // 根据数据模型 创建 实例
    const createUser = new this.userTest(createUserDto);
    // 保存到数据库
    const temp = await createUser.save();
    console.log(temp, '===temp'); //  创建的数据
    return temp;
  }
}
```

- 调用 controller

```markdown
1. 我们 在 service 里 写好了增删改查的方法 是在路由里调用的 也就是controller 里使用
```

```typescript
import { Controller, Get } from '@nestjs/common';
import { UserService } from './user.service';

@Controller('user')
export class UserController {
  constructor(private readonly userService: UserService) {}
  @Get()
  async say() {
    // 调用这样数据库 就创建了一条数据  
    await this.userService.create({ name: 'nest', age: 18, height: 30 });
    return '111';
  }
}

```







