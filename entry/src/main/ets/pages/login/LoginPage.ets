import router from '@ohos.router'
import TitleBar from '../../widget/TitleBar'

import { primary } from '../../style/AppColor'
import showToast from '../../utils/ToastUtil'
import LoginViewModel from './LoginViewModel'
import { delay } from '../../utils/PromiseUtil'

/**
 * 登录页面
 */
@Entry
@Component
struct LoginPage {
  private account: string = ""
  private password: string = ""
  @State
  private loading: boolean = false
  private viewModel = new LoginViewModel()

  build() {
    Column() {
      TitleBar({ title: "登录" })
      this.content()
    }
    .width('100%')
    .height('100%')
  }

  @Builder
  content() {
    Column({ space: 20 }) {
      TextInput({ placeholder: '请输入账号', text: 'shop' })
        .width("100%")
        .height(45)
        .fontSize(14)
        .maxLength(20)
        .onChange((value: string) => {
          this.account = value
        })
      TextInput({ placeholder: '请输入密码', text: '123456' })
        .width("100%")
        .height(45)
        .fontSize(14)
        .maxLength(20)
        .type(InputType.Password)
        .showPasswordIcon(true)
        .onChange((value: string) => {
          this.password = value
        })
      if (this.loading) {
        this.loadingPage()
      } else {
        Button("登录")
          .width(150)
            // .margin({ top: 30 })
          .backgroundColor(primary)
          .onClick(() => this.login())
      }
    }
    .padding({ left: 20, right: 20 })
    .margin({ top: 40 })
  }

  @Builder
  loadingPage() {
    Column() {
      Row() {
        LoadingProgress()
          .width(50)
          .height(50)
        Text("登录中")
      }
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
  }

  login() {
    if (!this.account) {
      showToast("请输入账号")
      return
    }
    if (this.account.length < 4) {
      showToast("账号过短,不能小于4位")
      return
    }
    if (!this.password) {
      showToast("请输入密码")
      return
    }
    if (this.password.length < 6) {
      showToast("密码过短，不能小于6位")
      return
    }
    this.performLogin()
  }

  async performLogin() {
    this.loading = true
    const result = await this.viewModel.login(this.account, this.password)
    if (result == true) {
      showToast("登录成功")
      router.replaceUrl({ url: 'pages/home/HomePage' })
    } else {
      showToast(result)
    }
    this.loading = false
  }
}

