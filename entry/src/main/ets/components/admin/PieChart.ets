import { McPieChart, Options } from '@mcui/mccharts'


@Component
export default struct Index {
  @State defOption: Options = new Options({
    series:[
      {
        data:[
          {value:435, name:'直接访问'},
          {value:310, name:'邮件营销'},
          {value:234, name:'联盟广告'},
          {value:135, name:'视频广告'},
          {value:1548, name:'搜索引擎'}
        ]
      }
    ]
  })
  aboutToAppear() {
    setTimeout(() => {
      // 使用Option实例对象的setVal方法来实现，修改什么属性就传什么
      this.defOption.setVal({
        series: [
          {
            data:[
              {value:135, name:'直接访问'},
              {value:310, name:'邮件营销'},
              {value:150, name:'联盟广告'},
              {value:205, name:'视频广告'},
              {value:302, name:'搜索引擎'}
            ]
          }
        ]
      })
    }, 2000)
  }
  build() {
    Row() {
      McPieChart({
        options: this.defOption
      })
    }
    .height('50%')
  }
}