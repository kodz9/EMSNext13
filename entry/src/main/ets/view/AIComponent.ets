import EnvironmentViewModel from "../viewmodel/EnvironmentViewModel";

import ResultData from '../model/ResultData';
import HttpUtil from '../common/utils/HttpUtil';
import { promptAction } from '@kit.ArkUI';

@Component
export struct AIComponent {
  @Prop
  item: EnvironmentViewModel;
  @State
  resultString: string = '🌱 欢迎使用绿植伙伴AI助手\n\n点击右上方按钮开始智能评估您的植物生长环境'
  @State
  isBusy: boolean = false;
  @State
  buttonScale: number = 1;
  @State
  cardOpacity: number = 1;

  aiRequest() {
    //判断是否在请求中
    if (this.isBusy) {
      promptAction.showToast({
        message: 'AI 大模型评估中。。。',
        duration: 2000
      });
      return;
    }

    //判断当前数据是否有效
    if (!this.item) {
      promptAction.showToast({
        message: '评估数据无效',
        duration: 2000
      });
      return;
    }

    //设置请求参数
    let parm =
      `你是一名专业的植物养护顾问，名称为"绿植伙伴"。基于实时检测的**温度、湿度、植物种类和可燃气体**指标，主要关注植物健康需求，在确保安全的前提下提供专业的养护建议。内容为120字左右，当前环境为，温度:${this.item.temp}度，湿度:${this.item.hum}%，可燃气体:${this.item.gas}ppm`

    //改变状态
    this.isBusy = true;
    
    // 添加淡出动画
    animateTo({ duration: 300 }, () => {
      this.cardOpacity = 0.7;
    });

    //AI分析请求
    HttpUtil.post<ResultData, string>('ai/analysis', parm)
      .then((data: ResultData) => {
        //成功后处理数据
        if (data?.success) {
          this.resultString = `🤖 绿植伙伴AI分析结果：\n\n${data.data}`;
        }
      })
      .finally(() => {
        //最后更新状态
        this.isBusy = false;
        // 恢复透明度
        animateTo({ duration: 300 }, () => {
          this.cardOpacity = 1;
        });
      })
  }

  private handleButtonPress() {
    animateTo({ duration: 150 }, () => {
      this.buttonScale = 0.95;
    });
  }

  private handleButtonRelease() {
    animateTo({ duration: 150 }, () => {
      this.buttonScale = 1;
    });
  }

  build() {
    Column() {
      // 头部区域
      Row() {
        // AI图标容器
        Row() {
          Image($r('app.media.ai_green_128'))
            .width(45)
            .height(45)
            .borderRadius(22.5)
            .shadow({
              radius: 8,
              color: '#4CAF5040',
              offsetX: 0,
              offsetY: 2
            })
        }
        .padding(8)
        .backgroundColor('#E8F5E8')
        .borderRadius(25)

        Blank()

        // 状态指示器
        if (this.isBusy) {
          Row({ space: 12 }) {
            LoadingProgress()
              .width(32)
              .height(32)
              .color('#4CAF50')
            
            Column() {
              Text('AI分析中')
                .fontSize(14)
                .fontWeight(600)
                .fontColor('#4CAF50')
              Text('请稍候...')
                .fontSize(12)
                .fontColor('#81C784')
                .margin({ top: 2 })
            }
            .alignItems(HorizontalAlign.Start)
          }
          .padding({ left: 16, right: 16, top: 8, bottom: 8 })
          .backgroundColor('#E8F5E8')
          .borderRadius(20)
        }

        Blank()

        // AI评估按钮
        Button('🚀 AI评估')
          .fontSize(16)
          .fontWeight(600)
          .height(44)
          .padding({ left: 20, right: 20 })
          .backgroundColor(this.isBusy ? '#CCCCCC' : '#4CAF50')
          .borderRadius(22)
          .enabled(!this.isBusy)
          .scale({ x: this.buttonScale, y: this.buttonScale })
          .shadow({
            radius: this.isBusy ? 4 : 8,
            color: this.isBusy ? '#00000020' : '#4CAF5040',
            offsetX: 0,
            offsetY: this.isBusy ? 2 : 4
          })
          .onTouch((event) => {
            if (event.type === TouchType.Down) {
              this.handleButtonPress();
            } else if (event.type === TouchType.Up) {
              this.handleButtonRelease();
            }
          })
          .onClick(() => {
            this.aiRequest();
          })
      }
      .width('100%')
      .padding({ left: 4, right: 4 })
      .justifyContent(FlexAlign.SpaceBetween)

      // 结果显示区域
      Column() {
        Scroll() {
          Text(this.resultString)
            .lineHeight(28)
            .fontSize(15)
            .fontColor('#2E7D32')
            .width('100%')
            .padding(16)
        }
        .height('100%')
        .scrollBar(BarState.Auto)
        .scrollBarColor('#4CAF50')
        .scrollBarWidth(3)
      }
      .width('100%')
      .height('82%')
      .margin({ top: 16 })
      .backgroundColor('#FAFAFA')
      .borderColor('#E0E0E0')
      .borderWidth(1)
      .borderRadius(16)
      .opacity(this.cardOpacity)
      .shadow({
        radius: 12,
        color: '#00000015',
        offsetX: 0,
        offsetY: 4
      })

      Blank()
    }
    .alignItems(HorizontalAlign.Center)
    .padding(16)
    .width('100%')
    .height('100%')
    .borderRadius(20)
    .linearGradient({
      angle: 135,
      colors: [['#FFFFFF', 0.0], ['#F1F8E9', 1.0]]
    })
    .shadow({
      radius: 16,
      color: '#00000010',
      offsetX: 0,
      offsetY: 6
    })
    .margin({ left: 12, right: 12, top: 8, bottom: 8 })
  }
}