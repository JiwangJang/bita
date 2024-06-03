"use client";

export default function Page() {
    return (
        <div className="m-auto max-w-[1200px] py-[40px] xl:px-0 px-[20px]">
            <p className="font-[900] text-[80px]">소개의 말</p>
            <p className="mt-[16px] text-[28px]">
                안녕하세요, 출장사진 저장소 개발자 장지왕입니다. 이 페이지에서는 왜 굳이 제시간 갈아 넣어가면서 이런
                서비스를 만들었는가에 대해 설명할 예정입니다.
            </p>
            <p className="mt-[24px] text-[32px] font-[900]">만든 이유</p>
            <p className="mt-[12px] text-[24px] leading-[1.3em]">
                우리 공무원들은 보안으로 인해 컴퓨터와 핸드폰간 연결이 되지 않아, 핸드폰에서 컴퓨터로 사진을 옮길때
                여러방법을 사용합니다. 흔히들 사용하는 방법들은 아래와 같죠.
                <div
                    className="border-blue-400 border-2 px-[12px] py-[16px] flex flex-col gap-[4px] my-[8px] rounded-xl 
                    w-fit bg-[#FFFFFF] text-[20px]"
                >
                    <p>- 공직자메일로 보낸다</p>
                    <p>- 네이버 카페 또는 블로그를 이용한다</p>
                    <p>- 정보 담당부서에 usb연결 신청을한다</p>
                </div>
                하지만 이런 방식의 문제점은 크게 두가지죠
                <div
                    className="border-blue-400 border-2 px-[12px] py-[16px] flex flex-col gap-[4px] my-[8px] rounded-xl 
                    w-fit bg-[#FFFFFF] text-[20px]"
                >
                    <p>- 내 핸드폰의 출장사진은 어차피 지워야한다</p>
                    <p>- 너무 귀찮다</p>
                </div>
                이게 은근 업무효율을 떨어뜨리는게, 사진전송 기다린다고 계속 기다려야하는데다가, 로그인하고 어쩌고 하튼
                귀찮습니다. 이게 저만 그런게 아니라 저희 시 다른 직원들도 귀찮다고 하는 글을 보고나서, 아 이거
                만들어야겠구나 싶었습니다.
            </p>
            <p className="mt-[24px] text-[32px] font-[900]">근데 비용은?</p>
            <p className="mt-[12px] text-[24px] leading-[1.3em]">
                아직까지는 서버를 빌려주는 회사에서 신규고객에 한해 주는 무료 사용량으로 버티곤있지만, 곧 한도초과
                예정입니다. 앞으로 예상되는 비용은 현재 사용자 기준(일일페이지뷰 250)으로는 달에 30달러(4만천원)의
                비용이 부과될 것으로 보입니다. 아마 나중에 사용자가 매우 많아지면, 광고를 달던지, 부분 유료서비스로의
                전환을 고려하고 있습니다.
            </p>
        </div>
    );
}
