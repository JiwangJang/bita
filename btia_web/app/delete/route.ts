import { DeleteObjectCommand, S3Client } from "@aws-sdk/client-s3";
import { sql } from "@vercel/postgres";
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
        const json = await req.json();
        const s3Promises = json.map((path: string) => {
            return s3Client.send(new DeleteObjectCommand({ Bucket: process.env.S3_BUCKET, Key: path }));
        });
        const sqlPromises = json.map((path: string) => {
            return sql`DELETE FROM btia WHERE image_path=${path};`;
        });

        await Promise.all(s3Promises);
        await Promise.all(sqlPromises);

        return NextResponse.json({ success: true });
    } catch (error) {
        return NextResponse.json({ success: false });
    }
}
