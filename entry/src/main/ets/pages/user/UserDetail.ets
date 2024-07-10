import router from '@ohos.router'
import ConSom from '../SonCom'

import {book,userData} from '../../store/type/type'
import store from '../../store/myStore'

import UserBookListItem from '../../components/user/UserBookListItem'

interface Data{
  id:number
  name:string
  adminName:string
  sex:number
  phone:string
  identity:string
}

@Component

export default struct UserDetail{
  @Prop ids:number
  @Prop name:string
  @Prop adminName:string
  @Prop sex:number
  @Prop phone:string
  @Prop identity:string

  @State subscribe:book[] = []

  aboutToAppear(){
    store.getUserDatas(this,(myThis:UserDetail,userDatas:userData)=>{
      myThis.subscribe = userDatas.bookList
    })
  }

  build(){
    ConSom(){
      Column(){
        Row(){
          Text("我的").fontSize(30)
        }

        List({space:10}){
          ListItem(){
            Row({space:10}){
              Column(){
                Image('image/header.jpg').width("100vh").height("100vh").borderRadius(15)
              }
              Column(){
                Text("用户名："+this.name)
              }
            }.width("100%")
            .backgroundColor(Color.White)
            .padding(20)
            .borderRadius(15)
          }

          ListItem(){
            Column({space:10}){
              Row(){
                Text("基本信息").fontSize(20)
              }

              Row(){
                Text("用户账号："+this.adminName)
              }

              Row(){
                Text("性别："+(this.sex == 1 ? '男' : '女'))
              }

              Row(){
                Text("手机号："+this.phone)
              }

              Row(){
                Text("账号身份："+this.identity)
              }
            }.width("100%")
            .backgroundColor(Color.White)
            .padding(20)
            .borderRadius(15)
            .alignItems(HorizontalAlign.Start)
          }

          ListItem(){
            Column({space:10}){
              Row(){
                Text("订阅列表")
              }

              ForEach(this.subscribe,(item:book)=>{
                Column({space:10}){
                  Row(){
                    UserBookListItem({
                      ids:item.id as number,
                      bookName:item.bookname as string,
                      summary:item.summary as string,
                      sum:item.sum as number,
                      routerLink:"pages/user/UserUnSubscribeBookDetail"})
                  }
                }
              })
            }.width("100%")
            .backgroundColor(Color.White)
            .padding(20)
            .borderRadius(15)
          }

          ListItem(){
            Button("退出账号")
              .width("100%")
              .backgroundColor(Color.Red)
              .onClick(()=>{
                router.replaceUrl({
                  url:"pages/Index"
                })
              })
          }
        }
      }.alignItems(HorizontalAlign.Start).margin({bottom:30})
    }
  }
}