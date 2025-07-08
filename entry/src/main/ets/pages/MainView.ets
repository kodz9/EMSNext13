import { router } from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

interface GeneratedTypeLiteralInterface_1 {
  name: string;
  subtitle?: string;
  status?: boolean;
}

@Entry
@Component
struct SmartHomeControl {
  @State currentTab: string = '我的植物'
  @State currentRoom: string = '重点植物'
  @State connectedDevices: number = 15
  @State devices: Array<GeneratedTypeLiteralInterface_1> = [
    { name: '蝴蝶兰', status: false },
    { name: '万年青',  status: false },
    { name: '芦荟', status: false },
    { name: '多肉', status: false  },
    { name: '水培竹柏', status: false  },
    { name: '小香松', status: false  },
    { name: '向日葵', status: false },
    { name: '苔藓', status: false  },
    { name: '仙人掌', status: false },
    { name: '茉莉花', status: false },
    { name: '娃娃草', status: false }
  ]


  // 切换设备状态
  toggleDevice(index: number) {
    this.devices[index].status = !this.devices[index].status
    this.devices = [...this.devices] // 触发状态更新

  }

  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text('智能植物监测')
          .fontSize(30)
          .fontColor('#ffffffff')
          .fontWeight(FontWeight.Bold)
          .margin({ left: 15 })
      }
      .width('100%')
      .height(150)
      .justifyContent(FlexAlign.Start)
      .backgroundColor('#f5f5f5')
      .backgroundImage($r("app.media.plant")) // 添加背景图片
      .backgroundImageSize({ width: '100%', height: '100%' }) // 确保图片填满整个区域
      .padding({ top:0}) // 去除顶部内边距
      .margin({ top: 0 })

      // 选项卡
      Row() {
        Text(this.currentTab)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 20, right: 30 })
          .fontColor(this.currentTab === '我的植物' ? '#ff289268' : '#ff000000')
          .onClick(() => {
            this.currentTab = '我的植物'
          })

        Text(this.currentRoom)
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .margin({ right: 30 })
          .fontColor(this.currentTab === '重点植物' ? '#ff289268' : '#ff000000')
          .onClick(() => {
            this.currentTab = '重点植物'
          })

        Image($r('app.media.add'))
          .width(30)
          .height(30)
          .margin({ left : 110 })
      }
      .width('100%')
      .height(60)
      .justifyContent(FlexAlign.Start)
      .alignItems(VerticalAlign.Center)
      .border({
        width: {  // 设置边框宽度
          bottom: 2, // 下边框
        },
        color: '#ffb5b5b5',  // 边框颜色(使用你的主题绿色)
      })

      // 主内容区 - 设置为可滚动
      Scroll() {
        Column() {
          // 网关状态
          Row() {
            Column() {
              Text('我的植物总览')
                .fontSize(18)
                .margin({ bottom: 5 })
              Text(`已栽种 ${this.connectedDevices} 株植物`)
                .fontSize(14)
                .fontColor('#888888')
            }
            .width('70%')

            Image($r('app.media.icon'))
              .width(35)
              .height(35)
              .margin({ right: 10 })
          }
          .width('100%')
          .height(80)
          .justifyContent(FlexAlign.SpaceBetween)
          .alignItems(VerticalAlign.Center)
          .padding(10)
          .backgroundColor(Color.White)
          .borderRadius(8)
          .margin({ bottom: 15 })

          // 设备网格
          Grid() {
            ForEach(this.devices, (device: GeneratedTypeLiteralInterface_1, index: number) => {
              GridItem() {
                Column() {
                  Image(device.status ? $r('app.media.plants01') : $r('app.media.plants01'))
                    .width(60)
                    .height(60)
                    .margin({ bottom: 8 })

                  Text(device.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .margin({ bottom: 4 })

                  if (device.subtitle) {
                    Text(device.subtitle)
                      .fontSize(12)
                      .fontColor(device.status ? '#ff93da70' : '#888888')
                  }

                  Button(device.status ? '查看' : '查看')
                    .width('70%')
                    .height(32)
                    .margin({ top: 8 })
                    .fontSize(14)
                    .type(ButtonType.Normal)
                    .backgroundColor(device.status ? '#F5F5F5' : '#ff93da70')
                    .fontColor(device.status ? '#333333' : Color.White)
                    .onClick(() => {
                      this.toggleDevice(index)
                      console.info(`Succeeded in clicking the 'Next' button.`)
                      // 跳转到第二页
                      router.pushUrl({ url: 'pages/Index' }).then(() => {
                        console.info('Succeeded in jumping to the second page.')

                      }).catch((err: BusinessError) => {
                        console.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
                      })
                    })
                }
                .width('95%')
                .height(180)
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .backgroundColor(Color.White)
                .borderRadius(12)
                .shadow({ radius: 4, color: '#10000000', offsetX: 1, offsetY: 1 })
                .padding(10)
              }
            })
          }
          .columnsTemplate('1fr 1fr')
          .columnsGap(15)  // 列间距
          .rowsGap(15)    // 行间距
          .width('100%')
          .margin({ top: 10 })
        }
        .width('100%')
        .padding(16)
      }
      .height('67%') // 设置固定高度为屏幕的70%
      .scrollable(ScrollDirection.Vertical) // 明确设置垂直滚动
      .scrollBar(BarState.On) // 显示滚动条
      .scrollBarColor(Color.Gray) // 滚动条颜色
      .scrollBarWidth(10) // 滚动条宽度

      // 底部导航 - 固定在底部
      Row() {
        Column() {
          Image($r('app.media.mainview'))
            .width(30)
            .height(30)
            .margin({ right:80 })
          Text('首页')
            .fontSize(20)
            .margin({ right: 80 })
        }
        .onClick(() => {
          console.info(`Succeeded in clicking the 'Next' button.`)
          // 跳转到第二页
          router.pushUrl({ url: 'pages/MainView' }).then(() => {
            console.info('Succeeded in jumping to the second page.')

          }).catch((err: BusinessError) => {
            console.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
          })
        })

        Column() {
          Image($r('app.media.message'))
            .width(30)
            .height(30)
            .margin({ right:80 })
          Text('信息')
            .fontSize(20)
            .margin({ right: 80 })
        }
        .onClick(() => {
          console.info(`Succeeded in clicking the 'Next' button.`)
          // 跳转到第二页
          router.pushUrl({ url: 'pages/Message' }).then(() => {
            console.info('Succeeded in jumping to the second page.')

          }).catch((err: BusinessError) => {
            console.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
          })
        })

        Column() {
          Image($r('app.media.mine'))
            .width(30)
            .height(30)
          //  .margin({ right: 60 })
          Text('我的')
            .fontSize(20)
        }
        .onClick(() => {
          console.info(`Succeeded in clicking the 'Next' button.`)
          // 跳转到第二页
          router.pushUrl({ url: 'pages/Mine' }).then(() => {
            console.info('Succeeded in jumping to the second page.')

          }).catch((err: BusinessError) => {
            console.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
          })
        })
      }
      .padding(8)
      .width('100%')
      .height(72)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#ffeeeeee')
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#ffebebeb')
  }
}