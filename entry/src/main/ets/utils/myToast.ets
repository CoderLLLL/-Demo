import promptAction from '@ohos.promptAction';

export default function MyToast(text:string){
  promptAction.showToast({
    message: text,
    duration: 3000 //3秒
  })
}

