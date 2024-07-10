import router from '@ohos.router';
@Component

export default struct BookListItem{
  @Prop ids:number;
  @Prop bookName:string;
  @Prop summary:string;
  @Prop sum:number;

  @Prop routerLink:string;

  build(){
    Row({space:5}){
      Column(){
        Image("/image/book1.png").width("100vh").height("100vh")
      }

      Column(){
        Text(this.bookName)
          .fontSize(25)
          .fontWeight(900)
          .textOverflow({
          overflow:TextOverflow.Ellipsis
        })

        Text(this.summary)
          .fontSize(12)
          .fontColor(Color.Gray)
          .margin({top:10})
          .textOverflow({overflow: TextOverflow.Ellipsis})
          // .ellipsisMode(EllipsisMode.END)
          .maxLines(1)

        Text("数量:"+ this.sum)

      }.alignItems(HorizontalAlign.Start)


    }.width("100%")
    .padding({bottom:15})
    .margin({top:15})
    .border({width:{bottom:1},color:{bottom:"#F1F3F5"}})
    .onClick(()=>{
      router.pushUrl({
        url:this.routerLink,
        params:{
          ids:this.ids
        }
      })
    })
  }
}