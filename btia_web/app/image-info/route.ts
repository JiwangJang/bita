import { sql } from "@vercel/postgres";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req:NextRequest){
    const userCode = req.nextUrl.searchParams.get('userCode');
    const queryResult = await sql`SELECT * FROM btia WHERE user_code=${userCode};`;
    console.log(queryResult.rows);
    return NextResponse.json({success : true});
    
}