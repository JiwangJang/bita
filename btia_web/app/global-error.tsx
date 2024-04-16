"use client";

function GloablError({ error, reset }: { error: Error & { digest?: string }; reset: () => void }) {
    return (
        <html>
            <body>
                <div>
                    <p>서버에서 에러발생</p>
                    <div className="fill-btn" onClick={() => reset()}>
                        다시시도
                    </div>
                </div>
            </body>
        </html>
    );
}

export default GloablError;
