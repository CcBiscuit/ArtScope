import router from '@ohos.router'
import hilog from '@ohos.hilog'
import { PAGES, DEFAULT_TAB_ITEMS, LAYOUT } from '../common/constants'
import { TabBar } from '../components/TabBar'
import { MainPage } from '../pages/mainpage'
import { CalendarPage } from '../pages/calendarpage'
import { WalletPage } from '../pages/walletpage'
import { RecordPage } from '../pages/recordpage'
import { PersonalPage } from '../pages/personalpage'
import { ReminderPage } from '../pages/reminderpage'
import { eventBus, EVENTS } from '../common/constants/EventBus'
import { showService } from '../common/constants/ShowService'
import { EntryDetailPage } from '../entrypage/EntryDetailPage'
import { EntryLikePage } from '../entrypage/EntryLikePage'
import { EntryDealPage } from '../entrypage/EntryDealPage'
import { ShowDetailPayload } from '../common/constants/ShowDetailTypes'

interface RecordItem {
  image: ResourceStr
  comment: string
  rating: number
  height: number
  date?: string
}

// 路由参数接口
interface RouterParams {
  showId?: string
}

const TAG: string = '[EntryPage]'
const DOMAIN: number = 0x0000

@Entry
@Component
struct EntryPage {
  @State currentIndex: number = 0
  @State recordData: RecordItem | undefined = undefined
  @State showReminder: boolean = false
  @State reminderDate: string = ''
  @State showDetailPage: boolean = false
  @State showLikePage: boolean = false
  @State showDealPage: boolean = false
  @State currentShowId: string = ''

  // Store a reference to the listener function
  private addReminderListener = (date: string) => {
    this.reminderDate = date;
    this.showReminder = true;
  };

  private showDetailListener = (payload: ShowDetailPayload) => {
    this.currentShowId = payload.showId;
    this.showDetailPage = true;
    hilog.info(DOMAIN, TAG, `Show detail requested for showId: ${this.currentShowId}`);
  };

  @Builder
  TabContent() {
    Stack() {
      if (this.showReminder) {
        // 显示提醒页面
        ReminderPage({
          date: this.reminderDate,
          onBack: () => {
            this.showReminder = false
          }
        })
      } else if (this.showDetailPage) {
        // 显示详情页面
        EntryDetailPage({
          showId: this.currentShowId,
          onBack: () => {
            this.showDetailPage = false
          }
        })
      } else if (this.showLikePage) {
        // 显示收藏页面
        EntryLikePage({
          onBack: () => {
            this.showLikePage = false
          },
          onShowDetail: (showId: string) => {
            this.currentShowId = showId
            this.showLikePage = false
            this.showDetailPage = true
          }
        })
      } else if (this.showDealPage) {
        // 显示订单页面
        EntryDealPage({
          onBack: () => {
            this.showDealPage = false
          }
        })
      } else {
        // 显示常规Tab页面
        if (this.currentIndex === 0) {
          MainPage()
        } else if (this.currentIndex === 1) {
          CalendarPage()
        } else if (this.currentIndex === 2) {
          WalletPage()
        } else if (this.currentIndex === 3) {
          RecordPage({
            onPublish: (data) => {
              this.recordData = {
                image: data.images[0],
                comment: data.comment,
                rating: data.rating,
                height: data.height,
                date: data.date
              }
              this.currentIndex = 4
            }
          })
        } else if (this.currentIndex === 4) {
          PersonalPage({
            newRecord: this.recordData,
            onPublish: () => {
              this.recordData = undefined
              this.currentIndex = 3
            },
            onNavigateToLike: () => {
              this.showLikePage = true
            },
            onNavigateToDeal: () => {
              this.showDealPage = true
            }
          })
        }
      }
    }
    .width('100%')
    .height('100%')
  }

  aboutToAppear() {
    hilog.info(DOMAIN, TAG, 'EntryPage aboutToAppear')
    // 监听添加提醒事件
    eventBus.onAddReminder(this.addReminderListener)
    
    // 监听显示详情事件
    eventBus.onShowDetail(this.showDetailListener)
    
    // 检查URL参数 (ArkTS不支持router.on和in操作符)
    const params = router.getParams() as RouterParams;
    if (params && params.showId !== undefined) {
      this.currentShowId = params.showId;
      this.showDetailPage = true;
      hilog.info(DOMAIN, TAG, `Detected showId from URL: ${this.currentShowId}`);
    }
  }

  aboutToDisappear() {
    // 移除事件监听
    eventBus.offAddReminder(this.addReminderListener)
    eventBus.offShowDetail(this.showDetailListener)
    hilog.info(DOMAIN, TAG, 'EntryPage aboutToDisappear, removed listeners');
  }

  onPageShow() {
    hilog.info(DOMAIN, TAG, 'EntryPage onPageShow')
    // 每次页面显示时检查URL参数，支持后续导航
    const params = router.getParams() as RouterParams;
    if (params && params.showId !== undefined) {
      this.currentShowId = params.showId;
      this.showDetailPage = true;
      hilog.info(DOMAIN, TAG, `Detected showId on page show: ${this.currentShowId}`);
    }
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // 主要内容区域
        this.TabContent()
      }
      .width('100%')
      .height('100%')

      if (!this.showReminder && !this.showDetailPage && !this.showLikePage && !this.showDealPage) {
        // 只在特定页面显示 Tab 栏
        TabBar({
          currentIndex: $currentIndex,
          tabItems: DEFAULT_TAB_ITEMS
        })
          .zIndex(10)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
} 