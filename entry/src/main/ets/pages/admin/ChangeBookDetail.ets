import router from '@ohos.router';

import store from '../../store/myStore'
import {book} from '../../store/type/type'

import {updateBookById} from '../../service/index'
import {HMRSNoDataCode,RSCode} from '../../service/type/type'

import MyToast from '../../utils/myToast'

type getRouter = {
  ids:number,
  bookNumber:string,
  bookName:string,
  author:string,
  summary:string,
  sum:number,
  publicTime:string,
  type:string,
  index:number
}

@Entry
@Component
struct ChangeBookDetail {
  @State ids:number = 0;
  @State bookNumber:string = "123456789"
  @State bookName:string = "细说PHP"
  @State author:string = "锋播"
  @State summary:string = "这本书讲述了许多的PHP细节"
  @State sum:number = 100;
  @State publicTime:string = "2024-7-6"
  @State type:string = "实操"
  @State index:number = 0;

  @State year:number = 0
  @State month:number = 0
  @State day:number = 0


  selectedDate: Date = new Date(this.publicTime)

  aboutToAppear(){
    const data:getRouter =  router.getParams() as getRouter
    this.ids = data.ids
    this.bookNumber = data.bookNumber
    this.bookName = data.bookName
    this.author = data.author
    this.summary = data.summary
    this.sum = data.sum
    this.publicTime = data.publicTime
    this.type = data.type
    this.index = data.index

    const timeData = this.publicTime.split('-');
    this.year = parseInt(timeData[0])
    this.month = parseInt(timeData[1])
    this.day = parseInt(timeData[2])

  }

  async changeData(){
    if(this.sum < 0){
      MyToast("数量不能小于0")
      return;
    }

    const data = {
      id:this.ids,
      bookname:this.bookName,
      booknumber:this.bookNumber,
      author:this.author,
      summary:this.summary,
      sum:this.sum,
      publictime:`${this.year}-${this.month}-${this.day}`,
      type:this.type
    }
    await updateBookById(data).then((res:RSCode)=>{
      MyToast(res.data.msg)
      store.setBook(this.index,data  as book)
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
            Text("修改").fontSize(30)
          }
        }
      }

      List({space:10}) {
        ListItem() {
          Row() {
            Image("image/book1.png")
          }
          .width("100%")
          .height("350vh")
          .backgroundColor(Color.White)
          .padding(20)
          .borderRadius(15)
        }

        ListItem(){
          Column({space:10}){
            Row(){
              Text("修改详情").fontSize(25)
            }

            Row(){
             Column({space:10}){
               Row(){
                 Text("书本名称").fontColor(Color.Gray)
               }
               Row(){
                 TextInput({text:this.bookName})
                   .onChange((value)=>{
                     this.bookName = value
                   })
               }
             }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("书本编号").fontColor(Color.Gray)
                }
                Row(){
                  TextInput({text:this.bookNumber})
                    .onChange((value)=>{
                      this.bookNumber = value
                    })
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("作者").fontColor(Color.Gray)
                }
                Row(){
                  TextInput({text:this.author})
                    .onChange((value)=>{
                      this.author = value
                    })
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("书本类型").fontColor(Color.Gray)
                }
                Row(){
                  TextInput({text:this.type})
                    .onChange((value)=>{
                      this.type = value
                    })
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("简介").fontColor(Color.Gray)
                }
                Row(){
                  TextInput({text:this.summary})
                    .onChange((value)=>{
                      this.summary = value
                    })
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("数量").fontColor(Color.Gray)
                }
                Row(){
                  TextInput({text:this.sum + ""})
                    .onChange((value)=>{
                      this.sum = parseInt(value)
                    })
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("发布日期").fontColor(Color.Gray)
                }
                Row(){
                  Text(""+this.publicTime)
                    .width("100%")
                    .backgroundColor("#f4f6f5")
                    .padding(10)
                    .borderRadius(25)
                    .onClick(()=>{
                      DatePickerDialog.show({
                        start: new Date("1700-11-11"),
                        end: new Date("2100-12-31"),
                        selected: this.selectedDate,
                        onAccept:(value)=>{
                          this.year = value.year
                          this.month = value.month + 1;
                          this.day = value.day
                          this.publicTime =`${value.year}-${value.month + 1}-${value.day}`
                        }
                      })
                    })
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Row({space:10}){
                Column(){
                  Button("取消").onClick(()=>{
                    router.back()
                  }).width("50%")
                }

                Column(){
                  Button("修改").onClick(()=>{
                    console.log("修改")
                    this.changeData()
                  }).backgroundColor(Color.Red)
                    .width("50%")
                }
              }
            }
          }
        } .width("100%")
        .backgroundColor(Color.White)
        .padding(20)
        .borderRadius(15)
        .margin({bottom:40})
      }.borderRadius(15)

    }.width("100%")
    .height("100%")
    .backgroundColor('#F1F3F5')
    .padding({bottom:15,left:15,right:15,top:70})
    .alignItems(HorizontalAlign.Start)
  }
}