import MyToast from '../../utils/myToast';
import ConSom from '../SonCom'

import {addNewBook} from '../../service/index'
import {RSCode} from '../../service/type/type'

import store from '../../store/myStore'
import {book} from '../../store/type/type'


@Component

export default struct AddBook{
  today:Date = new Date();

  @State bookNumber:string = ""
  @State f1:boolean = false

  @State bookName:string = ""
  @State f2:boolean = false

  @State author:string = ""
  @State f3:boolean = false

  @State summary:string = ""
  @State f4:boolean = false

  @State sum:number = 0;
  @State f5:boolean = false

  @State publicTime:string = `${this.today.getFullYear()}-${this.today.getMonth() + 1}-${this.today.getDate()}`
  @State type:string = ""
  @State f6:boolean = false

  @State year:number = 0
  @State month:number = 0
  @State day:number = 0

  @State isTrue:boolean = false

  selectedDate: Date = new Date(this.publicTime)


  async addBook(){

    if(!this.f1 || !this.f2 ||!this.f3 ||!this.f4 ||!this.f6){
      MyToast("请填写完整或正确的图书信息")
      return false;
    }
    else if(!this.f5){
      MyToast("图书数量不能小于0")
      return false;
    }

    if(this.year == 0){
      this.year = this.today.getFullYear()
      this.month = this.today.getMonth() + 1
      this.day = this.today.getDate()
    }

    const newBook = {
      bookname:this.bookName,
      booknumber:this.bookNumber,
      author:this.author,
      summary:this.summary,
      sum:this.sum,
      publictime:`${this.year}-${this.month}-${this.day}`,
      type:this.type,
      picture:"null"
    }

    await addNewBook(newBook).then((res:RSCode)=>{
      MyToast(res.data.msg)
      if(res.data.statusCode == 200){
        store.pushBook(newBook as book)
      }
    })
  }

  build(){
    ConSom(){
      Column({space:10}){
        Row(){
          Text("添加").fontSize(30)
        }
      }.margin({bottom:10})

      List({space:10}) {
        ListItem() {
          Column({space:10}) {
            Row(){
              Text("图片信息")
            }
            Row(){
              Image("image/book1.png")
            }
          }
          .width("100%")
          .backgroundColor(Color.White)
          .padding(20)
          .borderRadius(15)
        }

        ListItem(){
          Column({space:10}){
            Row(){
              Text("书本信息").fontSize(20)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("图书名称").fontColor(Color.Gray).fontSize(14)
                }
                Row(){
                  TextInput({placeholder:"输入图书名称"})
                    .onChange((value:string)=>{
                      this.bookName = value
                      if(this.bookName.length  < 1){
                        this.f1 = false
                      } else{
                        this.f1 = true
                      }
                    })
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("图书编号").fontColor(Color.Gray).fontSize(14)
                }
                Row(){
                  TextInput({placeholder:"输入图书编号"})
                    .onChange((value:string)=>{
                      this.bookNumber = value
                      if(this.bookNumber.length  < 1){
                        this.f2 = false
                      } else{
                        this.f2 = true
                      }
                    })
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("作者名称").fontColor(Color.Gray).fontSize(14)
                }
                Row(){
                  TextInput({placeholder:"输入作者"})
                    .onChange((value:string)=>{
                      this.author = value
                      if(this.author.length  < 1){
                        this.f3 = false
                      } else{
                        this.f3 = true
                      }
                    })
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("图书简介").fontColor(Color.Gray).fontSize(14)
                }
                Row(){
                  TextInput({placeholder:"输入图书简介"})
                    .onChange((value:string)=>{
                      this.summary = value
                      if(this.summary.length  < 1){
                        this.f4 = false
                      } else{
                        this.f4 = true
                      }
                    })
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("图书数量").fontColor(Color.Gray).fontSize(14)
                }
                Row(){
                  TextInput({placeholder:"输入图书数量"})
                    .onChange((value:string)=>{
                      this.sum = parseInt(value)
                      if(this.sum  < 0){
                        this.f5 = false
                      } else{
                        this.f5 = true
                      }
                    }).type(InputType.Number)
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("图书类型").fontColor(Color.Gray).fontSize(14)
                }
                Row(){
                  TextInput({placeholder:"输入图书类型"})
                    .onChange((value:string)=>{
                      this.type = value
                      if(this.type.length  < 1){
                        this.f6 = false
                      } else{
                        this.f6 = true
                      }
                    })
                }
              }.alignItems(HorizontalAlign.Start)
            }

            Row(){
              Column({space:10}){
                Row(){
                  Text("发布日期").fontColor(Color.Gray).fontSize(14)
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
              Button("添加书本到服务器").width("100%").onClick(()=>{
                this.addBook()
              })
            }.margin({top:15})




          }.width("100%")
          .backgroundColor(Color.White)
          .padding(20)
          .borderRadius(15)
        }
      }.borderRadius(15)
      .margin({bottom:40})
    }
  }
}