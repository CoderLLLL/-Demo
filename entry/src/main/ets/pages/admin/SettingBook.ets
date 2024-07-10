import ConSom from '../SonCom'
import BookType from '../../components/admin/BookType'
import BookListBox from '../../components/admin/BookListBox'
import SearchBox from '../../components/SearchBox'

@Component

export default struct SettingBook{
  build(){
    ConSom(){
      Column(){
        Row(){
          Text("管理").fontSize(30)
        }
      }.alignItems(HorizontalAlign.Start)

      List({space:10}){
        ListItem(){
          SearchBox({routerLink:"pages/admin/AdminSearch"})
        }

        ListItem(){
          BookType()
        }

        ListItem(){
          BookListBox()
        }
      }.margin({top:10,bottom:40})
      .borderRadius(10)
    }
  }
}