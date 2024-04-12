import { NextResponse } from "next/server";

export default async function POST(){
    return NextResponse.json({success : true});
}