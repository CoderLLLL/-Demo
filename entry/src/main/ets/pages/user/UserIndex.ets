import SubscribeBooks from './SubscribeBooks'
import UserDetail from './UserDetail'

import {getBookListWithUser,getUserSubscribeById} from '../../service/index'
import {HMRSCOde} from '../../service/type/type'
import store from '../../store/myStore'
import {userData,book} from '../../store/type/type'

import router from '@ohos.router';

interface Data{
  id:number
  name:string
  username:string
  sex:number
  phone:string
  identity:string
  bookList:string
}

@Entry
@Component
struct UserIndex {
  @State ids:number = 0
  @State name:string = ""
  @State adminName:string = ""
  @State sex:number = 1
  @State phone:string = ""
  @State identity:string = ""

  aboutToAppear(){
    getBookListWithUser().then((res:HMRSCOde)=>{
      store.setBookList(res.data.data)
    })

    const data = router.getParams() as Data;
    this.ids = data.id
    this.name = data.name
    this.adminName = data.username
    this.sex = data.sex
    this.phone = data.phone
    this.identity = data.identity

    const userDatas = {
      id: data.id,
      name :data.name,
      username : data.username,
      sex:data.sex,
      phone:data.phone,
      identity:data.identity,
      bookList:JSON.parse(data.bookList)
    }

    store.setUserDatas(userDatas as userData)
  }

  build(){
    Column(){
      Tabs({ barPosition: BarPosition.End}) {
        TabContent() {
          SubscribeBooks()

        }.align(Alignment.TopStart)
        .backgroundColor('#F1F3F5')
        .tabBar('订阅书本')


        TabContent() {
          UserDetail({
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