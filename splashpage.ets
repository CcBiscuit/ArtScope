import router from '@ohos.router'
import hilog from '@ohos.hilog'
import { PAGES } from '../common/constants'

const TAG: string = '[SplashPage]'
const DOMAIN: number = 0x0000

@Entry
@Component
struct SplashPage {
  aboutToAppear() {
    hilog.info(DOMAIN, TAG, 'SplashPage aboutToAppear')
    // 3秒后跳转到登录页
    setTimeout(() => {
      hilog.info(DOMAIN, TAG, 'Navigating to loginpage')
      router.replaceUrl({
        url: PAGES.LOGIN
      }).then(() => {
        hilog.info(DOMAIN, TAG, 'Navigation successful')
      }).catch((err: Error) => {
        hilog.error(DOMAIN, TAG, 'Navigation failed: %{public}s', err.message)
      })
    }, 3000)
  }

  build() {
    Column() {
      Image($r('app.media.splashpage'))
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
    .expandSafeArea()
  }
} 