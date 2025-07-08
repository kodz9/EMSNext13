import router from '@ohos.router';

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
    Column({ space: 40 }) {
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
        Text('首页')
          .fontSize(16)
          .fontColor('#1A8CFF')

        Text('场景')
          .fontSize(16)
          .fontColor('#999999')

        Text('我的')
          .fontSize(16)
          .fontColor('#999999')
      }
      .width('100%')
      .height(60)
      .padding({ left: 40, right: 40 })
      .backgroundColor('#FFFFFF')
      .position({ bottom: 0 })
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
