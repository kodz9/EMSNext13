import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import Rdb from '../common/database/Rdb';

@Entry
@Component
struct login {
  @State username: string = '';
  @State password: string = '';
  @State confirmPassword: string = '';
  @State phone: string = '';

  build() {
    Column(){
      Text("MyPlant")
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .margin({top:80, bottom:30})
      Image($r('app.media.icon'))
        .height(100).width(100)
        .margin({top:50, bottom:30})
        .borderRadius(100)
      TextInput({ placeholder: '用户名' }).width("80%").height(50).margin(10)
        .onChange((value: string) => { this.username = value })
      TextInput({ placeholder: '密码' }).width("80%").height(50).margin(10)
        .type(InputType.Password)
        .onChange((value: string) => { this.password = value })
      Button("登  录")
        .width("60%")
        .height(50)
        .margin(20)
        .backgroundColor("#A8E6A3")
        .fontColor(Color.Black)
        //.fontColor("#207744")
          //.fontWeight(FontWeight.Bold)
        .fontSize(22)
        .onClick(() => {
          if (!this.username || !this.password) {
            promptAction.showToast({ message: '请输入用户名和密码' });
            return;
          }
          // 验证登录
          Rdb.queryUser(this.username, this.password, (success: boolean) => {
            if (success) {
              promptAction.showToast({ message: '登录成功' });
              router.pushUrl({ url: 'pages/MainView' });
            } else {
              promptAction.showToast({ message: '用户名或密码错误' });
            }
          });
        })

      Button("注  册")
        .width("60%")
        .height(50)
        .margin(10)
        .backgroundColor("#D2F5C7")
        .fontColor(Color.Black)
        .fontSize(22)
        .onClick(() => {
          router.pushUrl({ url: 'pages/Register' });
        })

    }.height("100%")
    .width("100%")
  }
}