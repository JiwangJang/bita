import { NextResponse } from "next/server";

export function GET() {
    // 앱 최신버전 입력
    return NextResponse.json({ version: "0.1.0" });
}
