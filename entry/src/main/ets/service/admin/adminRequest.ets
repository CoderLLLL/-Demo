import HRequest from '../config/origin.ts'
const URL = '/admin'

export async function getBookListWithAdmin(){
  return await HRequest.get({
    url: URL + '/getBookListByAdmin'
  })
}

export async function getBookListByBookName(data){
  return await HRequest.post({
    url: '/public/selectBook',
    params:data
  })
}

export async function updateBookById(data){
  return await HRequest.post({
    url: URL + '/updateBook',
    params:data
  })
}

export async function deleteBookById(id){
  return await HRequest.post({
    url: URL + '/deleteBook',
    params:id
  })
}

export async function addNewBook(data){
  return await HRequest.post({
    url: URL + '/addBook',
    params:data
  })
}

export async function getUserListBybookId(data){
  return await HRequest.post({
    url: URL + '/getUserListBybookId',
    params:data
  })
}

export async function getBookListByUserId(data){
  return await HRequest.post({
    url: URL + '/getBookListByUserId',
    params:data
  })
}