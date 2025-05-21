// 日历相关常量和接口定义

// 提醒事项接口
export interface ReminderItem {
  title: string
  startTime: string
  endTime: string
  reminderTime: string
  reminderType: ReminderType
  note?: string
}

// 提醒类型枚举
export enum ReminderType {
  NOTIFICATION = 'notification',
  ALARM = 'alarm'
}

// 日历日期接口
export interface CalendarDay {
  date: number
  isCurrentMonth: boolean
  isToday: boolean
  isHoliday: boolean
  hasReminder: boolean
}

// 节假日日期映射接口
export interface HolidayPeriod {
  start: string
  end: string
  name: string
}

// 节假日数据类型
@Observed
class HolidayData {
  newYear: string = '元旦'
  springFestival: string = '春节'
  qingming: string = '清明节'
  laborDay: string = '劳动节'
  dragonBoat: string = '端午节'
  midAutumn: string = '中秋节'
  nationalDay: string = '国庆节'
}

// 2024年节假日安排
export const HOLIDAY_PERIODS: HolidayPeriod[] = [
  { start: '01-01', end: '01-03', name: '元旦' },
  { start: '02-10', end: '02-17', name: '春节' },
  { start: '04-04', end: '04-06', name: '清明节' },
  { start: '05-01', end: '05-05', name: '劳动节' },
  { start: '06-10', end: '06-12', name: '端午节' },
  { start: '09-15', end: '09-17', name: '中秋节' },
  { start: '10-01', end: '10-07', name: '国庆节' }
]

// 获取日期对应的节日名称
export function getHolidayName(dateStr: string): string {
  const dateParts = dateStr.split('-').map(Number)
  const month = dateParts[0]
  const day = dateParts[1]
  
  for (const period of HOLIDAY_PERIODS) {
    const startParts = period.start.split('-').map(Number)
    const endParts = period.end.split('-').map(Number)
    const startMonth = startParts[0]
    const startDay = startParts[1]
    const endMonth = endParts[0]
    const endDay = endParts[1]
    
    // 如果日期在节假日区间内
    if (month === startMonth && month === endMonth) {
      // 同一个月内
      if (day >= startDay && day <= endDay) {
        return period.name
      }
    } else if (month === startMonth) {
      // 开始月份
      if (day >= startDay) {
        return period.name
      }
    } else if (month === endMonth) {
      // 结束月份
      if (day <= endDay) {
        return period.name
      }
    } else if (month > startMonth && month < endMonth) {
      // 中间月份
      return period.name
    }
  }
  
  return ''
}

// 获取日期字符串
export function getHolidayDate(holidayName: string): string {
  switch (holidayName) {
    case '元旦':
      return '01-01'
    case '春节':
      return '01-21'
    case '清明节':
      return '04-05'
    case '劳动节':
      return '05-01'
    case '端午节':
      return '05-05'
    case '中秋节':
      return '09-29'
    case '国庆节':
      return '10-01'
    default:
      return ''
  }
}

// 中国节假日数据
export const CHINESE_HOLIDAYS = new HolidayData()

// 每周的标题
export const WEEK_DAYS: string[] = ['日', '一', '二', '三', '四', '五', '六'] 