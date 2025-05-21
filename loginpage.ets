import router from '@ohos.router'
import hilog from '@ohos.hilog'
import { PAGES } from '../common/constants'

const TAG: string = '[LoginPage]'
const DOMAIN: number = 0x0000

@Entry
@Component
struct LoginPage {
  @State account: string = ''
  @State password: string = ''

  build() {
    Stack() {
      Image($r('app.media.login_back'))
        .height('100%')
        .width('100%')

      Image($r('app.media.appicon'))
        .zIndex(10)
        .height(255)
        .width(255)
        .margin({ top: -350 })

      Text()
        .zIndex(5)
        .height(1500)
        .width('100%')
        .margin({ top: 1200 })
        .backgroundColor('#ffffff')
        .opacity(0.25)

      TextInput({ placeholder: '账号' })
        .fontSize(35)
        .type(InputType.Normal)
        .padding({ left: 50 })
        .placeholderFont({ size: 35 })
        .placeholderColor('#ff323131')
        .zIndex(8)
        .height(125)
        .width(888)
        .margin({ top: 120 })
        .backgroundColor('#ffffff')
        .borderRadius(20)
        .onChange((value: string) => {
          this.account = value
        })

      TextInput({ placeholder: '密码' })
        .fontSize(35)
        .type(InputType.Password)
        .padding({ left: 50 })
        .placeholderFont({ size: 35 })
        .placeholderColor('#ff323131')
        .zIndex(8)
        .height(125)
        .width(888)
        .margin({ top: 450 })
        .backgroundColor('#ffffff')
        .borderRadius(20)
        .onChange((value: string) => {
          this.password = value
        })

      Column() {
        Button('登录')
          .fontSize(50)
          .height(132)
          .width(761)
          .backgroundColor('#000000')
          .borderRadius(65)
          .onClick(() => {
            // 这里应该添加登录验证逻辑
            router.replaceUrl({
              url: PAGES.ENTRY
            }).then(() => {
              hilog.info(DOMAIN, TAG, 'Navigation to entry page successful')
            }).catch((err: Error) => {
              hilog.error(DOMAIN, TAG, 'Navigation failed: %{public}s', err.message)
            })
          })

        Button('注册')
          .fontSize(50)
          .height(132)
          .width(761)
          .backgroundColor('#000000')
          .borderRadius(65)
          .margin({ top: 30 })
          .onClick(() => {
            router.pushUrl({
              url: PAGES.SIGNUP
            }).then(() => {
              hilog.info(DOMAIN, TAG, 'Navigation to signup page successful')
            }).catch((err: Error) => {
              hilog.error(DOMAIN, TAG, 'Navigation failed: %{public}s', err.message)
            })
          })
      }
      .zIndex(8)
      .margin({ top: 1000 })
    }
    .backgroundColor('#000000')
    .height('100%')
    .width('100%')
  }
}