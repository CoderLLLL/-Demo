@Component

export default struct SonCom{
  // 设置默认 的 Builder，避免外部不传入
  @Builder
  defaultBuilder() {
    Text('默认的内容')
  }

  // 由外部传入 UI
  @BuilderParam ContentBuilder: () => void = this.defaultBuilder

  build(){
    Column(){
      this.ContentBuilder()
    }.padding({bottom:15,left:15,right:15})
    .margin({top:70})
    .alignItems(HorizontalAlign.Start)


  }
}