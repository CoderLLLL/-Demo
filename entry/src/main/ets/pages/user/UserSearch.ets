import router from '@ohos.router'
import {getBookListByBookName} from '../../service/index'
import {book} from '../../store/type/type'
import {HMRSCOde} from '../../service/type/type'


import  BookListBoxItem from '../../components/admin/BookListBoxItem'
import MyToast from '../../utils/myToast'


@Entry
@Component

struct AdminSearch{
  @State promot:string = "请输入搜索内容"
  @State searchText:string = ""
  @State searchBookList:book[] = []

  async getData(){
    if(this.searchText.length == 0){
      MyToast("请输入搜索内容")
    } else{
      await getBookListByBookName({bookName:this.searchText + ""}).then((res:HMRSCOde)=>{
        if(res.data.statusCode == 403){
          this.promot = "没有找到相关书本"
        } else{
          MyToast("查找成功")
          this.searchBookList = res.data.data
        }
      })
    }
  }

  build(){
    Column({space:10}){
      Row({space:10}){
        Column() {
          Image("/image/ic_public_back.svg").width('30vh')
            .onClick(()=>{
              router.back()
            })

        }
        Column(){
          Text("搜索").fontSize(30)
        }
      }

      Row({space:10}){
        Column(){
          TextInput({placeholder:"输入搜索信息"})
            .onChange((e)=>{
              this.searchText = e;
              if(this.searchText.length == 0) this.promot = "请输入搜索内容"
            })
        }.width("80%")

        Column(){
          Button("搜索").onClick((event: ClickEvent) => {
            this.getData()
          })
        }.width("20%")
      }

      if(this.searchBookList.length == 0 || this.promot == "请输入内容" || this.promot == "没有找到相关书本"){
        Column(){
          Row(){
            Image("/image/null.png")
              .width("100%")
          }
          Row(){
            Text(this.promot).fontSize(25).margin(30).fontColor(Color.Gray)
          }
        }.margin({top:50})
      } else{
        Column(){
          List(){
            ForEach(this.searchBookList,(item:book)=>{
              ListItem(){
                BookListBoxItem({
                  bookName:item.bookname as string,
                  summary:item.summary as string,
                  sum:item.sum as number,
                  routerLink:"pages/user/UserBookDetail",
                  ids:item.id as number
                })
              }
            })
          }
        }.backgroundColor(Color.White)
        .borderRadius(15)
      }



    }.width("100%")
    .height("100%")
    .backgroundColor('#F1F3F5')
    .padding({bottom:15,left:15,right:15,top:70})
    .alignItems(HorizontalAlign.Start)
  }
}