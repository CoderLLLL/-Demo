import router from '@ohos.router';
import {book} from '../../store/type/type'

import {getBookListByUserId} from '../../service/index'
import {HMRSCOde} from '../../service/type/type'

import BookListBoxItem from '../../components/admin/BookListBoxItem'


type getRouter = {
  userId:number
  userName:string
  phone:string
  sex:number
}

@Entry
@Component
struct AdminLookUser {
  @State userId:number = 0
  @State userName:string = ""
  @State phone:string = "11122223333"
  @State sex:number = 1

  @State bookList:book[] = []

  aboutToAppear(){
    const data = router.getParams() as getRouter
    this.userId = data.userId
    this.userName = data.userName
    this.phone = data.phone
    this.sex = data.sex

    getBookListByUserId({userId:this.userId}).then((res:HMRSCOde)=>{
      // console.log("ddddsadasd:"+JSON.stringify(res))
      this.bookList = res.data.data
    })
  }

  build() {
    Column({space:10}) {
      Column({space:10}) {
        Row({ space: 10 }) {
          Column() {
            Image("/image/ic_public_back.svg").width('30vh')
              .onClick(() => {
                router.back()
              })
          }

          Column() {
            Text("详情").fontSize(30)
          }
        }
      }

      List({space:10}){
        ListItem(){
          Row(){
            Image("image/header.jpg").borderRadius(15)
          }.width("100%")
          .height("350vh")
          .backgroundColor(Color.White)
          .padding(20)
          .borderRadius(15)
        }

        ListItem(){
          Column({space:10}){
            Row(){
              Text("TA的信息").fontSize(30)
            }

            Column({space:10}){
              Row(){
                Text("用户名").fontSize(14).fontColor(Color.Gray)
              }

              Row(){
                Text(this.userName)
              }

              Row(){
                Text("性别").fontSize(14).fontColor(Color.Gray)
              }

              Row(){
                Text(this.sex == 1 ? "男" : "女")
              }

              Row(){
                Text("电话号码").fontSize(14).fontColor(Color.Gray)
              }

              Row(){
                Text(this.phone)
              }
            }
          }.alignItems(HorizontalAlign.Start)
        }.width("100%")
        .backgroundColor(Color.White)
        .padding(20)
        .borderRadius(15)

        ListItem(){
          Column(){
            Row(){
              Text("TA的订阅").fontSize(30)
            }

            ForEach(this.bookList,(item:book)=>{
             Row(){
               BookListBoxItem({
                 ids:item.id as number,
                 bookName:item.bookname as string,
                 summary:item.summary as string,
                 sum:item.sum as number,
                 routerLink:"pages/admin/AdminBookDetail"
               })
             }
            })
          }
        }.width("100%")
        .backgroundColor(Color.White)
        .padding(20)
        .borderRadius(15)


      }.borderRadius(15).margin({bottom:20})

    }.width("100%")
    .height("100%")
    .backgroundColor('#F1F3F5')
    .padding({bottom:15,left:15,right:15,top:70})
    .alignItems(HorizontalAlign.Start)
  }
}