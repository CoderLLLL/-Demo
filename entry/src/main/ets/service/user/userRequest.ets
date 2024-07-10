import HRequest from '../config/origin.ts'
const URL = '/user'

export async function getBookListWithUser(){
  return await HRequest.get({
    url: URL + '/getBookListByUser'
  })
}

export async function userSubscribeBook(data) {
  return await HRequest.post({
    url: URL + '/userSubscribeBookById',
    params:data
  })
}

export async function userUnSubscribeBook(data) {
  return await HRequest.post({
    url: URL + '/userUnSubscribeBookById',
    params:data
  })
}

export async function getUserSubscribeById(data){
  return await HRequest.post({
    url: URL + '/getSubscribeList',
    params:data
  })
}