import SettingBook from './SettingBook'
import AddBook from './AddBook'
import AdminDetail from './AdminDetail'

import {getBookListWithAdmin} from '../../service/index'
import {HMRSCOde} from '../../service/type/type'
import store from '../../store/myStore'

import router from '@ohos.router';

interface Data{
  id:number
  name:string
  username:string
  sex:number
  phone:string
  identity:string
}

@Entry
@Component
struct AdminIndex {
  @State ids:number = 0
  @State name:string = ""
  @State adminName:string = ""
  @State sex:number = 1
  @State phone:string = ""
  @State identity:string = ""

  aboutToAppear(){
    getBookListWithAdmin().then((res:HMRSCOde)=>{
      console.log("ssss:"+JSON.stringify(res))
      store.setBookList(res.data.data)
    })

    const data = router.getParams() as Data;
    this.ids = data.id
    this.name = data.name
    this.adminName = data.username
    this.sex = data.sex
    this.phone = data.phone
    this.identity = data.identity
  }

  build(){
    Column(){
      Tabs({ barPosition: BarPosition.End}) {
        TabContent() {
          SettingBook()

        }.align(Alignment.TopStart)
        .backgroundColor('#F1F3F5')
        .tabBar('管理书本')

        TabContent() {
          AddBook()
        }.align(Alignment.TopStart)
        .backgroundColor('#F1F3F5')
        .tabBar('添加书本')

        TabContent() {
          AdminDetail({
            ids:this.ids,
            name:this.name,
            adminName:this.adminName,
            sex:this.sex,
            phone:this.phone,
            identity:this.identity
          })
        }.align(Alignment.TopStart)
        .backgroundColor('#F1F3F5')
        .tabBar("我的")
      }
      .barMode(BarMode.Fixed)
    }
  }
}