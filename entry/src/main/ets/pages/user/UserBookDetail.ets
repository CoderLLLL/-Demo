import router from '@ohos.router';

import store from '../../store/myStore'
import {book,userData} from '../../store/type/type'

import {RSCode} from '../../service/type/type'
import MyToast from '../../utils/myToast';

import {userSubscribeBook} from '../../service/index'

type getRouter = {
  ids:number
}

@Entry
@Component
struct UserBookDetail {
  @State userId:number = 0

  aboutToAppear(){
    const data:getRouter = router.getParams() as getRouter
    this.ids = data.ids
    console.log("ids"+this.ids)
    function getBookById(myThis:UserBookDetail,bookList:book[]){
      for (const book of bookList) {
        console.log("bookId"+book.id)
        if(book.id == myThis.ids){
          myThis.bookName = book.bookname
          myThis.bookNumber = book.booknumber
          myThis.author = book.author
          myThis.summary = book.summary
          myThis.sum = book.sum
          myThis.publicTime = book.publictime
          myThis.type = book.type
          return;
        } else{
          myThis.index++
        }
      }
    }

    store.getBook(this,getBookById);
    store.getUserDatas(this,(myThis:UserBookDetail,userDatas:userData)=>{
      myThis.userId = userDatas.id
    })
  }

  @State index:number = 0;
  @State ids:number = 0;
  @State bookNumber:string = "123456789"
  @State bookName:string = "细说PHP"
  @State author:string = "锋播"
  @State summary:string = "这本书讲述了许多的PHP细节"
  @State sum:number = 100;
  @State publicTime:string = "2024-07-06 01:44:35"
  @State userList:string[] = []
  @State type:string = "实操"

  async SubScribeBook(){
    const data = {
      userId:this.userId,
      bookId:this.ids
    }

    await userSubscribeBook(data).then((res:RSCode)=>{
      MyToast(res.data.msg)
      const newBook = {
        id:this.ids,
        bookname : this.bookName,
        booknumber : this.bookNumber,
        author : this.author,
        summary: this.summary,
        sum : this.sum,
        publictime : this.publicTime,
        type : this.type
      } as book
      if (res.data.statusCode == 200) {
        store.pushBookWithUserBookList(newBook)
      }
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

      List({space:20}){
        ListItem(){
          Row(){
            Image("image/book1.png")
          }.width("100%")
          .height("350vh")
          .backgroundColor(Color.White)
          .padding(20)
          .borderRadius(15)
        }

        ListItem(){
          Row(){
            Column({space:10}){
              Row(){
                Text(this.bookName).fontSize(23).fontWeight(700)
              }

              Row(){
                Text("书本编号："+this.bookNumber).fontColor(Color.Gray)
              }

              Row(){
                Text("书本介绍："+this.summary).fontSize(16).fontColor(Color.Gray)
              }

              Row(){
                Text("发布时间："+this.publicTime).fontColor(Color.Gray)
              }

              Row(){
                Text("书本类型："+this.type).fontColor(Color.Gray)
              }

              Row(){
                Text("书本剩余数量："+this.sum).fontSize(16).fontColor(Color.Gray)
              }

              Row({space:10}){
                Column(){
                  Button("订阅").width("100%")
                    .onClick(()=>{
                      this.SubScribeBook()
                    })
                }.width("100%")
              }


            }.alignItems(HorizontalAlign.Start)

          }.width("100%")
          .backgroundColor(Color.White)
          .padding(20)
          .borderRadius(15)
        }
      }.borderRadius(15)

    }.width("100%")
    .height("100%")
    .backgroundColor('#F1F3F5')
    .padding({bottom:15,left:15,right:15,top:70})
    .alignItems(HorizontalAlign.Start)
  }
}