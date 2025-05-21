import router from '@ohos.router'
import hilog from '@ohos.hilog'

const TAG: string = '[SignupPage]'
const DOMAIN: number = 0x0000

@Entry
@Component
struct SignupPage {
  @State account: string = ''
  @State password: string = ''
  @State verifyCode: string = ''
  @State inputCode: string = ''
  @State showError: boolean = false
  
  generateVerifyCode(): string {
    return Math.floor(Math.random() * 9000 + 1000).toString()
  }

  aboutToAppear() {
    hilog.info(DOMAIN, TAG, 'SignupPage aboutToAppear')
    this.verifyCode = this.generateVerifyCode()
  }

  aboutToDisappear() {
    hilog.info(DOMAIN, TAG, 'SignupPage aboutToDisappear')
  }

  onPageShow() {
    hilog.info(DOMAIN, TAG, 'SignupPage onPageShow')
  }

  onPageHide() {
    hilog.info(DOMAIN, TAG, 'SignupPage onPageHide')
  }

  onBackPress() {
    hilog.info(DOMAIN, TAG, 'SignupPage onBackPress')
    router.back()
    return true
  }

  build() {
    Stack() {
      Image($r('app.media.login_back'))
        .height('100%')
        .width('100%')
      Text()
        .zIndex(5)
        .height(1500)
        .width('100%')
        .margin({ top: 1200 })
        .backgroundColor('#ffffff')
        .opacity(0.25)

      Column() {
        TextInput({ placeholder: '手机号' })
          .fontSize(35)
          .type(InputType.Normal)
          .padding({ left: 50 })
          .placeholderFont({ size: 35 })
          .placeholderColor('#ff323131')
          .backgroundColor(Color.White)
          .borderRadius(20)
          .height(125)
          .width(888)
          .onChange((value: string) => {
            this.account = value
          })

        TextInput({ placeholder: '密码' })
          .fontSize(35)
          .type(InputType.Password)
          .padding({ left: 50 })
          .placeholderFont({ size: 35 })
          .placeholderColor('#ff323131')
          .backgroundColor(Color.White)
          .borderRadius(20)
          .height(125)
          .width(888)
          .margin({ top: 30 })
          .onChange((value: string) => {
            this.password = value
          })

        Row() {
          TextInput({ placeholder: '验证码' })
            .fontSize(35)
            .type(InputType.Number)
            .padding({ left: 50 })
            .placeholderFont({ size: 35 })
            .placeholderColor('#ff323131')
            .backgroundColor(Color.White)
            .borderRadius(20)
            .height(125)
            .width(600)
            .onChange((value: string) => {
              this.inputCode = value
              this.showError = false
            })

          Text(this.verifyCode)
            .fontSize(40)
            .fontColor('#333333')
            .backgroundColor('#f5f5f5')
            .padding(20)
            .borderRadius(10)
            .margin({ left: 20 })
            .onClick(() => {
              this.verifyCode = this.generateVerifyCode()
            })
        }
        .margin({ top: 30 })
        .width(888)

        if (this.showError) {
          Text('验证码错误，请重新输入')
            .fontSize(30)
            .fontColor(Color.Red)
            .margin({ top: 10 })
        }

        Button('注册')
          .fontSize(50)
          .height(132)
          .width(761)
          .backgroundColor('#000000')
          .borderRadius(65)
          .margin({ top: 50 })
          .onClick(() => {
            if (this.inputCode === this.verifyCode) {
              // 注册成功，跳转到登录页
              router.replaceUrl({
                url: 'pages/loginpage'
              }).then(() => {
                hilog.info(DOMAIN, TAG, 'Navigation successful')
              }).catch((err: Error) => {
                hilog.error(DOMAIN, TAG, 'Navigation failed: %{public}s', err.message)
              })
            } else {
              this.showError = true
              this.verifyCode = this.generateVerifyCode()
            }
          })
      }
      .zIndex(8)
      .margin({ top: 120 })
    }
    .backgroundColor('#000000')
    .height('100%')
    .width('100%')
  }
}
