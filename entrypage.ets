import router from '@ohos.router'
import hilog from '@ohos.hilog'
import { PAGES, DEFAULT_TAB_ITEMS, LAYOUT } from '../common/constants'
import { TabBar } from '../components/TabBar'
import { MainPage } from '../pages/mainpage'
import { CalendarPage } from '../pages/calendarpage'
import { WalletPage } from '../pages/walletpage'
import { RecordPage } from '../pages/recordpage'
import { PersonalPage } from '../pages/personalpage'

const TAG: string = '[EntryPage]'
const DOMAIN: number = 0x0000

@Entry
@Component
struct EntryPage {
  @State currentIndex: number = 0

  @Builder
  TabContent() {
    Stack() {
      if (this.currentIndex === 0) {
        MainPage()
      } else if (this.currentIndex === 1) {
        CalendarPage()
      } else if (this.currentIndex === 2) {
        WalletPage()
      } else if (this.currentIndex === 3) {
        RecordPage()
      } else if (this.currentIndex === 4) {
        PersonalPage()
      }
    }
    .width('100%')
    .height('100%')
  }

  aboutToAppear() {
    // 不再需要跳转到主页，直接显示主页内容
    hilog.info(DOMAIN, TAG, 'EntryPage aboutToAppear')
  }

  onPageShow() {
    hilog.info(DOMAIN, TAG, 'EntryPage onPageShow')
  }

  build() {
    Stack({ alignContent: Alignment.Bottom }) {
      Column() {
        // 主要内容区域
        this.TabContent()
      }
      .width('100%')
      .height('100%')

      // Tab 栏
      TabBar({
        currentIndex: $currentIndex,
        tabItems: DEFAULT_TAB_ITEMS
      })
        .zIndex(10)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }
} 