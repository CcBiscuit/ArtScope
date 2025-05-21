import { CalendarDay, WEEK_DAYS, getHolidayName } from '../common/constants/CalendarConstants'
import router from '@ohos.router'
import tab from 'ets/components/tab';

@Component
export struct CalendarPage {
  @State currentDate: Date = new Date()
  @State calendarDays: CalendarDay[] = []
  @State reminders: Map<string, boolean> = new Map()

  aboutToAppear() {
    this.generateCalendarDays()
  }

  generateCalendarDays() {
    const year = this.currentDate.getFullYear()
    const month = this.currentDate.getMonth()
    const today = new Date()
    
    // 获取当月第一天是星期几
    const firstDay = new Date(year, month, 1).getDay()
    // 获取当月天数
    const daysInMonth = new Date(year, month + 1, 0).getDate()
    // 获取上月天数
    const daysInLastMonth = new Date(year, month, 0).getDate()
    
    let days: CalendarDay[] = []
    
    // 添加上月的日期
    for (let i = firstDay - 1; i >= 0; i--) {
      days.push({
        date: daysInLastMonth - i,
        isCurrentMonth: false,
        isToday: false,
        isHoliday: false,
        hasReminder: false
      })
    }
    
    // 添加当月的日期
    for (let i = 1; i <= daysInMonth; i++) {
      const dateStr = `${String(month + 1).padStart(2, '0')}-${String(i).padStart(2, '0')}`
      const holidayName = getHolidayName(dateStr)
      days.push({
        date: i,
        isCurrentMonth: true,
        isToday: today.getDate() === i && 
                 today.getMonth() === month && 
                 today.getFullYear() === year,
        isHoliday: holidayName !== '',
        hasReminder: this.reminders.get(`${year}-${dateStr}`) || false
      })
    }
    
    // 添加下月的日期
    const remainingDays = 42 - days.length // 保持6行
    for (let i = 1; i <= remainingDays; i++) {
      days.push({
        date: i,
        isCurrentMonth: false,
        isToday: false,
        isHoliday: false,
        hasReminder: false
      })
    }
    
    this.calendarDays = days
  }

  build() {
    Column() {
      Column() {
        // 标题栏
        Row() {
          Text('日程')
            .fontSize(84)
            .fontWeight(FontWeight.Medium)
        }
        .width('100%')
        .justifyContent(FlexAlign.Center)
        .padding({ top: 229, bottom: 65 })

        // 日历卡片
        Column() {
          // 年月和切换按钮
          Row() {
            Image($r('app.media.det_back'))
              .width(48)
              .height(48)
              .onClick(() => {
                this.currentDate = new Date(this.currentDate.getFullYear(), this.currentDate.getMonth() - 1)
                this.generateCalendarDays()
              })

            Text(`${this.currentDate.getFullYear()} / ${String(this.currentDate.getMonth() + 1).padStart(2, '0')}`)
              .fontSize(96)
              .fontWeight(FontWeight.Bold)

            Image($r('app.media.det_rightarrow'))
              .width(48)
              .height(48)
              .onClick(() => {
                this.currentDate = new Date(this.currentDate.getFullYear(), this.currentDate.getMonth() + 1)
                this.generateCalendarDays()
              })
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({ left: 92, right: 92, top: 56, bottom: 48 })

          // 星期标题
          Grid() {
            ForEach(WEEK_DAYS, (day: string) => {
              GridItem() {
                Text(day)
                  .fontSize(46)
                  .fontWeight(FontWeight.Medium)
                  .textAlign(TextAlign.Center)
                  .width('100%')
              }
            })
          }
          .margin({top:90})
          .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
          .height(80)
          .width('100%')
          .padding({ left: 32, right: 32 })

          // 日历网格
          Grid() {
            ForEach(this.calendarDays, (day: CalendarDay) => {
              GridItem() {
                Column() {
                  Text(day.date.toString())
                    .fontSize(48)
                    .fontColor(day.isCurrentMonth ? 
                      (day.isHoliday ? Color.Red : Color.Black) : 
                      '#ff6e6b6b')
                    .fontWeight(day.isToday ? FontWeight.Bold : FontWeight.Normal)
                  
                  if (day.hasReminder) {
                    Divider()
                      .width(40)
                      .margin({ top: 4 })
                      .color(Color.Black)
                  }
                }
                .justifyContent(FlexAlign.Center)
                .alignItems(HorizontalAlign.Center)
                .width('100%')
                .height('100%')
              }
              .onClick(() => {
                const dateStr = `${this.currentDate.getFullYear()}-${String(this.currentDate.getMonth() + 1).padStart(2, '0')}-${String(day.date).padStart(2, '0')}`
                if (day.isCurrentMonth) {
                  router.pushUrl({
                    url: 'pages/ReminderPage',
                    params: {
                      date: dateStr
                    }
                  })
                }
              })
            })
          }
          .height(800)
          .columnsTemplate('1fr 1fr 1fr 1fr 1fr 1fr 1fr')
          .rowsTemplate('120px 120px 120px 120px 120px 120px')
          .width('100%')
          .padding({ left: 32, right: 32, bottom: 32 })
        }
        .width(1155)
        .backgroundColor(Color.White)
        .borderRadius(32)

        // 演出信息卡片
        Row() {
          Row() {
            Text('19:00-21:30')
              .fontSize(48)
              .fontColor('#ff454444')
            
            Text('演出名称')
              .fontSize(48)
              .fontColor('#ff454444')
              .margin({ left: 48 })
          }
          .height(150)
          .backgroundColor(Color.White)
          .borderRadius(32)
          .padding({ left: 48, right: 48 })
          .width('100%')
        }
        .margin({ top: 48 })
        .width('100%')

        // 添加按钮
        Button({ type: ButtonType.Circle }) {
          Image($r('app.media.cal_add'))
            .width(96)
            .height(96)
        }
        .width(192)
        .height(192)
        .backgroundColor('#000000')
        .position({ x: '90%', y: '85%' })
        .translate({ x: '-50%', y: 0 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/reminderPage'
          })
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#e2e2e2')
      .padding({ left: 75, right: 75 })

      tab()
        .width('100%')
    }
    .width('100%')
    .height('100%')
  }
} 