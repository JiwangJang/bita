import { NextResponse } from "next/server";

export function GET() {
    return NextResponse.json({ version: "0.2.0" });
}
