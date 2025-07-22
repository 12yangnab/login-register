// import { router } from '@kit.ArkUI'
import router from '@ohos.router'
import prompt from '@ohos.promptAction'

@Extend(TextInput)
function InputStyle1( ) {
  .width('100%')
  .height(45)
  .backgroundColor('#F1F3F5')
  .fontSize(20)
  .placeholderColor('#99192431')
  .margin({top:12})
  .padding({left:0})
}
@Extend(Line) function LineStyle1( ) {
  .width('100%')
  .height(0.8)
  .backgroundColor(Color.Grey)
}



@Entry
@Component
struct LoginPage {
  @Builder imgButton( src:Resource) {
    Button({type:ButtonType.Circle,stateEffect:true}) {
      Image(src)
      .width(48)
      .height(48)
      .backgroundColor('#F1F3F5')}
  }
  @State account:string = ''
  @State password:string = ''
  @State paccount:string = (router.getParams() as Record<string,string>)['account']
  @State ppassword:string = (router.getParams() as Record<string,string>)['password']
  private timeOutId=-1
  @State isShowProgress:boolean = false

  aboutToDisappear(): void {
    clearTimeout(this.timeOutId)
    this.timeOutId=-1
  }

  Login(): void{
    if (this.account == '' || this.password == '') {
      prompt.showToast({
        message:'账号或密码不能为空!!!'
      })
    }
    else {
      // console.log('账号为'+this.account+'\t\t\t密码为'+this.password)

      if ((this.account!=this.paccount)||(this.password!=this.ppassword)) {
        prompt.showToast({
          message:'账号或密码错误,请重新输入!!!'
        })
      }else {
        this.isShowProgress=true
        if(this.timeOutId==-1){
          this.timeOutId=setTimeout(()=>{
            prompt.showToast({
              message:'登录成功!!!'
            })
            this.isShowProgress=false
            this.timeOutId=-1
            router.pushUrl({url:'pages/MainPage'});
          },1000)

        }
      }
    }
  }

  build() {
    //根组件
    Column({space:17}){

      //logo载体
      Column(){
        Row(){
          Image($r('app.media.logo'))
            .width(60).height(60)
            .margin({top:20})
        }
        Row(){
          Text('登录界面')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .margin({top:16})
        }
        Row(){
          Text('登录获取更多内容')
            .fontSize(12)
            .fontWeight(400)
            .margin({top:12})
        }.justifyContent(FlexAlign.Center)
      }.width('100%')
      .height('30%')
      .margin({top:30})

      //输入框架
      Column(){
        Column({space:14}){
          TextInput({placeholder:'账号:'})
            .InputStyle1()
            .onChange((value:string)=>{
              this.account = value
            })
            .maxLength(10)
            .type(InputType.Number)
          Line()
            .LineStyle1()
          TextInput({placeholder:'密码:'})
            .InputStyle1()
            .maxLength(8)
            .type(InputType.Password)
            .onChange((value:string)=>{
              this.password = value
            })
          Line()
            .LineStyle1()
        }
        Row(){
          Row(){
            Text('发送短信验证码')
              .fontSize(12)
              .fontColor('#007dff')
          }.width('50%')
          .justifyContent(FlexAlign.Start)
          Row(){
            Text('重置')
              .fontSize(12)
              .fontColor('#007dff')
          }.width('50%')
          .justifyContent(FlexAlign.End)
        }
        .width('100%')
        .margin({top:10})
      }.width('100%')
      .height('40%')
      .margin({top:-60})

      Column() {
        if (this.isShowProgress) {
          LoadingProgress()
            .margin({ top: 12 })
            .backgroundColor('#182431')
            .width(30)
            .height(30)
        }
      }

      //登录方式载体
      Column() {
        //登录按钮
        Button('登录')
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.White)
          .width('40%')
          .onClick(()=>{
            //router.push({ url:'pages/MainPage' })
            this.Login()
          })
        Text('注册账号')
          .fontSize(20)
          .fontWeight(400)
          .fontColor('#007dff')
          .onClick(()=>{
            router.pushUrl({url:'pages/RegisterPage'})
          })
      }
      Column(){
        //q其他
          Text('其他登录方式')
            .fontSize(15)
            .fontColor('#99182431')
            .fontWeight(400)

        //最后一行
        Row(){
          this.imgButton($r('app.media.login_method1'))
          this.imgButton($r('app.media.login_method2'))
          this.imgButton($r('app.media.login_method3'))
        }.margin({top:7})
        .justifyContent(FlexAlign.SpaceAround)
        .width('100%')
      }.width('100%')
      .height('30%')

    }.width('100%')
    .height('100%')
    .backgroundColor('#F1F3F5')
  }
}