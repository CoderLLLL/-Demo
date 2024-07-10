import PieChart from './PieChart'

@Component
export default struct BookType{
  build(){
    Column(){
      Row(){
        Text("书本类型统计")
      }
      Row(){
        PieChart().margin({top:20})
      }
    }
    .width("100%")
    .backgroundColor(Color.White)
    .borderRadius(20)
    .padding(20)
  }
}