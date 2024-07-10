import {storeType,bookThis,book,userData} from './type/type'

class myStore {
  private store:storeType

  constructor() {
    this.store = {
      bookList:{
        data:[],
        dependencyList:[]
      },
      userDatas:{
        data:{
          id:0,
          name:"undefined",
          username:"undefined",
          sex:1,
          phone:"11122223333",
          identity:"用户",
          bookList:[]
        },
        dependencyList:[]
      }
    }
  }

  _refresh(dependencyList:bookThis[]){
    for(const funcItem of dependencyList){
      funcItem.func(funcItem.myThis,this.store.bookList.data)
    }
  }

  getBook(myThis:Object,func:Function){
    func(myThis,this.store.bookList.data)
    this.store.bookList.dependencyList.push({func:func,myThis:myThis})
  }

  setBookList(newBookList:book[]){
    this.store.bookList.data = newBookList;
    this._refresh(this.store.bookList.dependencyList)
  }

  setBook(index:number,newBook:book){
    const tempBook = newBook;
    tempBook.userlist = this.store.bookList.data[index].userlist
    tempBook.showflag = this.store.bookList.data[index].showflag
    tempBook.picture = this.store.bookList.data[index].picture

    this.store.bookList.data[index] = tempBook
    this._refresh(this.store.bookList.dependencyList)
  }

  pushBook(newBook:book){
    const tempBook = newBook;
    tempBook.showflag = 1;
    tempBook.userlist = []

    this.store.bookList.data.push(tempBook);
    this._refresh(this.store.bookList.dependencyList);
  }

  changeBookShowFlag(index:number,flag:number){
    this.store.bookList.data[index].showflag = flag
    this._refresh(this.store.bookList.dependencyList);
  }




  getUserDatas(myThis:Object,func:Function){
    func(myThis,this.store.userDatas.data)
    this.store.userDatas.dependencyList.push({func:func,myThis:myThis})
  }

  setUserDatas(newUserData:userData){
    this.store.userDatas.data = newUserData
    this._refresh(this.store.userDatas.dependencyList)
  }

  setUserSubscribe(bookList:book[]){
    this.store.userDatas.data.bookList = bookList
    this._refresh(this.store.userDatas.dependencyList)
  }

  unSubscribe(bookId:number){
    let index = 0;
    for (const book of this.store.userDatas.data.bookList) {
      if(book.id != bookId){
        index++
      }
    }

    this.store.userDatas.data.bookList.splice(index,1)
    this._refresh(this.store.userDatas.dependencyList)
  }

  pushBookWithUserBookList(newBook:book){
    const tempBook = newBook;
    tempBook.showflag = 1;
    tempBook.userlist = []

    this.store.userDatas.data.bookList.push(tempBook);
    this._refresh(this.store.userDatas.dependencyList);
  }

}

export default new myStore()