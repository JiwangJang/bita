/** @type {import('next').NextConfig} */
const config = {
    images: {
        unoptimized: true,
        remotePatterns: [
            {
                protocol: "https",
                hostname: "waterfacilitybucket.s3.ap-northeast-2.amazonaws.com",
                pathname: "/**",
            },
        ],
    },
};

export default config;
