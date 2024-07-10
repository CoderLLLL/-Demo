import ConSom from '../SonCom'
import BookType from '../../components/admin/BookType'
import UserBookListBox from '../../components/user/UserBookList'
import SearchBox from '../../components/SearchBox'

@Component

export default struct SettingBook{
  build(){
    ConSom(){
      Column(){
        Row(){
          Text("订阅").fontSize(30)
        }
      }.alignItems(HorizontalAlign.Start)

      List({space:10}){
        ListItem(){
          SearchBox({routerLink:"pages/user/UserSearch"})
        }

        ListItem(){
          BookType()
        }

        ListItem(){
          UserBookListBox()
        }
      }.margin({top:10,bottom:40})
      .borderRadius(10)
    }
  }
}