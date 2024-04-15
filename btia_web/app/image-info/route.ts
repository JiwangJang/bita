import { sql } from "@vercel/postgres";
import { NextRequest, NextResponse } from "next/server";

type Data = [string, string[]];

export async function GET(req: NextRequest) {
    const userCode = req.nextUrl.searchParams.get("userCode");
    const queryResult = await sql`SELECT * FROM btia WHERE user_code=${userCode};`;
    const notFilteredData = queryResult.rows;
    const fileterdData = notFilteredData.reduce((acc, cur) => {
        const { created_at, image_path } = cur;
        if (!acc[created_at]) {
            acc[created_at] = [image_path];
        } else {
            acc[created_at].push(image_path);
        }
        return acc;
    }, {});
    const arrangedData = Object.entries(fileterdData).sort().reverse();

    return NextResponse.json({ success: true, result: arrangedData });
}
