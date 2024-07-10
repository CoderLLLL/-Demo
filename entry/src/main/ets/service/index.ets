import HRequest from './config/origin.ts'
import {
  getBookListWithAdmin,
  getBookListByBookName,
  updateBookById,
  deleteBookById,
  addNewBook,
  getUserListBybookId,
  getBookListByUserId
} from './admin/adminRequest'

import{
  getBookListWithUser,
  userSubscribeBook,
  userUnSubscribeBook,
  getUserSubscribeById
} from './user/userRequest'

const URL = '/login'

export async function checkLogin(data?){
  return await HRequest.post({
    url:URL+'/login',
    params:data,
  })
}

export async function userRegister<resObj>(data?){
  return await HRequest.post({
    url:URL+'/addUser',
    params:data,
  })
}

export {
  getBookListWithAdmin,
  getBookListByBookName,
  updateBookById,
  deleteBookById,
  addNewBook,

  getBookListWithUser,
  userSubscribeBook,
  userUnSubscribeBook,
  getUserSubscribeById,
  getUserListBybookId,
  getBookListByUserId
}