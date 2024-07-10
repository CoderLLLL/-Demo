import promptAction from '@ohos.promptAction';
import router from '@ohos.router';

import {userRegister } from '../service/index'
import {RSCode} from '../service/type/type'

@Entry
@Component
struct Register {
  @State name:string = "";
  @State username:string = "";
  @State password:string = "";
  @State password2:string = "";
  @State phone:string = "";
  @State sex:number = 1
  @State grade:string = "";

  @State flag:boolean = true;

  MyToast(text:string){
    promptAction.showToast({
      message: text,
      duration: 3000 //3秒
    })
  }

  async RegisterUser(){
    if(this.password != this.password2){
      this.MyToast("两次密码不一致")
    }

    const userData = {
      name:this.name,
      username:this.username,
      password:this.password,
      phone:this.phone,
      sex:this.sex,
      grade:this.grade
    }

    Object.keys(userData).forEach(key=>{
      if(userData[key] == ""){
        this.MyToast("请填写完整信息")
        this.flag = false
      }
    })

    if(!this.flag) return false;

     await userRegister(userData).then((res:RSCode)=>{
       if(res.data.statusCode == 200){

       }
       this.MyToast(res.data.msg)
    })
  }

  build() {
    Column(){
      Row(){
        Button("<")
          .fontSize(30)
          .backgroundColor(Color.White)
          .fontColor(Color.Black)
          .onClick(()=>{
            router.replaceUrl({
              url:'pages/Index'
            })
          })
        Text("用户注册").padding({left:10})
      }
      .width('100%')
      .padding(15)
      .margin({top:50})
      .shadow({radius:1,offsetY:4,color:Color.Gray})

      Row(){
        Text("基础信息")
      }
      .width('100%')
      .padding({left:20,top:10})

      Row(){
        TextInput({placeholder:'请输入用户名'})
          .height(50)
          .onChange(value=>{
            this.name = value
          })
      }
      .width('100%')
      .padding(10)

      Row(){
        TextInput({placeholder:'请输入账号'})
          .height(50)
          .onChange(value=>{
            this.username = value
          })
      }
      .width('100%')
      .padding(10)

      Row(){
        TextInput({placeholder:'请输入密码'})
          .height(50)
          .onChange(value=>{
            this.password = value
          })
      }
      .width('100%')
      .padding(10)

      Row(){
        TextInput({placeholder:'确认密码'})
          .height(50)
          .onChange(value=>{
            this.password2 = value
          })
      }
      .width('100%')
      .padding(10)

      Row(){
        TextInput({placeholder:'请输入手机号'})
          .height(50)
          .onChange(value=>{
            this.phone = value
          })
      }
      .width('100%')
      .padding(10)

      Row(){
        TextInput({placeholder:'请输入年级'})
          .height(50)
          .onChange(value=>{
            this.grade = value
          })
      }
      .width('100%')
      .padding(10)

      Row(){
        Text("请选择性别")
      }
      .width('100%')
      .padding({left:20,top:10})

      Row(){
        Text("女").margin({left:50})
        Radio({ value: '女', group: 'radioGroup' })
          .checked(false)
          .onChange(isOn=>{
            this.sex = 0
          })

        Text("男").margin({left:50})
        Radio({ value: '男', group: 'radioGroup' })
          .checked(true)
          .onChange(isOn=>{
            this.sex = 1
          })

      }
      .width('100%')
      .padding(20)

      Row(){
        Button("注册").onClick(()=>{
          this.RegisterUser()
        }).width('100%')
      }
      .width('100%')
      .padding(10)
    }


  }
}