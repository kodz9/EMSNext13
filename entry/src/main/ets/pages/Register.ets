import router from '@ohos.router';
import promptAction from '@ohos.promptAction';
import Rdb from '../common/database/Rdb';

@Component
@Entry
struct RegisterPage {
  @State username: string = '';
  @State password: string = '';
  @State confirmPassword: string = '';

  build() {
    Column() {
      Text('用户注册')
        .fontSize(40)
        .fontWeight(FontWeight.Bold)
        .margin({ top: 80, bottom: 30 })
      TextInput({ placeholder: '用户名' })
        .width('80%').height(50).margin(10)
        .onChange((value: string) => { this.username = value })
      TextInput({ placeholder: '密码' })
        .width('80%').height(50).margin(10)
        .type(InputType.Password)
        .onChange((value: string) => { this.password = value })
      TextInput({ placeholder: '确认密码' })
        .width('80%').height(50).margin(10)
        .type(InputType.Password)
        .onChange((value: string) => { this.confirmPassword = value })
      Button('注  册')
        .width('60%')
        .height(50)
        .margin(20)
        .backgroundColor('#A8E6A3')
        .fontColor(Color.Black)
        .fontSize(22)
        .onClick(() => {
          if (!this.username || !this.password || !this.confirmPassword) {
            promptAction.showToast({ message: '请填写完整信息' });
            return;
          }
          if (this.password !== this.confirmPassword) {
            promptAction.showToast({ message: '两次密码不一致' });
            return;
          }
          Rdb.checkUsername(this.username, (exists: boolean) => {
            if (exists) {
              promptAction.showToast({ message: '用户名已存在' });
              return;
            }
            Rdb.insertData({
              username: this.username,
              password: this.password
            }, (success: boolean) => {
              if (success) {
                promptAction.showToast({ message: '注册成功' });
                router.pushUrl({ url: 'pages/Login' });
              } else {
                promptAction.showToast({ message: '注册失败，请重试' });
              }
            });
          });
        })
      Button('返  回')
        .width('60%')
        .height(50)
        .margin(10)
        .backgroundColor('#D2F5C7')
        .fontColor(Color.Black)
        .fontSize(22)
        .onClick(() => {
          router.pushUrl({ url: 'pages/Login' });
        })
    }
    .height('100%')
    .width('100%')
  }
} 