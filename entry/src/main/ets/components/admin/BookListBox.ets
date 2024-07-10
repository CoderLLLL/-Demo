import BookListItem from 'ets/components/admin/BookListBoxItem'
import store from '../../store/myStore'
import {book} from '../../store/type/type'

@Component

export default struct BookListBox{
  @State bookList:book[] = []
  @State sum:number = 0

  getBookList(myThis:BookListBox,storeBookList:book[]){
    myThis.bookList = storeBookList
    myThis.sum = 0
    for (const element of myThis.bookList) {
      if(element.showflag == 1) myThis.sum++
    }
  }

  aboutToAppear(){
    store.getBook(this,this.getBookList);
  }

  build(){
    Column(){
      Row(){
        Text("书本列表")
      }

      if(this.sum > 0){
        ForEach(this.bookList,(item:book)=>{
          if(item.showflag == 1){
            Row(){
              BookListItem({
                bookName:item.bookname as string,
                summary:item.summary as string,
                sum:item.sum as number,
                routerLink:"pages/admin/AdminBookDetail",
                ids:item.id as number
              })
            }
          }
        })
      } else{
        Row(){
          Column(){
            Row(){
              Image("image/null2.png")
                .width("100%")
            }
            Row(){
              Text("书本列表为空").fontSize(25).margin(30).fontColor(Color.Gray)
            }
          }.margin({top:50})
        }
      }

    }.width("100%")
    .backgroundColor(Color.White)
    .borderRadius(20)
    .padding(20)
  }
}