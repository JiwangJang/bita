import { DeleteObjectCommand, S3Client } from "@aws-sdk/client-s3";
import { sql } from "@vercel/postgres";
import { NextResponse } from "next/server";

export async function GET() {
    try {
        const s3Client = new S3Client({
            credentials: {
                accessKeyId: process.env.AWS_ACCESS_KEY_ID as string,
                secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY as string,
            },
            region: process.env.S3_REGION,
        });
        const expired = await sql`SELECT * FROM btia WHERE date(created_at) < date(NOW()) - 7;`;
        const deletePromise = expired.rows.map(({ image_path }) => {
            return s3Client.send(new DeleteObjectCommand({ Bucket: process.env.S3_BUCKET, Key: image_path }));
        });

        await Promise.all(deletePromise);
        await sql`DELETE FROM btia WHERE date(created_at) < date(NOW()) - 7;`;
        console.log(`${deletePromise.length} deleted.`);
        return NextResponse.json({ success: true });
    } catch (error) {
        console.error(error);
        return NextResponse.json({ success: false });
    }
}
