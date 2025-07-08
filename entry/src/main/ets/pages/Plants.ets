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

  // 美化的AI按钮组件
  @Builder
  AIButton() {
    Row({ space: 12 }) {
      // AI图标
      Image($r('app.media.ai_green_128'))
        .width(32)
        .height(32)
        .borderRadius(16)

      Column({ space: 4 }) {
        Text('AI智能分析')
          .fontSize(16)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
        Text('点击获取专业养护建议')
          .fontSize(12)
          .fontColor('#E8F5E8')
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)

      // 箭头图标
      Text('→')
        .fontSize(20)
        .fontColor('#FFFFFF')
        .fontWeight(FontWeight.Bold)
    }
    .width('94%')
    .height(70)
    .padding({ left: 20, right: 20 })
    .backgroundColor('#4CAF50')
    .borderRadius(16)
    .scale({ x: this.aiButtonScale, y: this.aiButtonScale })
    .shadow({
      radius: 12,
      color: '#4CAF5040',
      offsetX: 0,
      offsetY: 6
    })
    .linearGradient({
      angle: 45,
      colors: [['#4CAF50', 0.0], ['#66BB6A', 1.0]]
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
    Column({ space: 16 }) {
      // 美化的头部
      Column() {
        Text("🌱 环境监测系统")
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#FFFFFF')
          .textAlign(TextAlign.Center)
          .width('100%')
          .height(60)
          .borderRadius(16)
          .linearGradient({
            angle: 135,
            colors: [['#4CAF50', 0.0], ['#2E7D32', 1.0]]
          })
          .shadow({
            radius: 8,
            color: '#4CAF5030',
            offsetX: 0,
            offsetY: 4
          })
      }
      .opacity(this.headerOpacity)
      .margin({ left: 12, right: 12 })

      // 主要内容区域
      Column({ space: 12 }) {
        PottedPlantsComponent({ item: this.item })
        SwiperComponent({ item: this.item })
        
        // AI按钮
        this.AIButton()
      }
      .layoutWeight(1)
    }
    .height('100%')
    .width('100%')
    .padding({ top: 20, bottom: 20 })
    .linearGradient({
      angle: 180,
      colors: [['#F1F8E9', 0.0], ['#E8F5E8', 1.0]]
    })
  }
}