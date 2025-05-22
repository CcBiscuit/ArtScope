import { CalendarDay, WEEK_DAYS, getHolidayName, ReminderItem } from '../common/constants/CalendarConstants'
import { eventBus, EVENTS } from '../common/constants/EventBus'
import router from '@ohos.router'
import tab from 'ets/components/tab'
import hilog from '@ohos.hilog'

interface CalendarPageProps {
  currentDate?: Date;
  calendarDays?: CalendarDay[];
  reminders?: Map<string, boolean>;
}

const TAG: string = '[CalendarPage]'
const DOMAIN: number = 0x0000

@Component
export struct CalendarPage {
  @State currentDate: Date = new Date()
  @State calendarDays: CalendarDay[] = []
  @State dateHasReminderMap: Map<string, boolean> = new Map()
  @State activeReminders: ReminderItem[] = []

  private reminderSavedListener = (reminder: ReminderItem) => {
    this.handleReminderSaved(reminder);
  };

  aboutToAppear() {
    this.generateCalendarDays()
    eventBus.onReminderSaved(this.reminderSavedListener);
    hilog.info(DOMAIN, TAG, 'CalendarPage aboutToAppear, subscribed to REMINDER_SAVED');
  }

  aboutToDisappear() {
    eventBus.offReminderSaved(this.reminderSavedListener);
    hilog.info(DOMAIN, TAG, 'CalendarPage aboutToDisappear, unsubscribed from REMINDER_SAVED');
  }

  handleReminderSaved(reminder: ReminderItem) {
    hilog.info(DOMAIN, TAG, `Received new reminder: ${JSON.stringify(reminder)}`);
    const existingReminderIndex = this.activeReminders.findIndex(
      item => item.title === reminder.title && item.startTime === reminder.startTime
    );
    if (existingReminderIndex === -1) {
      this.activeReminders.push(reminder);
      this.activeReminders.sort((a, b) => new Date(a.startTime).getTime() - new Date(b.startTime).getTime());
    } else {
      this.activeReminders[existingReminderIndex] = reminder;
    }

    const reminderDateStr = reminder.startTime.split(' ')[0];
    if (reminderDateStr) {
      this.dateHasReminderMap.set(reminderDateStr, true);
      this.generateCalendarDays(); 
    }
    hilog.info(DOMAIN, TAG, `Active reminders: ${this.activeReminders.length}`);
  }

  generateCalendarDays() {
    const year = this.currentDate.getFullYear()
    const month = this.currentDate.getMonth()
    const today = new Date()
    
    const firstDay = new Date(year, month, 1).getDay()
    const daysInMonth = new Date(year, month + 1, 0).getDate()
    const daysInLastMonth = new Date(year, month, 0).getDate()
    
    let days: CalendarDay[] = []
    
    for (let i = firstDay - 1; i >= 0; i--) {
      days.push({
        date: daysInLastMonth - i,
        isCurrentMonth: false,
        isToday: false,
        isHoliday: false,
        hasReminder: false
      })
    }
    
    for (let i = 1; i <= daysInMonth; i++) {
      const currentFullDate = `${year}-${String(month + 1).padStart(2, '0')}-${String(i).padStart(2, '0')}`;
      const holidayName = getHolidayName(`${String(month + 1).padStart(2, '0')}-${String(i).padStart(2, '0')}`)
      days.push({
        date: i,
        isCurrentMonth: true,
        isToday: today.getDate() === i && 
                 today.getMonth() === month && 
                 today.getFullYear() === year,
        isHoliday: holidayName !== '',
        hasReminder: this.dateHasReminderMap.get(currentFullDate) || false
      })
    }
    
    const remainingDays = 42 - days.length
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

  private handleAddReminder(date: string) {
    eventBus.emitAddReminder(date)
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
                const dayStr = String(day.date).padStart(2, '0');
                const monthStr = String(this.currentDate.getMonth() + 1).padStart(2, '0');
                const yearStr = this.currentDate.getFullYear();
                const dateStr = `${yearStr}-${monthStr}-${dayStr}`;
                if (day.isCurrentMonth) {
                  this.handleAddReminder(dateStr)
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

        // 新增：显示活动提醒列表
        if (this.activeReminders.length > 0) {
          List({ space: 10 }) {
            ForEach(this.activeReminders, (reminder: ReminderItem) => {
              ListItem() {
                Row() {
                  Text(`${reminder.startTime.split(' ')[1]} - ${reminder.endTime.split(' ')[1]}`)
                    .fontSize(40)
                    .fontColor('#ff454444')
                  Text(reminder.title)
                    .fontSize(40)
                    .fontColor('#ff454444')
                    .margin({ left: 30 })
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .maxLines(1)
                }
                .height(100)
                .backgroundColor(Color.White)
                .borderRadius(20)
                .padding({ left: 30, right: 30 })
                .width('100%')
                .onClick(() => {
                  hilog.info(DOMAIN, TAG, `Reminder item clicked: ${JSON.stringify(reminder)}`);
                  eventBus.emitAddReminder(reminder.startTime.split(' ')[0]);
                })
              }
            }, (reminder: ReminderItem) => reminder.title + reminder.startTime)
          }
          .width('100%')
          .margin({ top: 30 })
          .padding({left:10, right:10})
          .backgroundColor('#f0f0f0')
          .borderRadius(20)
          .clip(true)
          .height(this.activeReminders.length > 3 ? 350 : this.activeReminders.length * 110)
        } else {
           Text('今日暂无提醒')
             .fontSize(40)
             .fontColor(Color.Gray)
             .margin({ top: 30 })
             .width('100%')
             .textAlign(TextAlign.Center)
        }

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
            .width(60)
            .height(60)
        }
        .width(147)
        .height(147)
        .position({ x: '80%', y: '80%' })
        .backgroundColor('#000000')
        .onClick(() => {
          const today = new Date()
          const dateStr = `${today.getFullYear()}-${String(today.getMonth() + 1).padStart(2, '0')}-${String(today.getDate()).padStart(2, '0')}`
          this.handleAddReminder(dateStr)
        })
      }
      .width('100%')
      .layoutWeight(1)
      .backgroundColor('#e2e2e2')
      .padding({ left: 75, right: 75, bottom: 75 })
    }
    .width('100%')
    .height('100%')
  }
} 