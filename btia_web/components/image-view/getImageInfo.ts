'use server'

export async function getImageInfo(userCode:string ){
    const data = await fetch(`/image-info?userCode=${userCode}`);
    const json = await data.json();
    return json;
}