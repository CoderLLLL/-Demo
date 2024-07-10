import router from '@ohos.router';

@Component

export default struct UserItem{
  @Prop userId:number
  @Prop userName:string
  @Prop phone:string
  @Prop sex:number

  build(){
    Row({space:5}){
      Column(){
        Image("/image/header.jpg").width("100vh").height("100vh").borderRadius(20)
      }

      Column(){
        Text(this.userName)
          .fontSize(25)
          .fontWeight(900)
          .textOverflow({
            overflow:TextOverflow.Ellipsis
          })

        Text("电话:"+this.phone)
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({top:10})
          .textOverflow({overflow: TextOverflow.Ellipsis})
          .maxLines(1)

        Text("性别:"+ (this.sex == 1 ? "男" : "女"))

      }.alignItems(HorizontalAlign.Start)


    }.width("100%")
    .padding({bottom:15})
    .margin({top:15})
    .border({width:{bottom:1},color:{bottom:"#F1F3F5"}})
    .onClick(()=>{
      router.pushUrl({
        url:"pages/admin/AdminLookUser",
        params:{
          userId:this.userId,
          userName:this.userName,
          phone:this.phone,
          sex:this.sex
        }
      })
    })
  }
}