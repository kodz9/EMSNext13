import { PottedPlantsComponent } from '../view/PottedPlantsComponent'
import { AIComponent } from '../view/AIComponent';
import { SwiperComponent } from '../view/SwiperComponent';
import EnvironmentViewModel from '../viewmodel/EnvironmentViewModel';
import { MqttMessage } from '@ohos/mqtt';
import MQTTUtil from '../common/utils/MQTTUtil';
import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State item: EnvironmentViewModel = new EnvironmentViewModel();
  @State aiButtonScale: number = 1;
  @State headerOpacity: number = 0;
  @State backButtonScale: number = 1; // 返回按钮缩放状态

  aboutToAppear(): void {
    // 添加头部淡入动画
    animateTo({ duration: 800, curve: Curve.EaseOut }, () => {
      this.headerOpacity = 1;
    });

    new MQTTUtil().connect(
      (err: Error, data: MqttMessage) => {
        //如果没有出错就处理数据
        if (!err) {
          //解析接收到的数据为EnvironmentViewModel对象
          this.item = JSON.parse(String(data.payload)) as EnvironmentViewModel;

          //如果实例不为空就更新状态变量
          if (!this.item) {
            this.item = new EnvironmentViewModel()
          }
        }
      }
    )
  }

  // AI按钮点击处理
  private handleAIButtonPress() {
    animateTo({ duration: 150 }, () => {
      this.aiButtonScale = 0.95;
    });
  }

  private handleAIButtonRelease() {
    animateTo({ duration: 150 }, () => {
      this.aiButtonScale = 1;
    });
  }

  private navigateToAI() {
    router.pushUrl({
      url: 'pages/AI',
      params: {
        item: this.item
      }
    });
  }

  // 返回按钮点击处理
  private handleBackButtonPress() {
    animateTo({ duration: 150 }, () => {
      this.backButtonScale = 0.9;
    });
  }

  private handleBackButtonRelease() {
    animateTo({ duration: 150 }, () => {
      this.backButtonScale = 1;
    });
  }

  private goBack() {
    router.back();
  }

  // 美化的AI按钮组件
  @Builder
  AIButton() {
    Row({ space: 12 }) {
      // AI图标
      Image($r('app.media.ai_green_128'))
        .width(28)
        .height(28)
        .borderRadius(14)

      Column({ space: 2 }) {
        Text('AI智能分析')
          .fontSize(14)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
        Text('点击获取专业养护建议')
          .fontSize(10)
          .fontColor('#F0F8F0')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // 箭头图标
      Text('→')
        .fontSize(18)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Bold)
    }
    .width('94%')
    .height(55)
    .padding({ left: 16, right: 16 })
    .backgroundColor('#81C784')
    .borderRadius(12)
    .scale({ x: this.aiButtonScale, y: this.aiButtonScale })
    .shadow({
      radius: 8,
      color: '#81C78420',
      offsetX: 0,
      offsetY: 4
    })
    .linearGradient({
      angle: 45,
      colors: [['#81C784', 0.0], ['#A5D6A7', 1.0]]
    })
    .onTouch((event) => {
      if (event.type === TouchType.Down) {
        this.handleAIButtonPress();
      } else if (event.type === TouchType.Up) {
        this.handleAIButtonRelease();
      }
    })
    .onClick(() => {
      this.navigateToAI();
    })
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 主要内容
      Column({ space: 12 }) {
        // 美化的头部 - 调整为右对齐布局
        Row() {
          // 左侧占位空间，为返回按钮留出位置
          Column()
            .width(60)
            .height(50)
          
          // 中间弹性空间
          Column()
            .layoutWeight(1)
          
          // 标题靠右显示
          Text("🌱 环境监测系统")
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor('#FFFFFF')
            .textAlign(TextAlign.Center)
            .width(200)
            .height(50)
            .borderRadius(12)
            .linearGradient({
              angle: 135,
              colors: [['#81C784', 0.0], ['#66BB6A', 1.0]]
            })
            .shadow({
              radius: 6,
              color: '#81C78420',
              offsetX: 0,
              offsetY: 3
            })
          
          // 右侧小间距
          Column()
            .width(12)
        }
        .opacity(this.headerOpacity)
        .margin({ left: 8, right: 8 })
        .width('100%')

        // 主要内容区域 - 减少间距
        Column({ space: 8 }) {
          PottedPlantsComponent({ item: this.item })
          SwiperComponent({ item: this.item })
          
          // AI按钮
          this.AIButton()
        }
        .layoutWeight(1)
      }
      .height('100%')
      .width('100%')
      .padding({ top: 16, bottom: 16, left: 4, right: 4 })
      .linearGradient({
        angle: 180,
        colors: [['#F8FDF8', 0.0], ['#F1F8F1', 1.0]]
      })

      // 返回按钮 - 定位在左上角
      Row() {
        Text('←')
          .fontSize(18)
          .fontColor('#FFFFFF')
          .fontWeight(FontWeight.Bold)
      }
      .width(45)
      .height(45)
      .backgroundColor('#66BB6A')
      .borderRadius(22.5)
      .justifyContent(FlexAlign.Center)
      .alignItems(VerticalAlign.Center)
      .scale({ x: this.backButtonScale, y: this.backButtonScale })
      .shadow({
        radius: 6,
        color: '#66BB6A30',
        offsetX: 0,
        offsetY: 3
      })
      .margin({ left: 16, top: 25 })
      .onTouch((event) => {
        if (event.type === TouchType.Down) {
          this.handleBackButtonPress();
        } else if (event.type === TouchType.Up) {
          this.handleBackButtonRelease();
        }
      })
      .onClick(() => {
        this.goBack();
      })
    }
  }
}