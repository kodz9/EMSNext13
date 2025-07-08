import { StatusArray } from "../common/constants/Constant";
import EnvironmentViewModel from "../viewmodel/EnvironmentViewModel";
import { CellComponent } from "./CellComponent";

// 状态徽章背景颜色生成方法
function getStatusBadgeColor(stat: number): string {
  const baseColors: string[] = [
    '#00FF00', // 绿色
    '#FFFF00', // 黄色
    '#FF0000'  // 红色
  ];

  return baseColors[stat] + '26'; // 添加透明度
}

// 获取状态渐变色 - 调整为更浅的颜色
function getStatusGradientColors(stat: number): [string, number][] {
  switch (stat) {
    case 0: return [['#A5D6A7', 0.0], ['#C8E6C9', 1.0]]; // 更浅的绿色
    case 1: return [['#FFE082', 0.0], ['#FFF3C4', 1.0]]; // 更浅的黄色
    case 2: return [['#FFAB91', 0.0], ['#FFCCBC', 1.0]]; // 更浅的红色
    default: return [['#E0E0E0', 0.0], ['#F5F5F5', 1.0]]; // 更浅的灰色
  }
}

@Extend(Line)
function lineStyle(backgroundColor: Color) {
  .width('94%')
  .height(1)
  .backgroundColor(backgroundColor)
  .margin({ top: 4, bottom: 4 })
  .borderRadius(0.5)
}

@Component
export struct PottedPlantsComponent {
  @Prop
  item: EnvironmentViewModel;

  // 使用状态变量控制缩放效果
  @State scaleValue: number = 1;
  @State cardOpacity: number = 0;
  @State badgeScale: number = 1;

  // 修复：使用预定义的颜色常量代替构造函数
  private shadowColor: Color = Color.Gray;

  aboutToAppear() {
    // 添加卡片淡入动画
    animateTo({ duration: 600, curve: Curve.EaseOut }, () => {
      this.cardOpacity = 1;
    });
  }

  // 状态徽章构建器
  @Builder
  StatusBadge() {
    Column() {
      Text(StatusArray[this.item.stat])
        .fontColor(this.getFontColor())
        .fontSize(14)
        .fontWeight(FontWeight.Bold)
    }
    .padding({ left: 12, right: 12, top: 6, bottom: 6 })
    .borderRadius(20)
    .linearGradient({
      angle: 45,
      colors: getStatusGradientColors(this.item.stat)
    })
    .scale({ x: this.badgeScale, y: this.badgeScale })
    .shadow({
      radius: 6,
      color: this.getBackgroudColorString() + '20', // 使用字符串方法
      offsetX: 0,
      offsetY: 2
    })
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      // 徽章点击动画
      animateTo({ duration: 200 }, () => {
        this.badgeScale = 0.9;
      });
      setTimeout(() => {
        animateTo({ duration: 200 }, () => {
          this.badgeScale = 1;
        });
      }, 200);
    })
  }

  private handleClick() {
    animateTo({ duration: 200, curve: Curve.EaseInOut }, () => {
      this.scaleValue = 0.98;
    });

    setTimeout(() => {
      animateTo({ duration: 200, curve: Curve.EaseOut }, () => {
        this.scaleValue = 1;
      });
    }, 200);
  }

  build() {
    Column() {
      // 状态徽章头部
      Row() {
        // 添加状态图标
        Text(this.getStatusIcon())
          .fontSize(20)
          .margin({ right: 8 })
        
        this.StatusBadge()
      }
      .width('100%')
      .margin({ bottom: 16 })
      .justifyContent(FlexAlign.End)
      .alignItems(VerticalAlign.Center)

      // 数据行
      Column({ space: 8 }) {
        CellComponent({
          title: "🌡️ 空气温度：",
          value: `${this.item.temp} °C`,
          color: this.getFontColor()
        })

        Line().lineStyle(this.getFontColor())

        CellComponent({
          title: "💧 空气湿度：",
          value: `${this.item.hum} %`,
          color: this.getFontColor()
        })

        Line().lineStyle(this.getFontColor())

        CellComponent({
          title: "⚠️ 可燃气体：",
          value: `${this.item.gas} PPM`,
          color: this.getFontColor()
        })
      }
    }
    .linearGradient({
      angle: 135,
      colors: getStatusGradientColors(this.item.stat)
    })
    .margin({ left: 12, right: 12, top: 8, bottom: 8 })
    .padding(20)
    .borderRadius(20)
    .width('94%')
    .opacity(this.cardOpacity)
    .shadow({
      radius: 16,
      color: this.getBackgroudColorString() + '15', // 使用字符串方法
      offsetX: 0,
      offsetY: 8
    })
    .scale({ x: this.scaleValue, y: this.scaleValue })
    .onClick(() => this.handleClick())
  }

  getStatusIcon(): string {
    switch (this.item.stat) {
      case 0: return '✅';
      case 1: return '⚠️';
      case 2: return '🚨';
      default: return '❓';
    }
  }

  // 返回字符串颜色值，用于阴影等需要字符串的地方
  getBackgroudColorString(): string {
    switch (this.item.stat) {
      case 0: return '#A5D6A7'; // 更浅的绿色
      case 1: return '#FFE082'; // 更浅的黄色
      case 2: return '#FFAB91'; // 更浅的红色
      default: return '#E0E0E0'; // 更浅的灰色
    }
  }

  // 返回Color类型，用于需要Color类型的地方
  getBackgroudColor(): Color {
    switch (this.item.stat) {
      case 0: return Color.Green; // 使用预定义的绿色
      case 1: return Color.Yellow; // 使用预定义的黄色
      case 2: return Color.Red; // 使用预定义的红色
      default: return Color.Gray; // 使用预定义的灰色
    }
  }

  getFontColor(): Color {
    switch (this.item.stat) {
      case 0: return Color.Green; // 深绿色文字
      case 1: return Color.Orange; // 橙色文字
      case 2: return Color.Red; // 深红色文字
      default: return Color.Black; // 黑色文字
    }
  }
}