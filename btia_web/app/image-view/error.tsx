"use client";

function Error({ error, reset }: { error: Error; reset: () => void }) {
    console.log(error);
    return (
        <div>
            <p>서버에서 에러발생</p>
            <div>돌아가기</div>
        </div>
    );
}

export default Error;
