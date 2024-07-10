//导入路由模块
import router from '@ohos.router';


import {checkLogin} from '../service/index'
import {RSCode,HMRSCOde} from '../service/type/type'

import MyToast from '../utils/myToast'

@Entry
@Component
struct Login {
  @State message: string = '图书管理系统'
  @State username:string = "LLLL111"
  @State password:string = ""
  @State identity:boolean = true

  MyToast(text:string){
    MyToast(text)
  }

  async Login(){
    console.log("点击")
     await checkLogin({
      username:this.username,
      password:this.password,
      identity:this.identity ? "管理员" : "用户"
    }).then((res:HMRSCOde)=>{
        MyToast("登录成功")
       if(res.data.statusCode == 200){
         const myUrl = this.identity ? 'pages/admin/AdminIndex' : 'pages/user/UserIndex'
         //这里写跳转页面
         router.replaceUrl({
           url:myUrl,
           params:res.data.data
         })
       }
    })
  }

  build() {
    Row() {
      Column() {
        Image($r("app.media.login"))
          .width('100%')
          .height('260vp')
          .margin({bottom:'28vp'})
        Text(this.message)
          .fontSize('30vp')
          .fontWeight(FontWeight.Bold)
        TextInput({placeholder:'请输入用户名'})
          .inputStyle()
          .onChange(value=>{//输入值变化时，触发回调
            this.username = value
            console.log(''+this.username)
          })

        TextInput({placeholder:'请输入密码'})
          .inputStyle()
          .onChange(value=>{//输入值变化时，触发回调
            this.password = value ;
            console.info('password:'+value)
          })

        Row(){
          Column(){
            Text(this.identity ? "管理员登录" : "用户登录")
          }
          Column(){
            Toggle({ type: ToggleType.Switch, isOn: true }).onChange((isOn:boolean)=>{
              this.identity = isOn
            })
          }
        }

        //登录
        Button('登录',{type:ButtonType.Capsule,stateEffect:true})
          .width('85%')
          .margin('20vp')
          .onClick(()=>{
            if (this.username=='' || this.password==''){
              MyToast("用户名或密码不能为空")
              return
            }else {
              this.Login()
            }
          })
        // 注册
        Row(){
          Button('注册')
            .width('85%')
            .onClick(()=>{
              console.log("跳转")
              router.pushUrl({
                url:"pages/Register"
              })
            })
        }
      }
      .width('100%')
    }
    .height('100%')

  }
}
//添加公共装饰器
@Extend(TextInput) function inputStyle(){
  .placeholderColor(0x999999)
  .maxLength(20)//最大输入长度
  .padding('12vp')
  .margin('10vp')
}