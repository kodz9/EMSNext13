import router from '@ohos.router';
import { BusinessError } from '@kit.BasicServicesKit';

// 主页面
@Entry
@Component
struct GatewayManagementPage {
  @State menuItems: GatewayMenuItem[] = [
    { name: '个人资料', checked: false },
    { name: '账号管理', checked: false },
    { name: '消息中心', checked: false },
    { name: '意见反馈', checked: false },
    { name: '帮助中心', checked: false },
    { name: '账号切换', checked: false },
    { name: '关于我们', checked: false }
  ];

  build() {
    Column({ space: 73 }) {
      // 标题栏
      Text('MyPlant')
        .fontSize(45)
        .fontWeight(FontWeight.Bold)
        .fontColor('#333333')
        .margin({ top: 50, bottom: 30 })
        .width('100%')
        .textAlign(TextAlign.Center)

      // 菜单列表 - 改为可点击的按钮
      Column() {
        ForEach(this.menuItems, (item: GatewayMenuItem, index: number) => {
          Button(item.name, { type: ButtonType.Normal })
            .width('90%')
            .height(50)
            .fontSize(18)
            .fontColor('#333333')
            .backgroundColor('#FFFFFF')
            .borderRadius(8)
            .margin({ bottom: 10 })
            .onClick(() => {
              // 点击"个人资料"跳转
              if (index === 0) {
                router.pushUrl({
                  url: 'pages/Individual'
                });
              }
            })
        })
      }
      .width('100%')
      .margin({ bottom: 30 })

      // 底部导航栏
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
    .height('100%')
    .width('100%')
    .backgroundColor('#F5F5F5')
  }
}

interface GatewayMenuItem {
  name: string;
  checked: boolean;
}
