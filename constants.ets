// 页面路由接口定义
export interface PageRoute {
  SPLASH: string
  LOGIN: string
  SIGNUP: string
  ENTRY: string
  MAIN: string
  SEARCH: string
  DETAIL: string
  CALENDAR: string
  REMINDER: string
  WALLET: string
  RECORD: string
  PERSONAL: string
  DEAL: string
  LIKE: string
  COMMENTS: string
}

// Tab项接口定义
export interface TabItem {
  normalIcon: Resource
  activeIcon: Resource
  url: string
}

// 布局相关接口定义
export interface Layout {
  TAB_BAR_HEIGHT: number
  TAB_ITEM_WIDTH: number
  TAB_ICON_SIZE: number
}

// 页面路由常量
export const PAGES: PageRoute = {
  SPLASH: 'pages/splashpage',
  LOGIN: 'pages/loginpage',
  SIGNUP: 'pages/signuppage',
  ENTRY: 'pages/entrypage',
  MAIN: 'pages/mainpage',
  SEARCH: 'pages/searchpage',
  DETAIL: 'pages/detailpage',
  CALENDAR: 'pages/calendarpage',
  REMINDER: 'pages/reminderpage',
  WALLET: 'pages/walletpage',
  RECORD: 'pages/recordpage',
  PERSONAL: 'pages/personalpage',
  DEAL: 'pages/dealpage',
  LIKE: 'pages/likepage',
  COMMENTS: 'pages/commentspage'
}

// 默认Tab项配置
export const DEFAULT_TAB_ITEMS: TabItem[] = [
  { normalIcon: $r('app.media.tab_home'), activeIcon: $r('app.media.tab_home_active'), url: PAGES.MAIN },
  { normalIcon: $r('app.media.tab_calender'), activeIcon: $r('app.media.tab_calender_active'), url: PAGES.CALENDAR },
  { normalIcon: $r('app.media.tab_card'), activeIcon: $r('app.media.tab_card_active'), url: PAGES.WALLET },
  { normalIcon: $r('app.media.tab_comment'), activeIcon: $r('app.media.tab_comment_active'), url: PAGES.RECORD },
  { normalIcon: $r('app.media.tab_personal'), activeIcon: $r('app.media.tab_personal_active'), url: PAGES.PERSONAL }
]

// 布局相关常量
export const LAYOUT: Layout = {
  TAB_BAR_HEIGHT: 147,
  TAB_ITEM_WIDTH: 120,
  TAB_ICON_SIZE: 54
} 