import { AIComponent } from '../view/AIComponent';
import EnvironmentViewModel from '../viewmodel/EnvironmentViewModel';
import { MqttMessage } from '@ohos/mqtt';
import MQTTUtil from '../common/utils/MQTTUtil';
import router from '@ohos.router';

@Entry
@Component
struct Index {
  @State item: EnvironmentViewModel = new EnvironmentViewModel();
  @State titleOpacity: number = 0;
  @State contentOpacity: number = 0;
  @State backButtonScale: number = 1;

  aboutToAppear(): void {
    // 添加进入动画
    setTimeout(() => {
      animateTo({ duration: 800, curve: Curve.EaseOut }, () => {
        this.titleOpacity = 1;
      });
    }, 100);
    
    setTimeout(() => {
      animateTo({ duration: 800, curve: Curve.EaseOut }, () => {
        this.contentOpacity = 1;
      });
    }, 300);

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

  private handleBackButtonPress() {
    animateTo({ duration: 150 }, () => {
      this.backButtonScale = 0.95;
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

  @Builder
  HeaderBuilder() {
    Row() {
      // 装饰性图标
      Text('🤖')
        .fontSize(24)
        .margin({ right: 12 })
      
      Column() {
        Text("智能助手")
          .fontSize(22)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
        
        Text("AI驱动的植物养护专家")
          .fontSize(12)
          .fontColor('#E8F5E8')
          .margin({ top: 2 })
      }
      .alignItems(HorizontalAlign.Start)
      
      Blank()
      
      // 状态指示灯
      Row() {
        Circle({ width: 8, height: 8 })
          .fill('#4CAF50')
        Text('在线')
          .fontSize(12)
          .fontColor('#E8F5E8')
          .margin({ left: 6 })
      }
    }
    .width('100%')
    .height(70)
    .padding({ left: 20, right: 20, top: 10, bottom: 10 })
    .linearGradient({
      angle: 90,
      colors: [['#4CAF50', 0.0], ['#388E3C', 1.0]]
    })
    .shadow({
      radius: 12,
      color: '#4CAF5030',
      offsetX: 0,
      offsetY: 4
    })
    .opacity(this.titleOpacity)
  }

  build() {
    Stack() {
      Column() {
        this.HeaderBuilder()
        
        // 主要内容区域
        Column() {
          AIComponent({ item: this.item })
        }
        .width('100%')
        .height('100%')
        .padding({ top: 16 })
        .opacity(this.contentOpacity)
      }
      .height('100%')
      .width('100%')
      .linearGradient({
        angle: 180,
        colors: [['#F1F8E9', 0.0], ['#E8F5E8', 0.5], ['#FFFFFF', 1.0]]
      })

      // 返回按钮 - 位于左下角
      Button() {
        Row({ space: 8 }) {
          Image($r('sys.media.ohos_ic_back'))
            .width(20)
            .height(20)
            .fillColor(Color.White)
          Text('返回')
            .fontSize(14)
            .fontColor(Color.White)
            .fontWeight(500)
        }
      }
      .width(80)
      .height(40)
      .backgroundColor('#4CAF50')
      .borderRadius(20)
      .scale({ x: this.backButtonScale, y: this.backButtonScale })
      .shadow({
        radius: 8,
        color: '#4CAF5040',
        offsetX: 0,
        offsetY: 4
      })
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
      .position({ x: 20, y: '90%' })
    }
    .width('100%')
    .height('100%')
  }
}