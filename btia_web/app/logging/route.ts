import { initializeApp } from "firebase/app";
import { doc, getDoc, getFirestore, setDoc, updateDoc } from "firebase/firestore";
import { NextRequest, NextResponse } from "next/server";

export async function GET(req: NextRequest) {
    try {
        const searchParams = req.nextUrl.searchParams;
        const docId = searchParams.get("docId");
        const isFirstAccess = JSON.parse(searchParams.get("isFirstAccess") ?? "false");
        if (!docId) return NextResponse.json({ success: false });
        const firebaseConfig = {
            apiKey: process.env.FIREBASE_API_KEY,
            authDomain: process.env.FIREBASE_AUTH_DOMAIN,
            projectId: process.env.FIREBASE_PROJECT_ID,
            storageBucket: process.env.FIREBASE_STORAGE_BUCKET,
            messagingSenderId: process.env.FIREBASE_MESSAGING_SENDER_ID,
            appId: process.env.FIREBASE_APP_ID,
            measurementId: process.env.FIREBASE_MEASUREMENT_ID,
        };
        const app = initializeApp(firebaseConfig);
        const firestore = getFirestore(app);
        const visitorCheckDoc = doc(firestore, "btia", docId);
        const targetDoc = await getDoc(visitorCheckDoc);
        if (targetDoc.exists()) {
            const origin = targetDoc.data();
            if (isFirstAccess) {
                updateDoc(visitorCheckDoc, {
                    user: origin.user + 1,
                    page_view: origin.page_view + 1,
                });
            } else {
                updateDoc(visitorCheckDoc, {
                    page_view: origin.page_view + 1,
                });
            }
        } else {
            setDoc(visitorCheckDoc, {
                user: 1,
                page_view: 1,
            });
        }
        return NextResponse.json({ success: true });
    } catch (error) {
        console.log(error);
        return NextResponse.json({ success: false });
    }
}
