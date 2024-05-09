/** @type {import('next').NextConfig} */
const config = {
    images: {
        unoptimized: true,
        remotePatterns: [
            {
                protocol: "https",
                hostname: "de9nqjthi7764.cloudfront.net",
                pathname: "/**",
            },
        ],
    },
};

export default config;
