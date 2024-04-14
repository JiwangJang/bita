import { PutObjectCommand, PutObjectCommandOutput, S3Client } from "@aws-sdk/client-s3";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
    const s3Client = new S3Client({
        credentials: {
            accessKeyId: process.env.AWS_ACCESS_KEY_ID as string,
            secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY as string,
        },
        region: process.env.S3_REGION,
    });
    const data = await req.formData();
    const userCode = req.nextUrl.searchParams.get("userCode");
    const imagePromise: Array<Promise<PutObjectCommandOutput>> = [];

    data.forEach(async (form) => {
        const file = form as File;
        const buffer = Buffer.from(await file.arrayBuffer());
        const command = new PutObjectCommand({
            Bucket: process.env.S3_BUCKET,
            Key: `btia/${file.name}-${userCode}`,
            Body: buffer,
            ContentType: file.type,
        });
        imagePromise.push(s3Client.send(command));
    });

    try {
        // await Promise.all(imagePromise);
        return NextResponse.json({ success: true }, { status: 200 });
    } catch (e) {
        console.log(e);
        return NextResponse.json({ success: false }, { status: 500 });
    }
}
