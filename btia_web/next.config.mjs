/** @type {import('next').NextConfig} */

import withSerwistInit from "@serwist/next";

const config = {
    images: {
        remotePatterns: [
            {
                protocol: "https",
                hostname: "waterfacilitybucket.s3.ap-northeast-2.amazonaws.com",
                pathname: "/**",
            },
        ],
    },
};

const withSerwist = withSerwistInit({
    // Note: This is only an example. If you use Pages Router,
    // use something else that works, such as "service-worker/index.ts".
    swSrc: "app/sw.ts",
    swDest: "public/sw.js",
});

export default withSerwist(config);
