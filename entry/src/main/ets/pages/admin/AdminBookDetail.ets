import router from '@ohos.router';

import store from '../../store/myStore'
import {book,userData} from '../../store/type/type'

import {deleteBookById} from '../../service/index'
import {RSCode} from '../../service/type/type'

import UserItem from '../../components/admin/UserItem'
import MyToast from '../../utils/myToast';

type getRouter = {
  ids:number
}

@Entry
@Component
struct AdminBookDetail {

  aboutToAppear(){
    const data:getRouter = router.getParams() as getRouter
    this.ids = data.ids
    console.log("ids"+this.ids)
    function getBookById(myThis:AdminBookDetail,bookList:book[]){
      for (const book of bookList) {
        console.log("bookId"+book.id)
        if(book.id == myThis.ids){
          myThis.bookName = book.bookname
          myThis.bookNumber = book.booknumber
          myThis.author = book.author
          myThis.summary = book.summary
          myThis.sum = book.sum
          myThis.publicTime = book.publictime
          myThis.userList = JSON.parse(book.userlist as string)
          myThis.type = book.type
          console.log("ttttt"+JSON.stringify(myThis.userList))
          return;
        } else{
          myThis.index++
        }
      }
    }

    store.getBook(this,getBookById);
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

  async deleteBook(){
    await deleteBookById({id:this.ids}).then((res:RSCode)=>{
      MyToast(res.data.msg)
      if(res.data.statusCode == 200){
        store.changeBookShowFlag(this.index,0)
        router.back()
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

      List({space:10}){
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
                  Button("删除").width("100%").backgroundColor(Color.Red)
                    .onClick(()=>{
                      this.deleteBook()
                    })
                }.width("50%")

                Column(){
                  Button("编辑")
                    .onClick(()=>{
                      router.pushUrl({
                        url:"pages/admin/ChangeBookDetail",
                        params:{
                          ids:this.ids,
                          bookNumber:this.bookNumber,
                          bookName:this.bookName,
                          author:this.author,
                          summary:this.summary,
                          sum:this.sum,
                          publicTime:this.publicTime,
                          type:this.type,
                          index:this.index
                        }
                      })
                    })
                    .width("100%")
                }.width("50%")
              }


            }.alignItems(HorizontalAlign.Start)

          }.width("100%")
          .backgroundColor(Color.White)
          .padding(20)
          .borderRadius(15)
        }

        ListItem(){
          Column(){
            Row(){
              Column(){
                Text("用户订阅情况")
              }
              Column(){
                Image("/image/ic_public_arrow_right.svg").width('30vh')
              }
            }

            ForEach(this.userList,(item:userData)=>{
              UserItem({
                userId:item.id as number,
                userName:item.name as string,
                phone:item.phone as string,
                sex:item.sex as number
              })
            })
            Row(){

            }
          }.width("100%")
          .backgroundColor(Color.White)
          .padding(20)
          .borderRadius(15)
        }
      }.borderRadius(15).margin({bottom:20})

    }.width("100%")
    .height("100%")
    .backgroundColor('#F1F3F5')
    .padding({bottom:15,left:15,right:15,top:70})
    .alignItems(HorizontalAlign.Start)
  }
}