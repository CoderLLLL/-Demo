import {book} from '../../store/type/type'

export interface resObj{
  statusCode?:number,
  msg?:string,
  data?:object
}

export interface RSCode{
  data:{
    statusCode:number,
    msg:string
  }
}

export interface RSDCode{
  statusCode:number,
  data:book[]
}

export interface HMRSCOde{
  data:RSDCode,
  status:number,
  statusText:"",
  header:Object
}

export interface HMRSNoDataCode{
  data:RSCode,
  status:number,
  statusText:"",
  header:Object
}