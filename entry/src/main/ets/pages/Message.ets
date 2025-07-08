import router from '@ohos.router';
import { BusinessError } from '@kit.BasicServicesKit';

// 明确定义消息类型接口
interface PlantMessage {
  title: string;
  content: string;
  sender: string;
  time: string;
  unread: boolean;
}

@Entry
@Component
struct PlantMessagePage {
  // 使用明确定义的类型
  @State messages: PlantMessage[] = [
    {
      title: "温度异常提醒",
      content: "您的植物【绿萝】当前温度已达32°C，超过适宜温度范围(18-28°C)，请及时调整环境温度。",
      sender: "PlantGuard系统",
      time: "今天 09:30",
      unread: true
    } as PlantMessage,
    {
      title: "浇水提醒",
      content: "您的植物【多肉】已7天未浇水，土壤湿度低于20%，建议立即浇水。",
      sender: "PlantCare系统",
      time: "昨天 14:45",
      unread: true
    } as PlantMessage,
    // 添加更多消息以测试滚动效果
    {
      title: "光照不足警告",
      content: "检测到植物【龟背竹】最近24小时光照时长不足4小时，建议移至光照更充足位置。",
      sender: "PlantMonitor",
      time: "昨天 11:20",
      unread: false
    },
    {
      title: "营养液补充提醒",
      content: "根据生长周期分析，您的植物【发财树】需要补充营养液了，推荐使用通用型植物营养液。",
      sender: "PlantCare系统",
      time: "周一 16:30",
      unread: false
    },
    {
      title: "环境报告周报",
      content: "过去一周您的植物【绿萝】生长环境数据：平均温度25°C，湿度60%，光照6小时/天，生长状态良好。",
      sender: "PlantGuard系统",
      time: "上周日 08:00",
      unread: false
    },
    {
      title: "新植物推荐",
      content: "根据您的养护习惯，我们为您推荐【虎尾兰】，这种植物耐阴且需水量少，非常适合您的环境。",
      sender: "PlantAdvisor",
      time: "上周六 10:15",
      unread: true
    }
  ];

  // 创建消息副本的方法
  private copyMessage(msg: PlantMessage): PlantMessage {
    return {
      title: msg.title,
      content: msg.content,
      sender: msg.sender,
      time: msg.time,
      unread: msg.unread
    };
  }

  build() {
    Column() {
      // 标题栏（固定不滚动）
      Row() {
        Text('<')
          .fontSize(24)
          .margin({ left: 15 })
          .onClick(() => {
            router.back();
          })

        Text('植物监测消息')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 20 })
      }
      .width('100%')
      .padding(10)
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // 可滚动的内容区域
      Scroll() {
        Column({ space: 70 }) {
          // 消息列表
          List({ space: 10 }) {
            ForEach(this.messages, (item: PlantMessage, index: number) => {
              ListItem() {
                Column() {
                  Row() {
                    Text(item.title)
                      .fontSize(18)
                      .fontWeight(item.unread ? FontWeight.Bold : FontWeight.Normal)
                      .fontColor(item.unread ? '#000000' : '#666666')
                      .layoutWeight(1)

                    Text(item.time)
                      .fontSize(12)
                      .fontColor('#999999')
                  }
                  .width('100%')
                  .margin({ bottom: 5 })

                  Text(item.sender)
                    .fontSize(14)
                    .fontColor('#1A8CFF')
                    .margin({ bottom: 15 })

                  Text(item.content)
                    .fontSize(15)
                    .fontColor('#333333')
                    .maxLines(2)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })

                  Divider()
                    .strokeWidth(1)
                    .color('#F0F0F0')
                    .margin({ top: 12 })
                }
                .width('100%')
                .padding(15)
                .backgroundColor('#FFFFFF')
              }
              .onClick(() => {
                // 使用显式对象创建替代展开运算符
                const newMessages = this.messages.map((msg, i) => {
                  if (i === index) {
                    const newMsg = this.copyMessage(msg);
                    newMsg.unread = false;
                    return newMsg;
                  }
                  return this.copyMessage(msg);
                });
                this.messages = newMessages;
              })
            })
          }
          .width('100%')
          .divider({ strokeWidth: 0 })
        }
      }
      .width('100%')
      .height(680)


      // 底部导航栏（固定不滚动）
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
    .backgroundColor('#F5F5F5')
  }
}