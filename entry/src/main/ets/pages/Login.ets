@Entry
@Component
struct login {
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
      TextInput().width("80%").height(50).margin(10)
      TextInput().width("80%").height(50).margin(10)
        .type(InputType.Password)
      Button("登  录")
        .width("60%")
        .height(50)
        .margin(20)
        .backgroundColor("#A8E6A3")
        .fontColor("#207744")
          //.fontWeight(FontWeight.Bold)
        .fontSize(22)
      Button("注  册")
        .width("60%")
        .height(50)
        .margin(10)
        .backgroundColor("#D2F5C7")
        .fontColor("#207744")
          //.fontWeight(FontWeight.Bold)
        .fontSize(22)
    }.height("100%")
    .width("100%")
  }
}