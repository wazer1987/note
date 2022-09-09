FlowVue3

- 流程

```markdown
1. 
```

## 国际化

- 逻辑

```markdown
1. 这里我们安装的是 vue-i18n 包
```

- 代码

```JS
// 首先定义我们的 我们自己的语言包 langs(文件夹) index.js en-US.js zh-CN.js
zh-CN.js 导出中文语言包
export default {
  // 左侧面板
  L10000:'物料面板',
  L10001:'图形',
  L10002:'箭头'
}
en-US.js 导出英文
export default {
  // 左侧面板
  L10000:'Material panel',
  L10001:'graphics',
  L10002:'arrowhead'
}
index.js 
// 引入
import zh from './zh-CN'
import en from './en-US'
// label 做切换的时候用
export default {
  label: {
    'zh-CN': '简体中文',
    'en-US': 'English'
  },
  data: {
    'zh-CN': {  ...zh },
    'en-US': {  ...en }
  }
}
```

```js
i18n.js  初始化 vue-i18n 多语言包控件
// 1. 多语言工具包
import { createI18n } from 'vue-i18n'
// 语言包
import messages from './langs/index.js'

 //注册i8n实例并引入语言文件
 const i18n = createI18n({
    legacy: false,
    locale: 'zh-CN',
    messages:messages.data
  })

export default i18n

// main.js 加载 i18n 
import { createApp } from 'vue'
import App from './App.vue'
import i18n from './i18n'
import '@/styles/index.scss'
const app = createApp(App)
app.use(i18n)

app.mount('#app')
```

```vue

<script setup>
// 使用
import { useI18n } from "vue-i18n";
// 结构出来翻译函数    
const {t} = useI18n()
... 好多代码
</script>
          
<template>
  <!-- 使用t函数 翻译我们语言包-->
  <w-card  placement="left" :title="t('L10000')" position="right" :width="250">
    <w-card-item v-for="(item,index) in materials" :key="index" :title="t(item.lang)" :enableFold="true" :bold="true"> 
      <w-node-element
        v-for="(child, childIndex) in item.children.filter(target => target.enable)"
        :key="childIndex"
        :title="child.label"
        :info="child"
      />
    </w-card-item>
  </w-card>
</template>
```

## g6初始化

### 初始化

- 逻辑

```markdown
1. 我们这里所有的自定义节点 都是用path 绘画出来的
2. 初始化我们会 包装在一个init.js 里这里面 会初始化g6和 注册自定义节点等
3. 每个图形节点都会有自己的配置文件
```

- index.js

```markdown
1. 包装了一些方法 然后 导出 让index.vue 主页面可以去使用
```

- 代码

```js
import {init} from '@/Editor/g6/init.js'
export default {
  init
}
```

```vue
<template>
  <div class="materials-editor">
    <ToolBar />
    <PanelLeft :materialList="material.list"/>
    <PanelRight />
    <Sketchpad />
  </div>
</template>

<script setup>
import { reactive,onMounted } from "vue";
import PanelLeft from "@/Editor/containers/PanelLeft.vue";
import PanelRight from "@/Editor/containers/PanelRight.vue";
import ToolBar from "@/Editor/containers/ToolBar.vue";
import Sketchpad from "@/Editor/containers/Sketchpad.vue";
import materials from '@/config/materials.js'
import G6 from '@/Editor/g6/index.js'
let graph = null
onMounted(() => {
   // 在这里 初始化了g6 
   graph = G6.init()
})
... 好多代码
</script>
```

- init.js

```markdown
1. 注册了自定义行为 注册了 自定义节点 初始化了g6 配置了一些常用的样式和属性
```

- 代码

```js
import G6 from '@antv/g6'
// 注册自定义节点
import registerNode from './node/index.js'
// 注册自定义行为
import registerBehavior from './behavior/index.js'
const grid = new G6.Grid()
export const init = function () {
  registerBehavior(G6)
  registerNode(G6)
  const graph = new G6.Graph({
    container: document.getElementById('sketchpad'), // String | HTMLElement，必须，在 Step 1 中创建的容器 id 或容器本身
    width: window.innerWidth, // Number，必须，图的宽度
    height: window.innerHeight, // Number，必须，图的高度
    fitView: true,
    fitViewPadding: 20,
    modes:{
      // 使用了自定义行为  
      default:['node-control']
    },
    plugins:[
      grid
    ]
  });
  // 在原型上 挂在了 $D 一些常用的样式  
  graph.$D = {
    fill: 'red',
    fillOpacity: 1,
    lineColor: '#000000',
    strokeOpacity: 1,
    lineWidth: 1,
    lineType: 'x-line',
    lineDash: 'solid',
    startArrow: false,
    endArrow: false,
    lineAppendWidth: 10,
    autoRotate: true
  }
  // 返回了g6的实例
  return graph
}

```

### 自定义节点

- 逻辑

```markdown
1. g6文件夹下 的 node 文件夹 index.js
2. 读取了我们节点的配置文件 循环注册了 自定义节点
```

- 代码

```js
// 节点的配置文件
import general from './genernal/index.js'
// 可能以后还有箭头的图形所有分开了
const obj = {
  ...general,
}
export default function (G6) {
  Object.values(obj).forEach(item => {
    G6.registerNode(item.name, item.options, item.extendName)
  })
}
```

- node/genernal/index.js

```markdown
1. 导入了所有 自定义节点的配置文件 比如 圆角矩形的 半圆等
```

- 代码

```js
// 半圆图形的 节点文件
import and from './and'

 export default {
   and,
 }
```

- node/genernal/and.js

```markdown
1. 半圆图形的 一些 配置 比如样式啊 等等 一些的计算
2. 这里面 base 也扩展了进去 base 里面就是 g6绘制一些节点的方法
```

- 代码

```js
// 拿到 g6工具类
import * as G6Util from '@antv/util'
// 公共配置 比如绘制节点的方法 state方法 和获取 锚点的一些方法
import base from '../base'
// 半圆
export default {
  name: 'and',
  extendName: 'single-node',
  options: {
    // 扩展展开  
    ...base,
    shapeType: 'path',
    getShapeStyle (cfg) {
      const size = this.getSize(cfg)
      const width = size[0]
      const height = size[1]
      const x = 0 - width / 2
      const y = 0 - height / 2
      const path = [
        // 左上
        [ 'M', -width / 2, -height / 2 ],
        // 右弧
        [ 'C', width / 2, -height * 3 / 5, width / 2, height * 3 / 5, -width / 2, height / 2 ],
        [ 'Z' ]
      ]
      const color = cfg.color
      const style = G6Util.mix({}, {
        // 节点的位置在上层确定，所以这里仅使用相对位置即可
        x,
        y,
        width,
        height,
        path,
        stroke: color
      }, cfg.style)
      return style
    }
  }
}
```

- node/base

```markdown
1. 自定义节点 g6绘制的公共方法 比如 drawShape setState updateShape等等
```

- 代码

```js
 import * as G6Util from '@antv/util'
//  import utils from '../utils'
 
 export default {
   type: null,
   // 自定义节点配置，需要配置时在各个图形中覆写
   options: {},
   drawShape (cfg, group) {
     // 这里就拿到了我们上面的   node/genernal/and.js 里面的配置
     const shapeType = this.shapeType
     // 返回样式 这里我们的path 的起点和 结束点 绘画出来的图形
     const style = this.getShapeStyle(cfg)
     const keyShape = group.addShape(shapeType, {
       attrs: style,
       name: 'XFCNodeKeyShape',
       draggable: true
     })
     this.keyShape = keyShape
     // 节点绘制完毕  
     return keyShape
   },
   getAnchorPoints (cfg) {},
   setState (name, value, item) {},
   update (cfg, item) {},
   updateShape (cfg, item, style) {},
   // 绘制完成后附加锚点
   afterDraw (cfg, group) {},
   // 更新完成后更新锚点
   afterUpdate (cfg, item) {}
 }
```

## 拖拽节点

- PanelLeft.vue

```markdown
1. 里面包含 w-card 组件 盒子的最外层  点击按钮 可以 收缩盒子 可以设置横向 和 纵向显示 
2. 里面包含 w-card-item 插槽插入在 w-card 组件里面 可以理解为折叠面板 有 传头部 和 字体是否加粗等
3. 里面包含 w-node-element 插槽插入在 w-card-item 这里就是每一个每一个物料了 循环出来的
4. 注意 以上 三个组件都是用jsx 写的
```

- 代码

```vue
<script setup>
import wCard from "../components/wCard.jsx";
import wCardItem from "@/Editor/components/wCardItem.jsx";
import wNodeElement from "@/Editor/components/wNodeElement.jsx";
import { useI18n } from "vue-i18n";
import { computed } from "@vue/runtime-core";
const {t} = useI18n()
// 这里就是物料列表 里面包含节点 箭头等
const {materialList} = defineProps({
  materialList: Array
})
// 过滤 enable 为true的选项 
const materials = computed(() => {
  return materialList.filter((item) =>  item.enable)
})
</script>
          
<template>
  <w-card  placement="left" :title="t('L10000')" position="right" :width="250">
    <w-card-item v-for="(item,index) in materials" :key="index" :title="t(item.lang)" :enableFold="true" :bold="true"> 
      <w-node-element
        v-for="(child, childIndex) in item.children.filter(target => target.enable)"
        :key="childIndex"
        :title="child.label"
        :info="child"
      />
    </w-card-item>
  </w-card>
</template>
```

- w-node-element.jsx

```markdown
1. 循环出来了每个物料 图形是用svg 画出来的 每个循环项目上 有 svg的字符串
2. 之歌物料绑定了一个 鼠标按下事件 按下的时候 我们用 mitt 派发了事件 参数就是我们的循环项 里面有你点击的信息 然后 在index.vue 初始页面 监听了事件
3. 调用方法 创建了节点 然后 使用g6实例派发了事件 这样就会走到我们自定义事件里面去
4. 自定义事件里 主要做了几个动作 
鼠标 进入画布 创建一个虚影
鼠标 在画布上移动 移动虚影
鼠标抬起 创建节点
```

- 代码

```jsx
import { computed, defineComponent } from "vue";
import wNodeElementStyle from "@/styles/wNodeElement.module.scss";
// 我们封装好的事件派发对象
import emitter  from '@/utils/index.js'
export default defineComponent({
  name: 'NodeElement',
  props: {
    // 标题  
    title: {
      type: String,
      required: true
    },
    // 这里就是点击的时候循环项目 传进来的
    info: {
      type: Object,
      required: true,
      default () {
        return {
          type: 'circle',
          label: 'circle',
          enable: true,
          width: 40,
          height: 40,
          anchorPoints: [[0, 0], [0, 1], [1, 0], [1, 1]],
          svg: ``
        }
      }
    },
    width: {
      type: Number,
      default: 40
    },
    height: {
      type: Number,
      default: 40
    }
  },
  setup (props,{emit}) {
    const {title,width,height,info} = props
    
    const elementStyle = computed(() => {
        let style1 = {}
        style1['width'] = width + 'px'
        style1['height'] = height + 'px'
        return style1
    })

    // 鼠标按下
    const handleMouseDown = () => {
      // 向上派发了事件  
      emitter.emit('editor/add/node',info)
    }
    return () =>
      <div  class={wNodeElementStyle['node-element']} style={elementStyle.value}  onMousedown={handleMouseDown}>
        <div class={wNodeElementStyle['content']} title={title}>
          <!-- 这里在 jsx里我们可以使用 innerHTML 去渲染html标签 -->  
          <svg class={wNodeElementStyle['icon']} innerHTML={info.icon}>
            
          </svg>
        </div>
      </div>
  }
})
```

- index.vue

```markdown
1. 调用了事件派发对象 来 监听 在 w-node-element.jsx 组件里派发的事件
2. 执行了 doAddNode 创建了节点 里面一些样式等等
3. 调用g6实例派发事件 触发了我们的g6的自定义事件
```

- 代码

```vue
<template>
  <div class="materials-editor">
    <ToolBar />
    <PanelLeft :materialList="material.list"/>
    <PanelRight />
    <Sketchpad />
  </div>
</template>

<script setup>
import { reactive,onMounted } from "vue";
import PanelLeft from "@/Editor/containers/PanelLeft.vue";
import PanelRight from "@/Editor/containers/PanelRight.vue";
import ToolBar from "@/Editor/containers/ToolBar.vue";
import Sketchpad from "@/Editor/containers/Sketchpad.vue";
import materials from '@/config/materials.js'
import G6 from '@/Editor/g6/index.js'
import * as G6Util from '@antv/util'
import emitter  from '@/utils/index.js'
let graph = null
onMounted(() => {
   graph = G6.init()
})
const material = reactive({
  list:[]
})
material.list = materials()
// 添加节点
const doAddNode = (info) => {
        2. 创建了 节点的样式 
        const node = {
          id: G6Util.uniqueId(),
          draggable: true,
          type: info.type,
          label: info.defaultLabel,
          labelCfg: {
            position: 'center',
            style: {
              fontSize: 16,
              stroke: '#000000'
            }
          },
          width: info.width,
          height: info.height,
          minWidth: info.minWidth,
          minHeight: info.minHeight,
          anchorPoints: info.anchorPoints,
          shapeControl: info.shapeControl
        }
        3. 使用g6派发了事件 会被我们的自定义行为监控到
        graph.emit('editor:addNode', node)
}
1. 监听到 我们的在 w-node-element 鼠标按下派发的事件
emitter.on('editor/add/node',doAddNode)
</script>
```

## 自定义行为

```markdown
1. 这里我们 以添加节点为准
```

- g6/behavior/index.js

```markdown
1. 我们这里可能有 编辑模式下的 自定义事件 和 预览模式下的自定义事件
2. 导出了 注册事件的方法 在 init.js 里调用了
```

- 代码

```js

// 综合节点控制交互
import nodeControl from './nodeControl.js'
// 预览画布交互
// import previewCanvas from './previewCanvas'

const obj = {
  nodeControl,
  // previewCanvas
}

export default function (G6) {
  console.log('注册事件');
  Object.values(obj).forEach(item => {
    G6.registerBehavior(item.name, item.options)
  })
}

```

- g6/behavior/nodeControl.js

```markdown
1. 这里就是我们的g6的自定义行为了
2. 我们在 index.vue 调用  graph.emit('editor:addNode', node) 就触发了我们这里的自定义行为
3. 会调用 onEditorAddNode 设置我们的模式 
4. 然后设置你鼠标 进入画布 在画布上移动 在画布上抬起鼠标 等一些列动作去创建节点
```

- 代码

```js
/**
 * Created by OXOYO on 2019/7/17.
 *
 * 综合节点控制交互
 */

import * as G6Util from '@antv/util'
import * as G6DomUtil from '@antv/dom-util'
 import config from '../config'
 import utils from '../utils'

const TIME_FRAME = 200

export default {
  name: 'node-control',
  options: {
    getDefaultCfg () {
      return {
        config: {
          shapeControlPoint: {
            // 是否在缩放、旋转节点时更新所有与之相连的边
            updateEdge: false
          },
          dragNode: {
            // 是否在拖拽节点时更新所有与之相连的边
            updateEdge: false
          },
          // 是否支持在节点上添加文本
          nodeLabel: true,
          // 是否支持在边上添加文本
          edgeLabel: true,
          // tooltip 是否启用
          tooltip: {
            shapeControl: true,
            dragNode: true,
            dragEdge: false
          },
          // 是否启用对齐线
          alignLine: {
            enable: true,
            style: {
              stroke: '#FA8C16',
              lineWidth: 1
            }
          }
        }
      }
    },
    getEvents () {
      return {
         1.会先执行这个  
        'editor:addNode': 'onEditorAddNode',
        'canvas:mouseup': 'onCanvasMouseup',
         2. 鼠标进入画布  
        'canvas:mouseenter': 'onCanvasMouseenter',
         3. 鼠标移动 虚影跟着移动 
        'mousemove': 'onMousemove',
         4. 鼠标抬起 创建 我们的节点 和清除虚影 
        'mouseup': 'onMouseup'
         ... 还有好多事件  
      }
    },
    1. 我们在 index.vue 里 派发的事件 会触发到这里   graph.emit('editor:addNode', node)
    onEditorAddNode (node) {
      const _t = this
      // 设置一些状态
      // 这里的this 是 g6 
      _t.info = {
        type: 'dragNode',
        node: node,
        target: null
      }
      _t.dragNode.status = 'dragNodeToEditor'
    },
    4. 松手了 调用 createNode 先创建节点 然后在清楚虚影
    onMouseup (event) {
      const _t = this
      if (_t.info) {
        if (_t.info.type) {
          if (_t.info.type === 'dragNode' && _t.dragNode.status === 'dragNodeToEditor') {
            _t[_t.info.type].createNode.call(_t, event)
          }
          if (_t[_t.info.type].stop) {
            _t[_t.info.type].stop.call(_t, event)
          }
        }
      }
    },
    4. 在画布上松开 会清楚 虚影    
    onCanvasMouseup (event) {
      // console.log('我在画布上松手了')
      const _t = this
      // console.log('onCanvasMouseup', _t.info.type)
      if (_t.info && _t.info.type && _t[_t.info.type].stop) {
        _t[_t.info.type].stop.call(_t, event)
      }
    },
    2. 鼠标进入画布 会创建一个虚影节点
    onCanvasMouseenter (event) {
      console.log('onCanvasMouseenter')
      const _t = this
      if (_t.info && _t.info.type === 'dragNode') {
          
        _t[_t.info.type].createDottedNode.call(_t, event)
      }
    },
    onCanvasMousemove (event) {
      // console.log('onCanvasMousemove')
      const _t = this
      utils.common.throttle(function () {
        if (_t.info && _t.info.type && _t[_t.info.type].move) {
          // console.log('onCanvasMousemove', _t.info.type)
          _t[_t.info.type].move.call(_t, event)
        }
      }, TIME_FRAME)()
    },
    // 3. 这里做了节流
    onMousemove (event) {
      const _t = this
      // console.log('onMousemove', _t.info)
      utils.common.throttle(function () {
        if (_t.info && _t.info.type && _t[_t.info.type].move) {
          // 调用了 move 事件 移动 虚影的节点  
          _t[_t.info.type].move.call(_t, event)
        }
      }, TIME_FRAME)()
    },
    // 拖拽节点
    dragNode: {
      dottedNode: null,
      status: null,
      // 虚线框节点样式
      dottedNodeStyle: {
        ...config.dottedNode.style.default
      },
      // 2. 调用到这里 创建一个虚影的节点 挂在到了 this上
      createDottedNode (event) {
        const _t = this
        if (!_t.dragNode.dottedNode && _t.info.node) {
          const { width, height } = _t.info.node
          const group = _t.graph.get('group')
          _t.dragNode.dottedNode = group.addShape('rect', {
            name: 'dottedNode',
            attrs: {
              ..._t.dragNode.dottedNodeStyle,
              width,
              height,
              x: event.x - width / 2,
              y: event.y - height / 2
            }
          })
          // _t.graph.paint()
          // if (_t.config.tooltip.dragNode) {
          //   _t.toolTip.create.call(_t, {
          //     left: event.canvasX,
          //     top: event.canvasY + height / 2
          //   }, `X: ${event.x.toFixed(2)} Y: ${event.y.toFixed(2)}<br>W: ${width.toFixed(2)} H: ${height.toFixed(2)}`)
          // }
        }
      },
      createNode (event) {
        console.log('调用创建节点方法');
        const _t = this
        if (_t.dragNode.dottedNode && _t.info.node) {
          console.log('进入创建节点');
          const { width, height, minWidth, minHeight, label, type } = _t.info.node

          const node = {
            ..._t.info.node,
            id: G6Util.uniqueId(),
            name: 'XFC_NODE_' + utils.common.firstUpperCase(type),
            draggable: true,
            x: event.x,
            y: event.y,
            size: [width, height],
            minWidth: minWidth,
            minHeight: minHeight,
            label: label,
            style: {
              fill: _t.graph.$D.fill,
              fillOpacity: _t.graph.$D.fillOpacity,
              stroke: _t.graph.$D.lineColor,
              strokeOpacity: _t.graph.$D.strokeOpacity,
              lineWidth: _t.graph.$D.lineWidth,
              ...config.edge.type[_t.graph.$D.lineDash]
            }
          }
          _t.graph.addItem('node', node)
        }
      },
      // start (event) {
      //   const _t = this
      //   // _t.dragNode.createDottedNode.call(_t, event)
      //   if (_t.config.tooltip.dragNode) {
      //     const { width, height } = _t.info.node.getModel()
      //     _t.toolTip.create.call(_t, {
      //       left: event.canvasX,
      //       top: event.canvasY + height / 2
      //     }, `X: ${event.x.toFixed(2)} Y: ${event.y.toFixed(2)}<br>W: ${width.toFixed(2)} H: ${height.toFixed(2)}`)
      //   }
      //   _t.dragNode.status = 'dragNode'
      //   if (_t.config.alignLine.enable) {
      //     // 绘制对齐线
      //     _t.alignLine.start.call(_t)
      //   }
      // },
      //3. 移动 鼠标进入画布的时候创建的虚影子
      move (event) {
        const _t = this
        if (_t.dragNode.status === 'dragNodeToEditor') {
          if (_t.dragNode.dottedNode && _t.info.node) {
            const { width, height } = _t.info.node
            // 不停更换坐标 
            _t.dragNode.dottedNode.attr({
              x: event.x - width / 2,
              y: event.y - height / 2
            })
            // _t.graph.paint()
            // if (_t.config.tooltip.dragNode) {
            //   _t.toolTip.update.call(_t, {
            //     left: event.canvasX,
            //     top: event.canvasY + height / 2
            //   }, `X: ${event.x.toFixed(2)} Y: ${event.y.toFixed(2)}<br>W: ${width.toFixed(2)} H: ${height.toFixed(2)}`)
            // }
            // if (_t.config.alignLine.enable) {
            //   // 绘制对齐线
            //   _t.alignLine.move.call(_t, _t.dragNode.dottedNode)
            // }
          }
        } else if (_t.dragNode.status === 'dragNode') {
          if (_t.info.node) {
            const { id, groupId, x, y } = _t.info.node.getModel()
            _t.graph.find('node', node => {
              const model = node.getModel()
              // 更新当节点
              if (model.id === id) {
                const attrs = {
                  // 处理点击移动 图形时的抖动
                  x: x + event.originalEvent.movementX,
                  y: y + event.originalEvent.movementY
                }
                // 更新节点
                _t.graph.updateItem(_t.info.node, attrs)
                if (_t.config.dragNode.updateEdge) {
                  // 更新边
                  utils.edge.update(_t.info.node, _t.graph)
                }
                if (_t.config.tooltip.dragNode) {
                  const { width, height } = _t.info.node.getModel()
                  _t.toolTip.update.call(_t, {
                    left: event.canvasX,
                    top: event.canvasY + height / 2
                  }, `X: ${event.x.toFixed(2)} Y: ${event.y.toFixed(2)}<br>W: ${width.toFixed(2)} H: ${height.toFixed(2)}`)
                }
              } else {
                if (groupId && model.groupId && model.groupId === groupId) {
                  // 更新同组节点
                  _t.graph.updateItem(node, {
                    x: model.x + event.originalEvent.movementX,
                    y: model.y + event.originalEvent.movementY
                  })
                }
              }
            })
            if (_t.config.alignLine.enable) {
              // 绘制对齐线
              _t.alignLine.move.call(_t, _t.info.node)
            }
          }
        }
      },
      stop (event) {
        const _t = this
        // 记录操作日志
        _t.graph.emit('editor:record', 'dragNode stop')
        _t.dragNode.clear.call(_t)
        // if (_t.config.tooltip.dragNode) {
        //   _t.toolTip.destroy.call(_t)
        // }
        // if (_t.config.alignLine.enable) {
        //   _t.alignLine.stop.call(_t)
        // }
        // _t.graph.paint()
      },
      clear () {
        const _t = this
        if (_t.dragNode.dottedNode) {
          _t.dragNode.dottedNode.remove()
          _t.dragNode.dottedNode = null
        }
        _t.dragNode.status = null
        _t.info = null
      }
    },
  }
}

```

## 锚点的绘制

- 逻辑

```markdown
1. 实在自定义节点的方法里 调用 afterDraw 方法里 完成的 该方法 在绘制玩节点后 有g6调用
2. 锚点的 绘制我们是单独抽离了一个方法去绘制的 我们在物料区域点击鼠标左键的时候 已经 放置锚点的 坐标了 根据这些坐标我们去绘制marker 标记 
3. 锚点分为两个部分 一个是蓝色背景的大圆 一个是 中间的白色小圆
4. 锚点背景 和锚点 我们都分为几个配置文件 单独分离
5. 锚点的显示 与隐藏 我们 监听了 鼠标进入节点和移出节点的事件 然后调用setState方法 去控制显示和隐藏 就是设置了锚点的透明度 g6/utils/anchor/draw.js 绘制了锚点
```

- node/base.js

```markdown
1. 这里面就是有锚点绘制的方法 在 我们的自定义节点方法里 afterDraw 生命周期里 绘制了锚点
2. 主要调用了 
```

- 代码

```js

import * as G6Util from '@antv/util'
1. 这引用了 g6/utils/anchor/draw.js 方法
import utils from '../utils'

export default {
  type: null,
  // 自定义节点配置，需要配置时在各个图形中覆写
  options: {},
  drawShape (cfg, group) {},
  getAnchorPoints (cfg) {},
  setState (name, value, item) {},
  update (cfg, item) {},
  updateShape (cfg, item, style) {},
  // 绘制完成后附加锚点
  afterDraw (cfg, group) {
    // 绘制锚点
    utils.anchor.draw(cfg, group)
  },
  // 更新完成后更新锚点
  afterUpdate (cfg, item) {}
```

-  g6/utils/anchor/draw.js

```markdown
1. anchorPoints 锚点的坐标信息 我们在 点击左侧物料的时候 就已经在配置文件里了
2. shape.getPoint 可以根据比例算出来 锚点的坐标
3. 这里面锚点的坐标信息 是一个二维数据 我们 可以根据二维数组里的索引 和 锚点数组的总长度 相除  调用 图形的 getPoint 方法 就可以算出锚点的坐标
4. 这里面我们的锚点分为两个 一个是 鼠标移入节点显示的锚点 一个是鼠标移入锚点上 显示的锚点背景
```

- 代码 

```js
// 这里就是一些 样式 比如 半径啊 背景颜色 和边框颜色啊 
import config from '../../config'

export default function (cfg, group) {
  const { anchorPoints, width, height, id } = cfg
  // anchorPoints  就是锚点坐标 一个二维数组
  // 通过图谱拿到节点 在通过节点拿到第一个图形
  const shape = group.getFirst()
  if (anchorPoints && anchorPoints.length) {
    for (let i = 0, len = anchorPoints.length; i < len; i++) {
      let anchorX
      let anchorY
      // 获取图形的类型 这里我们大多数都是用 path 去画的
      if (shape && shape.get('type') === 'path') {
        // 计算了 x , y 坐标  
        const point = shape.getPoint(i / len)
        anchorX = point.x
        anchorY = point.y
      } else {
        // 这里没有走这里  
        const [x, y] = anchorPoints[i]
        const originX = -width / 2
        const originY = -height / 2
        anchorX = x * width + originX
        anchorY = y * height + originY
      }
      // 添加锚点背景  当鼠标移入到锚点的时候 会显示这个锚点背景 这里我们用的标记 
      const anchorBgShape = group.addShape('marker', {
        id: id + '_anchor_bg_' + i,
        name: 'anchorBg',
        attrs: {
          boxName: 'anchor',
          name: 'anchorBg',
          x: anchorX,
          y: anchorY,
          /** 锚点背景样式 这里就是一个圆 然后上面有一些 背景颜色 和边框颜色等 这里的透明度都是0
          default: {
              r: 10,
              symbol: 'circle',
              fill: '#1890FF',
              fillOpacity: 0,
              stroke: '#1890FF',
              strokeOpacity: 0,
              cursor: 'crosshair'
           },  
           **/ 
          ...config.anchorBg.style.default
        },
        zIndex: 100
      })
      // 鼠标引入的时候显示的锚点
      const anchorShape = group.addShape('marker', {
        id: id + '_anchor_' + i,
        name: 'anchorPoint',
        attrs: {
          boxName: 'anchor',
          name: 'anchorPoint',
          x: anchorX,
          y: anchorY,
            
          /**  锚点 白色  蓝色边框
          default: {
              r: 3,
              symbol: 'circle',
              fill: '#FFFFFF',
              fillOpacity: 0,
              stroke: '#1890FF',
              strokeOpacity: 0,
              cursor: 'crosshair'
           },  
           **/
          ...config.anchor.style.default
        }
      })
    }
  }
}
```

## 锚点的显示和隐藏

- 逻辑

```markdown
1. 我们给创建出来的节点 绑定了 鼠标进入和鼠标离开事件
2. 鼠标 进入节点的时候 我们要先判断是不是选中状态 如果不是我们就调用 setState 去设置 鼠标hover 为true
3. 鼠标 离开节点的时候 逻辑相反 设置 hover 为false
4. 然后我们在自定义节点方法里的 setState 方法里 调用了 让锚点显示 和隐藏
```

- index.vue

```vue
<template>
  <div class="materials-editor">
    <ToolBar />
    <PanelLeft :materialList="material.list" />
    <PanelRight />
    <Sketchpad />
  </div>
</template>

<script setup>
import { reactive, onMounted } from 'vue'
import PanelLeft from '@/Editor/containers/PanelLeft.vue'
import PanelRight from '@/Editor/containers/PanelRight.vue'
import ToolBar from '@/Editor/containers/ToolBar.vue'
import Sketchpad from '@/Editor/containers/Sketchpad.vue'
import materials from '@/config/materials.js'
import G6 from '@/Editor/g6/index.js'
import * as G6Util from '@antv/util'
import emitter from '@/utils/index.js'
let graph = null
onMounted(() => {
  graph = G6.init()
  // 鼠标进入显示锚点
  graph.on('node:mouseover', nodeHover)
  // 鼠标离开隐藏锚点
  graph.on('node:mouseout', nodeOut)
})

// 鼠标进入显示锚点 回调函数 触发自定义节点的 base中的 setState 函数
const nodeHover = (event) => {
  if (!event.item.hasState('active')) {
    graph.setItemState(event.item, 'hover', true)
  }
}
// 鼠标离开隐藏锚点 回调函数 触发自定义节点的 base中的 setState 函数
const nodeOut = (event) => {
  graph.setItemState(event.item, 'hover', false)
}
const material = reactive({
  list: [],
})
material.list = materials()
</script>
```

- g6/node/base.js

```js

 import * as G6Util from '@antv/util'
 import utils from '../utils'
 
 export default {
   type: null,
   // 自定义节点配置，需要配置时在各个图形中覆写
   options: {},
   drawShape (cfg, group) {},
   getAnchorPoints (cfg) {},
   setState (name, value, item) {
     1. 设置锚点显示状态
     utils.anchor.setState(name, value, item)
   },
   update (cfg, item) {},
   updateShape (cfg, item, style) {},
   // 绘制完成后附加锚点
   afterDraw (cfg, group) {},
   // 更新完成后更新锚点
   afterUpdate (cfg, item) {}
```

- g6/utils/anchor/setState.js

```markdown
1. 判断hover 状态的值 为false 还是 为true
2. 然后来隐藏锚点 或者显示锚点 把锚点的透明度 设置为 1
```

- 代码 

```js

import config from '../../config'

export default function (name, value, item) {
  if (name === 'hover') {
    const group = item.getContainer()
    const children = group.get('children')
    for (let i = 0, len = children.length; i < len; i++) {
      const child = children[i]
      if (child.attr('name')) {
        switch (child.attr('name')) {
          case 'anchorPoint':
            if (value) {
              child.show()
              // 这里就是把 锚点的样式 透明度设置为 1了  
              child.attr(config.anchor.style.hover)
            } else {
              // false 的时候透明度就设置为 0  
              child.attr(config.anchor.style.unhover)
              child.hide()
            }
            break
          case 'shapeControlPoint':
          case 'shapeControlRotate':
            child.hide()
            break
        }
      }
    }
  }
}
```

## 锚点背景的显示和隐藏

- 逻辑

```markdown
1. 我们鼠标移到锚点上的时候 会显示 锚点背景
2. 所以我们在绘制玩锚点和锚点毕竟的时候 就给买点绑定了 鼠标进入 鼠标移出的事件
3. 我们是在 注册自定义节点的 afterDraw 生命周期 调用 g6/utils/anchor/draw.js 方法绘制的
```

- 代码

```js
/**
 * Created by OXOYO on 2019/8/29.
 *
 * 节点基础方法
 */
 import * as G6Util from '@antv/util'
 import utils from '../utils'
 
 export default {
   type: null,
   // 自定义节点配置，需要配置时在各个图形中覆写
   options: {},
   drawShape (cfg, group) {... 绘制自定义节点的代码},
   getAnchorPoints (cfg) {},
   setState (name, value, item) { ... 设置状态 比如鼠标hover 选中等},
   update (cfg, item) {},
   updateShape (cfg, item, style) {},
   // 绘制完成后附加锚点
   afterDraw (cfg, group) {
     // 绘制锚点 和锚点背景
     utils.anchor.draw(cfg, group)
   },
   // 更新完成后更新锚点
   afterUpdate (cfg, item) {}
 }

```

- g6/utils/anchor/draw.js

```markdown
1. 绘制锚点和锚点背景 详细见 锚点绘制代码
2. 绘制完毕之后 给锚点绑定了鼠标的进入 和 移出事件
```

- 代码 

```js
/**
 * Created by OXOYO on 2019/7/8.
 *
 * 绘制锚点
 */

import config from '../../config'

export default function (cfg, group) {
  const { anchorPoints, width, height, id } = cfg
  const shape = group.getFirst()
  // console.log('getAnchorPoints', id, shape, anchorPoints.length)
  if (anchorPoints && anchorPoints.length) {
    for (let i = 0, len = anchorPoints.length; i < len; i++) {
      let anchorX
      let anchorY
      if (shape && shape.get('type') === 'path') {
        const point = shape.getPoint(i / len)
        anchorX = point.x
        anchorY = point.y
      } else {
        const [x, y] = anchorPoints[i]
        // 计算Marker中心点坐标
        const originX = -width / 2
        const originY = -height / 2
        anchorX = x * width + originX
        anchorY = y * height + originY
      }
      // 添加锚点背景
      const anchorBgShape = group.addShape('marker', { ... 绘制锚点背景的代码})
      // 添加锚点Marker形状
      const anchorShape = group.addShape('marker', {... 绘制锚点的代码 })
	  // 然后在这里 给我们的锚点绑定了鼠标进入或者移出的事件	
      if (anchorShape) {
        anchorShape.on('mouseenter', function () {
          // 鼠标进入的时候 我们上面绘制的锚点背景 颜色都是透明的 这里 我们设置进入的样式
          /**
           active: {
              fillOpacity: 0.3,
              strokeOpacity: 0.5
            }
          **/  
          anchorBgShape.attr({
            ...config.anchorBg.style.active
          })
        })
        anchorShape.on('mouseleave', function () {
          // 鼠标离开锚点的时候 设置为透明
          /**
          inactive: {
              fillOpacity: 0,
              strokeOpacity: 0
          }         
          **/  
          anchorBgShape.attr({
            ...config.anchorBg.style.inactive
          })
        })
      }
    }
  }
}

```

## 控制点的绘制

- 逻辑

```markdown
1. 还是在我们的 注册自定义节点的 afterDraw生命周期函数里绘制的
2. 这里我们绘制控制点的 方法也是单拿出文件去写的 src\Editor\g6\utils\shapeControl\index.js
```

- 代码

```js
/**
 * Created by OXOYO on 2019/8/29.
 *
 * 节点基础方法
 */
 import * as G6Util from '@antv/util'
 import utils from '../utils'
 
 export default {
   type: null,
   // 自定义节点配置，需要配置时在各个图形中覆写
   options: {},
   drawShape (cfg, group) {},
   getAnchorPoints (cfg) {...好多代码},
   setState (name, value, item) {},
   update (cfg, item) {},
   updateShape (cfg, item, style) {},
   // 绘制完成后附加锚点 和控制点
   afterDraw (cfg, group) {
     ... 好多代码  
     // 绘制shapeControl
     utils.shapeControl.draw(cfg, group)
   },
   // 更新完成后更新锚点
   afterUpdate (cfg, item) {}
 }
```

- \g6\utils\shapeControl\draw.js

```js

import config from '../../config'

export default function (cfg, group) {
  //   shapeControl 这里我们在物料的时候 就已经 有信息了 是个二维数据 跟锚点一样
  const { id, width, height, shapeControl } = cfg
  // 绘制一个边框
  group.addShape('path', {
    id: id + '_shape_control_edge',
    name: 'shapeControlEdge',
    attrs: {
      boxName: 'shapeControl',
      name: 'shapeControlEdge',
      x: 0 - width / 2,
      y: 0 - height / 2,
      width,
      height,
      path: [
        [ 'M', -width / 2, -height / 2 ],
        [ 'L', width / 2, -height / 2 ],
        [ 'L', width / 2, height / 2 ],
        [ 'L', -width / 2, height / 2 ],
        [ 'Z' ]
      ],
      // 默认样式
      ...config.shapeControl.style.default.edge
    }
  })
  // 处理控制点
  if (shapeControl && shapeControl.hasOwnProperty('controllers') && shapeControl.controllers.length) {
    for (let i = 0, len = shapeControl.controllers.length; i < len; i++) {
      // 拿到 相对坐标  
      /**  
      const shapeControl = {
        controllers: [
              [0, 0, 'nwse-resize'], 左上角
              [0, 0.5, 'ew-resize'], 左边中间位置
              [0, 1, 'nesw-resize'], 左下脚
              [0.5, 0, 'ns-resize'], 上边中间
              [0.5, 1, 'ns-resize'], 下边中间
              [1, 0, 'nesw-resize'], 右上角
              [1, 0.5, 'ew-resize'], 右边中间
              [1, 1, 'nwse-resize']  右下角
            ],
            // 旋转
            rotate: true
      }
      **/
      const [x, y, cursor] = shapeControl.controllers[i]
      // 计算Marker中心点坐标
      const originX = -width / 2
      const originY = -height / 2
      // 到这里就计算出来了每个控制点的坐标了
      const anchorX = x * width + originX
      const anchorY = y * height + originY
      // 添加Marker形状
      group.addShape('marker', {
        id: id + '_shape_control_point_' + i,
        name: 'shapeControlPoint',
        index: i,
        attrs: {
          boxName: 'shapeControl',
          name: 'shapeControlPoint',
          x: anchorX,
          y: anchorY,
          // 原始位置数据
          position: {
            x,
            y
          },
          cursor: cursor || 'pointer',
          // 默认样式
          ...config.shapeControl.style.default.point
        }
      })
    }
  }
  // 绘画全传的节点
  if (shapeControl && shapeControl.hasOwnProperty('rotate') && shapeControl.rotate) {
    const rotateW = 20
    const rotateH = 20
    group.addShape('image', {
      id: id + '_shape_control_rotate',
      name: 'shapeControlRotate',
      attrs: {
        boxName: 'shapeControl',
        name: 'shapeControlRotate',
        x: -rotateW / 2,
        y: -height / 2 - 40,
        width: rotateW,
        height: rotateH,
        cursor: 'crosshair',
        // img: require('@/assets/images/rotate.png'),
        // img:new URL(`@/assets/images/rotate.png`, import.meta.url).href,
        img:'/src/assets/images/rotate.png',
        // 默认样式
        ...config.shapeControl.style.default.rotate
      }
    })
  }
}

```

## 控制点的隐藏和显示

- 逻辑

```markdown
1. 控制点的显示 是根据鼠标在节点上按下 显示 我们上面的绘制的控制点
2. 隐藏是点击画布的时候 清楚
3. 这里还是规定了一个 active 状态 
4. 然后监听了鼠标在节点按下的时候 先清楚状态 然后设置伟active状态 让所有控制点都显示
```

- 代码 

```js
onMounted(() => {
  graph = G6.init()
  // 这里就 监听了 鼠标按下事件 然后 清楚状态	
  graph.on('node:mousedown', nodeMousedown)
  graph.on('canvas:mousedown', canvasMousedown)
})

// 清除所有的 状态 比如 显示锚点 等
const canvasMousedown = () => {
        doClearAllStates()
        // 更新currentItem
        currentItem = []
}

// 鼠标点击节点 显示控制边框和控制节点
const nodeMousedown = (event) => {
  // 先清除所有的选中状态
  doClearAllStates()
  graph.setItemState(event.item, 'active', true)
}
//先清除所有的选中状态
const doClearAllStates = () => {
        if (!graph) {
          return
        }
        // 批量操作时关闭自动重绘，以提升性能
        graph.setAutoPaint(false)
        graph.getNodes().forEach(function (node) {
          graph.clearItemStates(node, ['active', 'hover', 'selected'])
        })
        graph.getEdges().forEach(function (edge) {
          graph.clearItemStates(edge, ['active', 'hover', 'selected'])
        })
        graph.paint()
        graph.setAutoPaint(true)
}
```

```js

// 这里就是 显示控制点了 因为我们在绘制控制点的时候都是有名字的 这样就循环 然后调用 show 和hide 隐藏就好了
import config from '../../config'

export default function (name, value, item) {
  if (name === 'active') {
    const group = item.getContainer()
    const children = group.get('children')
    for (let i = 0, len = children.length; i < len; i++) {
      const child = children[i]
      if (child.attr('name')) {
        switch (child.attr('name')) {
          // 绘制的控制点的name      
          case 'shapeControlPoint':
            if (value) {
              child.show()
              child.attr(config.shapeControl.style.active.point)
            } else {
              child.attr(config.shapeControl.style.inactive.point)
              child.hide()
            }
            break
          case 'shapeControlEdge':
            if (value) {
              child.show()
              child.attr(config.shapeControl.style.active.edge)
            } else {
              child.attr(config.shapeControl.style.inactive.edge)
              child.hide()
            }
            break
          case 'shapeControlRotate':
            if (value) {
              child.show()
              child.attr(config.shapeControl.style.active.rotate)
            } else {
              child.attr(config.shapeControl.style.inactive.rotate)
              child.hide()
            }
            break
          case 'anchorPoint':
            child.hide()
        }
      }
    }
  }
}

```



