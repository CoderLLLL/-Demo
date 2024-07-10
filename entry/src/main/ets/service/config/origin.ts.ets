import axios from '@ohos/axios'

class LHRequest {
  private  instance;

  constructor(){
    this.instance = axios.create({
      baseURL:'http://120.24.160.47:7111', //'http://192.168.43.181:7111'
      timeout:60000
    })

    this.instance.interceptors.request.use(config=>{
      return config
    },err=>{
      //console.log(err);
      return false
    })

    this.instance.interceptors.response.use(result=>{
      //console.log(result);
      return result
    },err=>{
      console.log(err);
      return err
    })
  }

  request(config){
    return new Promise((resovle,reject)=>{
      this.instance.request(config).then(res=>{
        resovle(res)
      }).catch(err=>{
        reject(err)
      })
    })
  }

  get(config){
    return this.request({...config,method:'GET'})
  }

  post(config){
    return this.request({...config,method:'POST'})
  }
}

export default new LHRequest()