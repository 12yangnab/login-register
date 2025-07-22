import router from '@ohos.router'
import { JSON } from '@kit.ArkTS';


interface ImageItem {
  img: ResourceStr; // ResourceStr是鸿蒙系统中资源引用的类型
}
interface OtherItemType {
  title: string;      // 标题字段，类型为字符串
  img: ResourceStr;   // 图片资源，使用鸿蒙的ResourceStr类型
}
interface ListItemType {
  title: string;    // 标题字段，类型为字符串
  img: ResourceStr; // 图片资源，使用鸿蒙的ResourceStr类型
  text: string;     // 文本字段，类型为字符串
}
interface SetItemType {
  title: string;      // 修正拼写：tile → title（标题字段）
  img: ResourceStr;   // 图片资源（鸿蒙资源类型）
  texF: string;       // 文本字段（根据命名推测可能是text相关）
}
interface GeneratedTypeLiteralInterface_1 {
  img: ResourceStr;
}

@Entry
@Component
export default struct MainPage {
  @State currentIndex: number = 0// 当前索引，用于切换标签页
  private tabsController: TabsController = new TabsController()// 创建TabsController实例，用于控制标签页的切换
  private swiperController: SwiperController = new SwiperController()// 创建SwiperController实例，用于控制轮播图的切换
@State picture:ImageItem[]=[// 图片数组，用于轮播图展示
  {img:$r('app.media.fig1')}
  ,{img:$r('app.media.fig2')}
  ,{img:$r('app.media.fig3')}
  ,{img:$r('app.media.fig4')}
]
  @State otherItem :OtherItemType[]=[// 其他项数组，用于展示其他功能
    {title:'我的最爱',img:$r('app.media.love')},
    {title:'历史记录',img:$r('app.media.record')},
    {title:'消息',img:$r('app.media.message')},
    {title:'购物车',img:$r('app.media.shopping')},
    {title:'我的目标',img:$r('app.media.target')},
    {title:'圈子',img:$r('app.media.circle')},
    {title:'收藏',img:$r('app.media.favorite')},
    {title:'回收站',img:$r('app.media.recycle')}
  ]

  @State listItem:ListItemType[]=[// 列表项数组，用于展示商品信息
    {title:'排行榜',text:'荆州站，我们不见不散',img:$r('app.media.top')},
    {title:'新品首发',text:'荆州站，我们不见不散',img:$r('app.media.new')},
    {title:'大牌闪购',text:'大牌闪购',img:$r('app.media.brand')},
    {title:'发现好物',text:'荆州站，我们不见不散',img:$r('app.media.found')}
  ]

  @State setItem: SetItemType[] = [
    { title: '推送通知', img: $r('app.media.news'), texF: '开关' },
    { title: '数据管理', img: $r('app.media.data'), texF: '开关' },
    { title: '菜单设置', img: $r('app.media.menu'), texF: '开关' },
    { title: '关于', img: $r('app.media.about'), texF: '开关' },
    { title: '清除缓存', img: $r('app.media.storage'), texF: '开关' },
    { title: '隐私协议', img: $r('app.media.privacy'), texF: '开关' },
  ]

  @Builder tabsBuilder(title:string,Index:number,selecdImg:Resource,normalImg:Resource){
    Column(){// 构建底部导航栏的单个标签项，包括图标和标题文本
      Image(this.currentIndex==Index?selecdImg:normalImg)
      .width(25)
      .height(25)
      Text(title)
        .margin({top:5})
      .fontColor(this.currentIndex==Index?'#1698CE':'#6B6B6B6')
    }
    .justifyContent(FlexAlign.Center)
    .width('100%')
    .height(56)
    .onClick(()=>{
      this.currentIndex=Index
      this.tabsController.changeIndex(this.currentIndex)
    })
  }

  @Builder setUI(sI:SetItemType){
    Row(){
      Image(sI.img)
        .width(22)
        .height(22)
      Text(sI.title)
        .fontSize(16)

      if (sI.texF===null){
        Image($r('app.media.right_grey'))
          .width(12)
          .height(24)
      }else {
        Toggle({type:ToggleType.Switch,isOn:false})
      }
    }
    .justifyContent(FlexAlign.SpaceAround)
    .width('100%')
    .padding({left:8,right:12})
  }

  build() {
    Tabs({barPosition:BarPosition.End,
    controller:this.tabsController
    }){
      TabContent(){
        Scroll(){
          Column({space:12}){
            Column(){
              Text('首页')
                .fontSize(24)
                .fontWeight(FontWeight.Medium)
                .margin({top:12})
                .padding({left:12})
            }
            .width('100%')
            .alignItems(HorizontalAlign.Start)

            Swiper(this.swiperController){
              ForEach(this.picture, (pI: ImageItem)=>{
                Image(pI.img)
                  .borderRadius(16)
                  .width('100%')       // 占满父容器宽度
                  .height(200)         // 设置固定高度（根据需求调整）
                  .objectFit(ImageFit.Cover)  // 图片适配模式（避免拉伸变形）

              }, (pI: ImageItem, index: number) => index.toString()) // 用索引作为 key
            }
            .width('100%')  // Swiper宽度占满父容器
            .height(200)    // 与Image高度保持一致
            .margin({ top: 24 })
            .autoPlay(true)
            .loop(true)     // 开启循环播放（重要：避免轮播到最后一张后空白）

            Grid(){
              ForEach(this.otherItem,(oI:OtherItemType)=>{
                GridItem(){
                  Column(){
                    Image(oI.img)
                      .width(24)
                      .height(24)
                    Text(oI.title)
                      .fontSize(12)
                      .margin({top:4})
                  }
                }
              })
            }
            .columnsTemplate('1fr 1fr 1fr 1fr')
            .rowsTemplate('1fr 1fr 1fr')
            .rowsGap(12)
            .columnsGap(8)
            .padding({top:12,bottom:12})
            .height(124)
            .backgroundColor(Color.White)
            .borderRadius(24)

            Text("列表")
              .fontSize(16)
              .fontWeight(FontWeight.Medium)
              .width('100%')
              .margin({top:12})

            Grid(){
              ForEach(this.listItem,(lI:ListItemType)=>{
                GridItem(){
                  Column(){
                    Text(lI.title)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                    Text(lI.text)
                      .margin({top:4})
                      .fontSize(12)
                      .fontColor('#99182431')
                  }
                  .alignItems(HorizontalAlign.Start)
                }
                .padding({top:8,left:8})
                .borderRadius(12)
                .align(Alignment.TopStart)
                .backgroundImage(lI.img)
                .backgroundImageSize(ImageSize.Cover)
                .width('100%')
                .height('100%')
              })
            }
            .width('100%')
            .height(260)
            .columnsTemplate('1fr 1fr')
            .rowsTemplate('1fr 1fr')
            .columnsGap(8)
            .rowsGap(12)
            .margin({bottom:15})
          }
        }
        .height('100%')
      }
      .padding({left:12,right:12})
      .backgroundColor('#F1F3F5')
      .tabBar(this.tabsBuilder('首页',0,$r('app.media.home_selected'),$r('app.media.home_normal')))

    TabContent(){
        Scroll(){
          Column(){
            Column(){
              Text('我的')
                .fontSize(24)
                .margin({top:12,left:12})
                .padding({left:12})
            }
            .width("100%")
            .alignItems(HorizontalAlign.Start)

            Row(){
              Image($r('app.media.account'))
                .width(48)
                .height(48)
              Text('Mr.XX')
                .fontSize(12)
              Text('123456789@qq.com')
                .fontSize(12)
                .margin({top:4})
            }
            .alignItems(VerticalAlign.Center)
            .width('100%')
            .margin({top:24})
            .height(96)
            .backgroundColor(Color.White)
            .padding({left:24})
            .borderRadius(16)

            List(){
              ForEach(this.setItem,(sI:SetItemType)=>{
                ListItem(){
                  this.setUI(sI)
                }
                .height(48)
              })
            }
            .width('100%')
            .height('50%')
            .backgroundColor(Color.White)
            .divider({
              strokeWidth:0.25,
              color:Color.Grey,
              startMargin:42,
              endMargin:24
            })
            .borderRadius(16)
            .padding({top:4,bottom:4})

            Blank()
            Button('退出登录',{type:ButtonType.Capsule})
              .width('90%')
              .height(40)
              .fontSize(16)
              .fontColor('#FA2A2D')
              .fontWeight(FontWeight.Medium)
              .backgroundColor('#E5E8EA')
              .margin({bottom:5})
              .onClick(()=>{
                AlertDialog.show({
                  title:'提示消息',
                  message:'确定要退出登录吗？',
                  offset:{dx:0,dy:-20},
                  gridCount:4,
                  alignment:DialogAlignment.Bottom,
                  autoCancel:true,
                  primaryButton:{
                    value:'取消',
                    action:()=>{
                      //取消操作
                    }
                  },
                  secondaryButton:{
                    value:'确定',
                    action:()=>{
                      router.back({url:'pages/LoginPage'})
                    }
                  },
                  cancel:()=>{
                    //取消操作
                  }
                })
              })
          }
          .height('100%')
        }
    }

    .padding({left:12,right:12})
      .backgroundColor('#F1F3F5')
      .tabBar(this.tabsBuilder('我的',1,$r('app.media.mine_selected'),
      $r('app.media.mine_normal')))

    }
    .width('100%')
    .backgroundColor(Color.White)
    .barHeight(56)
    .barMode(BarMode.Fixed)
    .onChange((Index:number)=>{
      this.currentIndex=Index
    })
  }
}