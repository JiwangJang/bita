import { PutObjectCommand, S3Client } from "@aws-sdk/client-s3";
import { QueryResult, sql } from "@vercel/postgres";
import { cookies } from "next/headers";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
    try {
        const s3Client = new S3Client({
            credentials: {
                accessKeyId: process.env.AWS_ACCESS_KEY_ID as string,
                secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY as string,
            },
            region: process.env.S3_REGION,
        });
        const data = await req.formData();
        const userCode = req.nextUrl.searchParams.get("userCode");
        const createdAt = req.nextUrl.searchParams.get("createdAt");
        const imagePromise: Array<Promise<string>> = [...data].map(async ([_, imageFile]) => {
            const file = imageFile as File;
            const buffer = Buffer.from(await file.arrayBuffer());
            const KEY = `btia/${file.name}-${userCode}`;
            const command = new PutObjectCommand({
                Bucket: process.env.S3_BUCKET,
                Key: KEY,
                Body: buffer,
                ContentType: file.type,
            });
            await s3Client.send(command);
            return KEY;
        });
        const imageResult = await Promise.all(imagePromise);
        const queryPromise: Array<Promise<QueryResult>> = imageResult.map(
            (key) => sql`INSERT INTO btia(user_code, image_path, created_at) VALUES(${userCode}, ${key}, ${createdAt})`
        );
        await Promise.all(queryPromise);

        return NextResponse.json({ success: true }, { status: 200 });
    } catch (e) {
        console.log(e);
        return NextResponse.json({ success: false, Err: e });
    }
}
// 크론탭 이용해서 주기적으로 쿼리
// DELETE FROM `table` WHERE `wdate` < DATE_SUB(NOW(), INTERVAL 7 DAY)
