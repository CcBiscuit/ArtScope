import { ReminderItem, ReminderType } from '../common/constants/CalendarConstants'
import router from '@ohos.router'

interface ReminderPageParams {
  date: string
}

@Entry
@Component
struct ReminderPage {
  @State reminder: ReminderItem = {
    title: '',
    startTime: '',
    endTime: '',
    reminderTime: '1天前',
    reminderType: ReminderType.NOTIFICATION,
    note: ''
  }
  private date: string = this.getRouterDate()

  private getRouterDate(): string {
    const params = router.getParams() as ReminderPageParams
    if (!params || !params.date) {
      // 如果没有传入日期参数，使用当前日期
      const now = new Date()
      const year = now.getFullYear()
      const month = String(now.getMonth() + 1).padStart(2, '0')
      const day = String(now.getDate()).padStart(2, '0')
      return `${year}-${month}-${day}`
    }
    return params.date
  }

  aboutToAppear() {
    // 初始化开始和结束时间
    this.reminder.startTime = this.date + ' 19:00'
    this.reminder.endTime = this.date + ' 20:00'
  }

  build() {
    Column() {
      // 顶部导航栏
      Row() {
        Image($r('app.media.det_back'))
          .width(34)
          .height(55)
          .margin({ left: 85 ,top:242})
          .onClick(() => {
            router.back()
          })

        Text('设置提醒')
          .fontSize(84)
          .margin({ left: 343,top:242 })
      }
      .width('100%')
      .padding(16)
      .alignItems(VerticalAlign.Center)

      // 表单内容
      Column() {
        // 演出名称输入
        TextInput({ placeholder: '请输入要设置提醒的演出名称...' })
          .placeholderFont({size:40})
          .padding(43)
          .fontSize(48)
          .height(178)
          .width(972)
          .backgroundColor('#F5F5F5')
          .margin({ top: 16 })
          .onChange((value: string) => {
            this.reminder.title = value
          })

        // 开始时间
        Row() {
          Text('开始')
            .fontSize(40)
          TextInput({ text: this.reminder.startTime })
            .fontSize(40)
            .placeholderFont({size:40})
            .flexGrow(1)
            .margin({ left: 442 })
            .onChange((value: string) => {
              this.reminder.startTime = value
            })
        }
        .width('100%')
        .margin({ top: 71 })

        // 结束时间
        Row() {
          Text('结束')
            .fontSize(40)
          TextInput({ text: this.reminder.endTime })
            .fontSize(40)
            .placeholderFont({size:40})
            .flexGrow(1)
            .margin({ left: 442 })
            .onChange((value: string) => {
              this.reminder.endTime = value
            })
        }
        .width('100%')
        .margin({ top: 120 })

        // 提醒时间
        Row() {
          Text('提醒')
            .fontSize(40)
          Text(this.reminder.reminderTime)
            .fontSize(40)
            .margin({ left: 442 })
            .onClick(() => {
              // TODO: 显示提醒时间选择器
            })
          Image($r('app.media.det_rightarrow'))
            .margin({left:20})
            .width(20)
            .height(32)
        }
        .width('100%')
        .margin({ top: 120 })

        // 提醒方式
        Row() {
          Text('提醒方式')
            .fontSize(40)
        }
        .width('100%')
        .margin({ top: 120 })

        Row() {
          Column() {
            Image($r('app.media.re_ring'))
              .width(59)
              .height(73)
              .margin({top:56})
            Text('通知提醒')
              .fontSize(40)
              .margin({ top: 18 })
          }
          .height(225)
          .width(461)
          .backgroundColor(this.reminder.reminderType === ReminderType.NOTIFICATION ? '#E3F2FD' : '#F5F5F5')
          .borderRadius(40)
          .margin({ left: 0 })
          .onClick(() => {
            this.reminder.reminderType = ReminderType.NOTIFICATION
          })

          Column() {
            Image($r('app.media.re_alarm'))
              .width(59)
              .height(73)
              .margin({top:56})
            Text('闹钟提醒')
              .fontSize(40)
              .margin({ top: 18 })
          }
          .height(225)
          .width(461)
          .backgroundColor(this.reminder.reminderType === ReminderType.ALARM ? '#E3F2FD' : '#F5F5F5')
          .borderRadius(40)
          .margin({ left: 36 })
          .onClick(() => {
            this.reminder.reminderType = ReminderType.ALARM
          })
        }
        .margin({ top: 55 })

        // 备注
        Row() {
          Text('备注')
            .fontSize(40)
        }
        .width('100%')
        .margin({ top: 71 })

        // 备注输入框
        TextArea({ placeholder: '请输入备注...' })
          .height(178)
          .width(972)
          .borderRadius(50)
          .padding({left: 43,top:58})
          .placeholderFont({size:40})
          .backgroundColor('#F5F5F5')
          .margin({ top: 55 })
          .onChange((value: string) => {
            this.reminder.note = value
          })
      }
      .margin({ top: 73 })
      .backgroundColor(Color.White)
      .height(1653)
      .width(1160)
      .padding(94)

      // 保存按钮
      Button('保存')
        .fontSize(45)
        .borderRadius(56)
        .width('90%')
        .height(112)
        .margin({ top: 32 })
        .onClick(() => {
          // TODO: 保存提醒事项
          router.back()
        })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#e2e2e2')
  }
}
