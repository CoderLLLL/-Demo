interface bookThis {
  myThis:Object,
  func:Function
}

interface userThis {
  myThis:Object,
  func:Function
}

interface book {
  id:number,
  booknumber:string,
  bookname:string,
  author:string,
  summary:string,
  sum:number,
  publictime:string,
  userlist:string[] | string,
  picture:string,
  showflag:number,
  type:string
}

interface userData{
  id:number
  name:string
  username:string
  sex:number
  phone:string
  identity:string,
  bookList:book[]
}

interface storeType{
  bookList:{
    data:book[],
    dependencyList:bookThis[]
  },
  userDatas:{
    data:userData,
    dependencyList:userThis[]
  }
}

export {storeType,bookThis,book,userData}