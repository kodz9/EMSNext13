import { McLineChart, Options } from '@mcui/mccharts'
import EnvironmentViewModel from '../viewmodel/EnvironmentViewModel';

@Component
export struct SwiperComponent {
  @State tempArray: number[] = [11, 11, 15, 13, 12, 35, 10];
  @State humArray: number[] = [51, 41, 45, 68, 60, 50, 40];
  @State gasArray: number[] = [101, 211, 215, 213, 212, 135, 110];
  @State swiperOpacity: number = 0;
  @State currentIndex: number = 0;

  aboutToAppear() {
    // 添加组件淡入动画
    animateTo({ duration: 800, curve: Curve.EaseOut }, () => {
      this.swiperOpacity = 1;
    });
  }

  @State tempOption: Options = new Options({
    title: {
      show: true,
      text: '🌡️ 温度趋势',
      left: 20,
      top: 20,
      textStyle: {
        fontSize: 16,
        fontWeight: 'bold',
        color: '#2E7D32'
      }
    },
    color: ['#4CAF50'],
    grid: {
      left: '10%',
      right: '10%',
      top: '25%',
      bottom: '15%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
      axisLine: {
        lineStyle: {
          color: '#81C784'
        }
      },
      axisLabel: {
        color: '#2E7D32',
        fontSize: 12
      }
    },
    yAxis: {
      type: 'value',
      name: '温度 (°C)',
      nameTextStyle: {
        color: '#2E7D32',
        fontSize: 12
      },
      axisLine: {
        lineStyle: {
          color: '#81C784'
        }
      },
      axisLabel: {
        color: '#2E7D32',
        fontSize: 12
      },
      splitLine: {
        lineStyle: {
          color: '#E8F5E8',
          type: 'dashed'
        }
      }
    },
    series: [
      {
        name: '温度',
        type: 'line',
        data: this.tempArray,
        smooth: true,
        lineStyle: {
          width: 3,
          color: '#4CAF50'
        },
        itemStyle: {
          color: '#4CAF50',
          borderWidth: 2,
          borderColor: '#FFFFFF'
        },
        areaStyle: {
          color: {
            type: 'linear',
            x: 0,
            y: 0,
            x2: 0,
            y2: 1,
            colorStops: [
              { offset: 0, color: '#4CAF5080' },
              { offset: 1, color: '#4CAF5010' }
            ]
          }
        }
      }
    ]
  })

  @State humOption: Options = new Options({
    title: {
      show: true,
      text: '💧 湿度趋势',
      left: 20,
      top: 20,
      textStyle: {
        fontSize: 16,
        fontWeight: 'bold',
        color: '#1976D2'
      }
    },
    color: ['#2196F3'],
    grid: {
      left: '10%',
      right: '10%',
      top: '25%',
      bottom: '15%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
      axisLine: {
        lineStyle: {
          color: '#64B5F6'
        }
      },
      axisLabel: {
        color: '#1976D2',
        fontSize: 12
      }
    },
    yAxis: {
      type: 'value',
      name: '湿度 (%)',
      nameTextStyle: {
        color: '#1976D2',
        fontSize: 12
      },
      axisLine: {
        lineStyle: {
          color: '#64B5F6'
        }
      },
      axisLabel: {
        color: '#1976D2',
        fontSize: 12
      },
      splitLine: {
        lineStyle: {
          color: '#E3F2FD',
          type: 'dashed'
        }
      }
    },
    series: [
      {
        name: '湿度',
        type: 'line',
        data: this.humArray,
        smooth: true,
        lineStyle: {
          width: 3,
          color: '#2196F3'
        },
        itemStyle: {
          color: '#2196F3',
          borderWidth: 2,
          borderColor: '#FFFFFF'
        },
        areaStyle: {
          color: {
            type: 'linear',
            x: 0,
            y: 0,
            x2: 0,
            y2: 1,
            colorStops: [
              { offset: 0, color: '#2196F380' },
              { offset: 1, color: '#2196F310' }
            ]
          }
        }
      }
    ]
  })

  @State gasOption: Options = new Options({
    title: {
      show: true,
      text: '⚠️ 气体浓度',
      left: 20,
      top: 20,
      textStyle: {
        fontSize: 16,
        fontWeight: 'bold',
        color: '#F57C00'
      }
    },
    color: ['#FF9800'],
    grid: {
      left: '10%',
      right: '10%',
      top: '25%',
      bottom: '15%',
      containLabel: true
    },
    xAxis: {
      type: 'category',
      data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日'],
      axisLine: {
        lineStyle: {
          color: '#FFB74D'
        }
      },
      axisLabel: {
        color: '#F57C00',
        fontSize: 12
      }
    },
    yAxis: {
      type: 'value',
      name: '浓度 (PPM)',
      nameTextStyle: {
        color: '#F57C00',
        fontSize: 12
      },
      axisLine: {
        lineStyle: {
          color: '#FFB74D'
        }
      },
      axisLabel: {
        color: '#F57C00',
        fontSize: 12
      },
      splitLine: {
        lineStyle: {
          color: '#FFF3E0',
          type: 'dashed'
        }
      }
    },
    series: [
      {
        name: '可燃气体浓度',
        type: 'line',
        data: this.gasArray,
        smooth: true,
        lineStyle: {
          width: 3,
          color: '#FF9800'
        },
        itemStyle: {
          color: '#FF9800',
          borderWidth: 2,
          borderColor: '#FFFFFF'
        },
        areaStyle: {
          color: {
            type: 'linear',
            x: 0,
            y: 0,
            x2: 0,
            y2: 1,
            colorStops: [
              { offset: 0, color: '#FF980080' },
              { offset: 1, color: '#FF980010' }
            ]
          }
        }
      }
    ]
  })

  updata(array: number[], value: number) {
    if (!array)
      return;
    array.push(value)
    if (array.length > 7) {
      array.splice(0, 1)
    }
  }

  upOption() {
    this.tempOption.setVal({
      series: [
        {
          name: '温度',
          data: this.tempArray
        }
      ]
    })
    this.humOption.setVal({
      series: [
        {
          name: '湿度',
          data: this.humArray
        }
      ]
    })
    this.gasOption.setVal({
      series: [
        {
          name: '可燃气体浓度',
          data: this.gasArray
        }
      ]
    })
  }

  @Prop @Watch('onItemUpdated')
  item: EnvironmentViewModel = new EnvironmentViewModel();

  onItemUpdated() {
    this.updata(this.tempArray, this.item.temp)
    this.updata(this.humArray, this.item.hum)
    this.updata(this.gasArray, this.item.gas)
    this.upOption();
  }

  build() {
    Column() {
      // 标题区域
      Row() {
        Text('📊 数据趋势分析')
          .fontSize(18)
          .fontWeight(FontWeight.Bold)
          .fontColor('#2E7D32')
        
        Blank()
        
        // 当前页面指示器
        Row({ space: 4 }) {
          ForEach([0, 1, 2], (index: number) => {
            Circle({ width: 8, height: 8 })
              .fill(this.currentIndex === index ? '#4CAF50' : '#E0E0E0')
              .animation({
                duration: 300,
                curve: Curve.EaseInOut
              })
          })
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 8, bottom: 12 })

      // Swiper容器
      Swiper() {
        // 温度图表
        Column() {
          McLineChart({
            options: this.tempOption
          })
            .height('100%')
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .borderRadius(20)
        .linearGradient({
          angle: 135,
          colors: [['#FFFFFF', 0.0], ['#F1F8E9', 1.0]]
        })
        .shadow({
          radius: 12,
          color: '#4CAF5020',
          offsetX: 0,
          offsetY: 6
        })

        // 湿度图表
        Column() {
          McLineChart({
            options: this.humOption
          })
            .height('100%')
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .borderRadius(20)
        .linearGradient({
          angle: 135,
          colors: [['#FFFFFF', 0.0], ['#E3F2FD', 1.0]]
        })
        .shadow({
          radius: 12,
          color: '#2196F320',
          offsetX: 0,
          offsetY: 6
        })

        // 气体图表
        Column() {
          McLineChart({
            options: this.gasOption
          })
            .height('100%')
        }
        .width('100%')
        .height('100%')
        .padding(16)
        .borderRadius(20)
        .linearGradient({
          angle: 135,
          colors: [['#FFFFFF', 0.0], ['#FFF3E0', 1.0]]
        })
        .shadow({
          radius: 12,
          color: '#FF980020',
          offsetX: 0,
          offsetY: 6
        })
      }
      .loop(true)
      .autoPlay(true)
      .interval(4000)
      .indicator(false) // 隐藏默认指示器
      .onChange((index: number) => {
        this.currentIndex = index;
      })
      .width('100%')
      .height(280)
    }
    .width('94%')
    .margin({ left: 12, right: 12, top: 8, bottom: 8 })
    .padding(12)
    .borderRadius(20)
    .opacity(this.swiperOpacity)
    .linearGradient({
      angle: 180,
      colors: [['#FFFFFF', 0.0], ['#FAFAFA', 1.0]]
    })
    .shadow({
      radius: 16,
      color: '#00000015',
      offsetX: 0,
      offsetY: 8
    })
  }
}