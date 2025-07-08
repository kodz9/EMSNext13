import router from '@ohos.router';

// 个人资料页面
@Entry
@Component
struct ProfilePage {
  build() {
    Column({ space: 20 }) {
      // 顶部标题栏（添加返回按钮）
      Row() {
        Text('<')
          .fontSize(24)
          .margin({ left: 15 })
          .onClick(() => {
            router.back();
          })

        Text('个人资料')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .margin({ left: 20 })
      }
      .width('100%')
      .padding(10)
      .backgroundColor('#FFFFFF')
      .alignItems(VerticalAlign.Center)

      // 头像区域
      Column() {
        Image($r('app.media.plant')) // 请替换为您的头像资源
          .width(80)
          .height(80)
          .borderRadius(40)
          .margin({ bottom: 10 })
        Text('点击更换头像')
          .fontSize(14)
          .fontColor('#888888')
      }
      .width('100%')
      .padding(20)
      .backgroundColor('#FFFFFF')
      .alignItems(HorizontalAlign.Center)

      // 个人信息列表
      Column() {
        this.buildProfileItem('昵称', 'PlantUser >')
        this.buildProfileItem('性别', '男 >')
        this.buildProfileItem('地区', '福建 厦门 >')
        this.buildProfileItem('手机号', '182*****27 >')
        this.buildProfileItem('账号', 'wen182*****27 >')
      }
      .width('100%')
      .margin({ top: 20 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  @Builder
  buildProfileItem(label: string, value: string) {
    Row() {
      Text(label)
        .fontSize(16)
        .fontColor('#333333')
        .layoutWeight(1)

      if (value) {
        Text(value)
          .fontSize(16)
          .fontColor(value.endsWith('>') ? '#888888' : '#333333')
      }
    }
    .width('100%')
    .padding(15)
    .backgroundColor('#FFFFFF')
    .borderRadius(0)
    .margin({ top: 1 })
  }
}