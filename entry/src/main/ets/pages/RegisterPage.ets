// import { router } from '@kit.ArkUI'
import router from '@ohos.router'
import promptAction from '@ohos.promptAction'
import { prompt } from '@kit.ArkUI'

@Extend(TextInput)
function InputStyle( ) {
  .width('100%')
  .height(45)
  .backgroundColor('#F1F3F5')
  .fontSize(20)
  .placeholderColor('#99192431')
  .margin({top:12})
  .padding({left:0})
}
@Extend(Line) function LineStyle( ) {
  .width('100%')
  .height(0.8)
  .backgroundColor(Color.Grey)
}

@Entry
@Component
export default struct RegisterPage {
  @State account:string = ''
  @State password:string = ''
  @State rpassword:string = ''
  @State isCatch:boolean = false
  @State isShowProgress:boolean = false
  private timeOutId =-1

  @Builder imgButton( src:Resource) {
    Button({type:ButtonType.Circle,stateEffect:true}) {
      Image(src)
        .width(48)
        .height(48)
        .backgroundColor('#F1F3F5')}
  }

  Register():void{
    if(this.account==''||this.password==''||this.rpassword==''){
      prompt.showToast({
        message:'账号或密码不能为空,请重新输入!'
      })
    }else {
      if (this.password!=this.rpassword) {
        prompt.showToast({
          message:'注册信息不一致，请核对后重新输入'
        })
      }else {
        this.isShowProgress = true
        if (this.timeOutId==-1){
          this.timeOutId =setTimeout(()=>{
            prompt.showToast({
              message:'注册成功！！！'
            })
            this.isShowProgress = false
            this.timeOutId = -1
            router.pushUrl({
              url:'pages/LoginPage',
              params:{
                account:this.account,
                password:this.password
              }
            })
          },2000)
        }
      }
    }
  }
aboutToDisappear(){
    clearTimeout(this.timeOutId)
  this.timeOutId = -1
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
          Text('注册界面')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .margin({top:16})
        }
        Row(){
          Text('注册以登录')
            .fontSize(12)
            .fontWeight(400)
            .margin({top:12})
        }
      }.width('100%')
      .height('30%')
      .margin({top:30})

      //输入框架
      Column(){
        Column({space:14}){
          TextInput({placeholder:'账号:'})
            .InputStyle()
            .maxLength(10)
            .type(InputType.Number)
            .onChange((value:string)=>{
              this.account = value
            })
          Line()
            .LineStyle()
          TextInput({placeholder:'密码:'})
            .InputStyle()
            .maxLength(8)
            .type(InputType.Password)
            .onChange((value:string)=>{
              this.password = value
            })
          Line()
            .LineStyle()
          TextInput({placeholder:'确认密码:'})
            .InputStyle()
            .padding({left:0})
            .maxLength(8)
            .type(InputType.Password)
            .onChange((value:string)=>{
              this.rpassword = value
            })
          Line()
            .LineStyle()
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

      if (this.isShowProgress){
        LoadingProgress()
          .margin({top:12})
          .backgroundColor('#182431')
          .width(30)
          .height(30)
      }

      //登录方式载体
      Column(){
        Row(){
          Button('注册')
            .fontSize(20)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
            .width('40%')
            .onClick(()=>{
              this.Register()
            })
        }.margin({bottom:10})
        Row(){
          Text('登录')
            .fontSize(20)
            .fontWeight(400)
            .fontColor('#007dff')
            .onClick(()=>{
              router.push({
                url:'pages/LoginPage',
                params:{
                  account:this.account,
                  password:this.password
                }
              })

            })
        }.width('30%')
        .justifyContent(FlexAlign.Center)
        //q其他
        Row(){
          Text('其他登录方式')
            .fontSize(15)
            .fontColor('#99182431')
            .fontWeight(400)
        }.margin({top:20})

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