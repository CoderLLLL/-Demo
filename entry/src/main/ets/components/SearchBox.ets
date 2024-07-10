import router from '@ohos.router';
@Component

export default struct SearchBox{
  @Prop routerLink:string;

  build(){
    Column(){
      Text("点击搜索资料").fontColor("#7b8083")
    }.width("100%")
    .height("40vh")
    .padding(10)
    .backgroundColor("#e6eaeb")
    .alignItems(HorizontalAlign.Start)
    .borderRadius(15)
    .onClick(()=>{
      router.pushUrl({
        url:this.routerLink
      })
    })
  }
}